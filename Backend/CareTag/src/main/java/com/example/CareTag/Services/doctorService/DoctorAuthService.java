package com.example.CareTag.Services.doctorService;

import com.example.CareTag.DTOs.DoctorDTOs.LoginRequest;
import com.example.CareTag.DTOs.DoctorDTOs.SignUpRequest;
import com.example.CareTag.DTOs.authDTOs.LoginRequestDTO;
import com.example.CareTag.Models.doctor.Doctor;
import com.example.CareTag.Models.common.RefreshToken;
import com.example.CareTag.Models.common.User;
import com.example.CareTag.Models.type.AuthProvider;
import com.example.CareTag.Models.type.RoleType;
import com.example.CareTag.Repos.common.UserRepo;
import com.example.CareTag.Repos.doctor.DoctorRepo;
import com.example.CareTag.Services.FileService;
import com.example.CareTag.Services.AuthServices.AuthUtil;
import com.example.CareTag.Services.AuthServices.DatabaseSeqService;
import com.example.CareTag.Services.AuthServices.RefereshTokenService;
import org.springframework.beans.factory.annotation.Value;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.geo.GeoJsonPoint;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Set;
import java.util.concurrent.CompletableFuture;

@Service

public class DoctorAuthService {
  @Autowired
  UserRepo userRepo;
  @Autowired
  PasswordEncoder passwordEncoder;

  @Autowired
  DoctorRepo doctorRepo;

  @Autowired
  DatabaseSeqService databaseSeqService;

  @Autowired
  AuthUtil authUtil;

  @Autowired
  RefereshTokenService refereshTokenService;

  @Autowired
  AuthenticationManager authenticationManager;

  @Value("${azure.storage.container-name}")
  private String containerName;

  @Value("${azure.storage.public.doctor.container-name}")
  private String doctorPublicContainerName;

  @Value("${azure.storage.private.doctor.container-name}")
  private String doctorPrivateContainerName;

  @Autowired
  private FileService fileService;

  @Transactional
  public void signup(SignUpRequest signUpRequest) throws Exception {
    if (userRepo.existsByEmail(signUpRequest.getEmail())) {
      throw new Exception("Email already logged in");

    }
    long userId = databaseSeqService.generateSequence(User.SEQUENCE_NAME);
    User user = User.builder()
        .email(signUpRequest.getEmail())
        .password(passwordEncoder.encode(signUpRequest.getPassword()))
        .authProvider(AuthProvider.EMAIL)
        .role(Set.of(RoleType.DOCTOR))
        .id(userId)
        .build();

    userRepo.save(user);
    try {
      CompletableFuture<String> degreeFuture = CompletableFuture.supplyAsync(() -> fileService
          .uploadBase64Image(signUpRequest.getDegreeCertificateUrl(), "degree", doctorPrivateContainerName));

      CompletableFuture<String> idProofFuture = CompletableFuture.supplyAsync(
          () -> fileService.uploadBase64Image(signUpRequest.getIdProofUrl(), "idProof", doctorPrivateContainerName));
      CompletableFuture<String> photoFuture = CompletableFuture.supplyAsync(() -> fileService
          .uploadBase64Image(signUpRequest.getProfessionalPhotoUrl(), "profile", doctorPublicContainerName));

      CompletableFuture.allOf(degreeFuture, idProofFuture, photoFuture);
      String degreeUrl = degreeFuture.get();
      String idProofUrl = idProofFuture.get();
      String photoUrl = photoFuture.get();

      GeoJsonPoint clinicLocation = new GeoJsonPoint(signUpRequest.getLongitude(), signUpRequest.getLatitude());

      Doctor doctor = Doctor.builder()
          .fullName(signUpRequest.getFullName())
          .publicKey(signUpRequest.getPublicKey())
          .email(signUpRequest.getEmail())
          .mobileNumber(signUpRequest.getMobileNumber())
          .primaryQualification(signUpRequest.getPrimaryQualification())
          .specialization(signUpRequest.getSpecialization())
          .yearsOfExperience(signUpRequest.getYearsOfExperience())
          .languagesSpoken(signUpRequest.getLanguagesSpoken())
          .medicalCouncilNumber(signUpRequest.getMedicalCouncilNumber())
          .registeringAuthority(signUpRequest.getRegisteringAuthority())
          .registrationYear(signUpRequest.getRegistrationYear())
          .degreeCertificateUrl(degreeUrl)
          .idProofUrl(idProofUrl)
          .clinicName(signUpRequest.getClinicName())
          .clinicAddress(signUpRequest.getClinicAddress())
          .location(clinicLocation)
          .city(signUpRequest.getCity())
          .state(signUpRequest.getState())
          .imageUrl(photoUrl)
          .consultationType(signUpRequest.getConsultationType())
          .id(userId).build();
      System.out.println(doctor.getLocation());
      doctorRepo.save(doctor);

    } catch (Exception e) {
      System.out.println(e.toString());
    }
  }

  public ResponseEntity<?> login(LoginRequestDTO req) {
    Authentication authentication = authenticationManager
        .authenticate(new UsernamePasswordAuthenticationToken(req.getEmail(), req.getPassword()));
    User user = (User) authentication.getPrincipal();

    String jwtToken = authUtil.generateToken(user);
    RefreshToken refreshToken = refereshTokenService.generateToken(user.getEmail());

    return ResponseEntity.ok(
        LoginRequest.builder()
            .jwtToken(jwtToken)
            .email(req.getEmail())
            .responseToken(refreshToken.getToken())
            .build());

  }
}
