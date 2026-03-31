package com.example.CareTag.Services.HospitalServices;

import com.example.CareTag.DTOs.hospitalDTOs.HospitalLoginRequest;
import com.example.CareTag.DTOs.hospitalDTOs.HospitalLoginResponse;
import com.example.CareTag.DTOs.hospitalDTOs.Signuprequest;
import com.example.CareTag.DTOs.hospitalDTOs.BranchDTO;
import com.example.CareTag.Models.common.RefreshToken;
import com.example.CareTag.Models.common.User;
import com.example.CareTag.Models.hospital.Branch;
import com.example.CareTag.Models.hospital.Hospital;
import com.example.CareTag.Models.type.AuthProvider;
import com.example.CareTag.Models.type.RoleType;
import com.example.CareTag.Repos.common.UserRepo;
import com.example.CareTag.Repos.Hospital.HospitalRepo;
import com.example.CareTag.Services.AuthServices.AuthUtil;
import com.example.CareTag.Services.AuthServices.DatabaseSeqService;
import com.example.CareTag.Services.AuthServices.RefereshTokenService;
import com.example.CareTag.Services.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.geo.GeoJsonPoint;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import lombok.extern.slf4j.Slf4j;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.concurrent.CompletableFuture;

@Slf4j
@Service
public class HospitalAuthService {
  @Autowired
  private UserRepo userRepo;

  @Autowired
  private PasswordEncoder passwordEncoder;

  @Autowired
  private HospitalRepo hospitalRepo;

  @Autowired
  private DatabaseSeqService databaseSeqService;

  @Autowired
  private AuthUtil authUtil;

  @Autowired
  private RefereshTokenService refereshTokenService;

  @Autowired
  private AuthenticationManager authenticationManager;

  @Autowired
  private FileService fileService;

  @Transactional
  public void signup(Signuprequest signUpRequest) throws Exception {
    log.info("Hospital signup request started for email: {}", signUpRequest.getEmail());

    if (userRepo.existsByEmail(signUpRequest.getEmail())) {
      log.warn("Email already registered: {}", signUpRequest.getEmail());
      throw new Exception("Email already registered");
    }

    long userId = databaseSeqService.generateSequence(User.SEQUENCE_NAME);
    User user = User.builder()
        .email(signUpRequest.getEmail())
        .password(passwordEncoder.encode(signUpRequest.getPassword()))
        .authProvider(AuthProvider.EMAIL)
        .role(Set.of(RoleType.HOSPITAL))
        .id(userId)
        .build();

    userRepo.save(user);

    try {
      log.info("Starting file uploads for hospital: {}", signUpRequest.getName());

      CompletableFuture<String> logoFuture = signUpRequest.getLogoUrl() != null
          ? CompletableFuture.supplyAsync(() -> fileService.uploadHospitalLogo(signUpRequest.getLogoUrl()))
          : CompletableFuture.completedFuture(null);

      CompletableFuture<String> registrationCertFuture = CompletableFuture.supplyAsync(
          () -> fileService.uploadHospitalRegistrationCertificate(signUpRequest.getRegistrationCertificateUrl()));

      CompletableFuture<String> clinicalLicenseFuture = CompletableFuture.supplyAsync(
          () -> fileService.uploadHospitalClinicalLicense(signUpRequest.getClinicalEstablishmentLicenseUrl()));

      CompletableFuture.allOf(logoFuture, registrationCertFuture, clinicalLicenseFuture).get();

      String logoUrl = logoFuture.get();
      String registrationCertUrl = registrationCertFuture.get();
      String clinicalLicenseUrl = clinicalLicenseFuture.get();

      log.info("File uploads completed successfully");

      GeoJsonPoint mainBranchLocation = new GeoJsonPoint(
          signUpRequest.getLongitude(),
          signUpRequest.getLatitude());

      List<Branch> branches = new ArrayList<>();
      if (signUpRequest.getBranches() != null && !signUpRequest.getBranches().isEmpty()) {
        for (BranchDTO branchDTO : signUpRequest.getBranches()) {
          GeoJsonPoint branchLocation = new GeoJsonPoint(
              branchDTO.getLongitude(),
              branchDTO.getLatitude());

          Branch branch = Branch.builder()
              .name(branchDTO.getName())
              .address(branchDTO.getAddress())
              .city(branchDTO.getCity())
              .state(branchDTO.getState())
              .pincode(branchDTO.getPincode())
              .phone(branchDTO.getPhone())
              .email(branchDTO.getEmail())
              .isMainBranch(branchDTO.getIsMainBranch() != null ? branchDTO.getIsMainBranch() : false)
              .location(branchLocation)
              .isActive(true)
              .build();

          branches.add(branch);
        }
      }

      Hospital hospital = Hospital.builder()
          .id(userId)
          .name(signUpRequest.getName())
          .email(signUpRequest.getEmail())
          .phone(signUpRequest.getPhone())
          .website(signUpRequest.getWebsite())
          .address(signUpRequest.getAddress())
          .city(signUpRequest.getCity())
          .state(signUpRequest.getState())
          .pincode(signUpRequest.getPincode())
          .logoUrl(logoUrl)
          .numberOfBeds(signUpRequest.getNumberOfBeds())
          .departments(signUpRequest.getDepartments())
          .registrationNumber(signUpRequest.getRegistrationNumber())
          .registrationCertificateUrl(registrationCertUrl)
          .accreditationNumber(signUpRequest.getAccreditationNumber())
          .accreditationType(signUpRequest.getAccreditationType())
          .clinicalEstablishmentLicenseUrl(clinicalLicenseUrl)
          .gstNumber(signUpRequest.getGstNumber())
          .verificationStatus("pending")
          .mainBranchLocation(mainBranchLocation)
          .branches(branches)
          .createdAt(LocalDateTime.now())
          .updatedAt(LocalDateTime.now())
          .isActive(true)
          .numOfLinks(0)
          .build();

      hospitalRepo.save(hospital);
      log.info("Hospital registration completed successfully for: {}", signUpRequest.getEmail());

    } catch (Exception e) {
      log.error("Hospital signup error: ", e);
      throw new Exception("Failed to create hospital: " + e.getMessage(), e);
    }
  }

  public ResponseEntity<HospitalLoginResponse> login(HospitalLoginRequest req) throws Exception {
    try {
      Authentication authentication = authenticationManager
          .authenticate(new UsernamePasswordAuthenticationToken(req.getEmail(), req.getPassword()));

      User user = (User) authentication.getPrincipal();

      if (!user.getRole().contains(RoleType.HOSPITAL)) {
        throw new Exception("User is not a hospital");
      }

      Hospital hospital = hospitalRepo.findByEmail(user.getEmail());
      if (hospital == null) {
        throw new Exception("Hospital not found");
      }

      String jwtToken = authUtil.generateToken(user);
      RefreshToken refreshToken = refereshTokenService.generateToken(user.getEmail());

      return ResponseEntity.ok(
          HospitalLoginResponse.builder()
              .jwtToken(jwtToken)
              .refreshToken(refreshToken.getToken())
              .hospitalId(hospital.getId())
              .email(hospital.getEmail())
              .name(hospital.getName())
              .build());
    } catch (Exception e) {
      throw new Exception("Login failed: " + e.getMessage());
    }
  }
}
