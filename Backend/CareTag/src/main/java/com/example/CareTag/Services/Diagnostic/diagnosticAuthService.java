package com.example.CareTag.Services.Diagnostic;

import java.util.Set;
import java.util.concurrent.CompletableFuture;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.mongodb.core.geo.GeoJsonPoint;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.CareTag.DTOs.DoctorDTOs.LoginRequest;
import com.example.CareTag.DTOs.authDTOs.LoginRequestDTO;
import com.example.CareTag.DTOs.diagonostic.signupRequest;
import com.example.CareTag.Models.Diagnostic.DiagnosticCenter;
import com.example.CareTag.Models.common.RefreshToken;
import com.example.CareTag.Models.common.User;
import com.example.CareTag.Models.type.AuthProvider;
import com.example.CareTag.Models.type.RoleType;
import com.example.CareTag.Repos.Diagnostic.DiagnosticRepo;
import com.example.CareTag.Repos.common.UserRepo;
import com.example.CareTag.Services.FileService;
import com.example.CareTag.Services.AuthServices.AuthUtil;
import com.example.CareTag.Services.AuthServices.DatabaseSeqService;
import com.example.CareTag.Services.AuthServices.RefereshTokenService;

@Service
public class diagnosticAuthService {

  @Autowired
  UserRepo userRepo;

  @Autowired
  DiagnosticRepo diagnosticRepo;

  @Autowired
  DatabaseSeqService databaseSeqService;

  @Autowired
  PasswordEncoder passwordEncoder;

  @Autowired
  FileService fileService;

  @Autowired
  AuthenticationManager authenticationManager;

  @Autowired
  AuthUtil authUtil;

  @Autowired
  RefereshTokenService refereshTokenService;

  @Value("${azure.storage.public.diagonostic.container-name}")
  private String publicContainerName;

  @Value("${azure.storage.private.diagonostic.container-name}")
  private String privateContainerName;

  @Transactional
  public void signUp(signupRequest signupRequest) throws Exception {
    if (userRepo.existsByEmail(signupRequest.getEmail())) {
      throw new Exception("Email already logged in");

    }
    long userId = databaseSeqService.generateSequence(User.SEQUENCE_NAME);
    User user = User.builder()
        .email(signupRequest.getEmail())
        .password(passwordEncoder.encode(signupRequest.getPassword()))
        .authProvider(AuthProvider.EMAIL)

        .role(Set.of(RoleType.DIAGNOSTIC))
        .id(userId)
        .build();

    userRepo.save(user);
    try {
      CompletableFuture<String> idProof = CompletableFuture.supplyAsync(
          () -> fileService.uploadBase64Image(signupRequest.getOwnerIdProofUrl(), "idProof", privateContainerName));
      CompletableFuture<String> verificationId = CompletableFuture.supplyAsync(() -> fileService
          .uploadBase64Image(signupRequest.getRegistrationCertificationUrl(), "verification", privateContainerName));
      CompletableFuture<String> profilePic = CompletableFuture.supplyAsync(
          () -> fileService.uploadBase64Image(signupRequest.getCenterLogoUrl(), "logo", publicContainerName));

      CompletableFuture.allOf(idProof, verificationId, profilePic);
      String idProofUrl = idProof.get();
      String verficiationIdUrl = verificationId.get();
      String profilePicUrl = profilePic.get();

      GeoJsonPoint diagonsticLocation = new GeoJsonPoint(signupRequest.getLongitude(), signupRequest.getLatitude());

      DiagnosticCenter diagnosticCenter = DiagnosticCenter.builder().name(signupRequest.getFullName())
          .id(userId)
          .email(signupRequest.getEmail()).mobile(signupRequest.getMobileNumber())
          .centerName(signupRequest.getCenterName()).centerEmail(signupRequest.getCenterEmail())
          .centerPhone(signupRequest.getCenterMobileNumber()).Centeraddress(signupRequest.getCenterAddress())
          .city(signupRequest.getCity()).state(signupRequest.getState()).pinCode(signupRequest.getPincode())
          .website(signupRequest.getWebsite()).accrediationType(signupRequest.getAccreditationType())
          .accreditationNumber(signupRequest.getAccreditationNumber()).gstNumber(signupRequest.getGstNumber())
          .centerLogoUrl(profilePicUrl)
          .registrationCertificationUrl(verficiationIdUrl).ownerIdProofUrl(idProofUrl).location(diagonsticLocation)
          .build();

      diagnosticRepo.save(diagnosticCenter);
    } catch (Exception e) {
      System.out.println(e.toString());
    }
  }

  public LoginRequest login(LoginRequestDTO loginRequestDTO) {

    Authentication authentication = authenticationManager
        .authenticate(
            new UsernamePasswordAuthenticationToken(loginRequestDTO.getEmail(), loginRequestDTO.getPassword()));
    User user = (User) authentication.getPrincipal();

    String jwtToken = authUtil.generateToken(user);
    RefreshToken refreshToken = refereshTokenService.generateToken(user.getEmail());

    return LoginRequest.builder()
        .jwtToken(jwtToken)
        .email(loginRequestDTO.getEmail())
        .responseToken(refreshToken.getToken())
        .build();

  }
}
