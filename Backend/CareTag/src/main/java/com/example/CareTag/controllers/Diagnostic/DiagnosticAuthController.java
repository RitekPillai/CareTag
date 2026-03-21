package com.example.CareTag.controllers.Diagnostic;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.CareTag.DTOs.DoctorDTOs.LoginRequest;
import com.example.CareTag.DTOs.authDTOs.LoginRequestDTO;
import com.example.CareTag.DTOs.diagonostic.signupRequest;
import com.example.CareTag.Services.Diagnostic.diagnosticAuthService;

@RestController
@RequestMapping("diagnostic")
public class DiagnosticAuthController {

  @Autowired
  diagnosticAuthService diagnosticAuthService;

  @PostMapping("/signUp")
  public void signUpRequest(@RequestBody signupRequest signupRequest) throws Exception {
    diagnosticAuthService.signUp(signupRequest);
  }

  @PostMapping("/login")
  public LoginRequest login(@RequestBody LoginRequestDTO loginRequestDTO) {
    return diagnosticAuthService.login(loginRequestDTO);

  }

}
