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
import com.example.CareTag.Services.AuthServices.AuthUtil;
import com.example.CareTag.Services.AuthServices.DatabaseSeqService;
import com.example.CareTag.Services.AuthServices.RefereshTokenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Set;

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

  @Transactional
  public ResponseEntity<?> signup(SignUpRequest signUpRequest) {
    if (userRepo.existsByEmail(signUpRequest.getEmail())) {
      return ResponseEntity.badRequest().body("Email already exists");
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
        .degreeCertificateUrl(signUpRequest.getDegreeCertificateUrl())
        .idProofUrl(signUpRequest.getIdProofUrl())
        .professionalPhotoUrl(signUpRequest.getProfessionalPhotoUrl())
        .clinicName(signUpRequest.getClinicName())
        .clinicAddress(signUpRequest.getClinicAddress())
        .city(signUpRequest.getCity())
        .state(signUpRequest.getState())
        .consultationType(signUpRequest.getConsultationType())
        .id(userId).build();

    doctorRepo.save(doctor);

    return ResponseEntity.ok("Doctor has been Saved Successfully");

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
            .responseToken(refreshToken.getToken())
            .build());

  }
}
