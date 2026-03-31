package com.example.CareTag.controllers.Diagnostic;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.CareTag.DTOs.DoctorDTOs.LoginRequest;
import com.example.CareTag.DTOs.authDTOs.LoginRequestDTO;
import com.example.CareTag.DTOs.authDTOs.RefreshTokenResponseDTO;
import com.example.CareTag.DTOs.diagonostic.signupRequest;
import com.example.CareTag.Services.Diagnostic.diagnosticAuthService;
import com.example.CareTag.Services.AuthServices.RefereshTokenService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("diagnostic")
public class DiagnosticAuthController {

  @Autowired
  diagnosticAuthService diagnosticAuthService;

  @Autowired
  RefereshTokenService refereshTokenService;

  @PostMapping("/signUp")
  public void signUpRequest(@RequestBody signupRequest signupRequest) throws Exception {
    diagnosticAuthService.signUp(signupRequest);
  }

  @PostMapping("/login")
  public LoginRequest login(@RequestBody LoginRequestDTO loginRequestDTO) {
    return diagnosticAuthService.login(loginRequestDTO);

  }

  @PostMapping("/refresh")
  public ResponseEntity<RefreshTokenResponseDTO> refreshToken(@RequestBody String token) {
    try {
      log.info("Diagnostic refresh token request");
      return refereshTokenService.refreshToken(token);
    } catch (Exception e) {
      log.error("Diagnostic refresh token error: {}", e.getMessage());
      return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
    }
  }

}
