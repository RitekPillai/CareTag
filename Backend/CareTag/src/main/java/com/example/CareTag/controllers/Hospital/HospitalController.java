package com.example.CareTag.controllers.Hospital;

import com.example.CareTag.DTOs.hospitalDTOs.HospitalLoginRequest;
import com.example.CareTag.DTOs.hospitalDTOs.Signuprequest;
import com.example.CareTag.DTOs.authDTOs.RefreshTokenResponseDTO;
import com.example.CareTag.Services.HospitalServices.HospitalAuthService;
import com.example.CareTag.Services.AuthServices.RefereshTokenService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("/hospital")
@CrossOrigin(origins = "*", allowedHeaders = "*", methods = { RequestMethod.POST, RequestMethod.GET, RequestMethod.PUT,
    RequestMethod.OPTIONS })
public class HospitalController {
  @Autowired
  private HospitalAuthService hospitalAuthService;

  @Autowired
  private RefereshTokenService refereshTokenService;

  @GetMapping
  @PreAuthorize("hasRole('HOSPITAL')")
  public String testController() {
    return "Hospital controller working";
  }

  @PostMapping("/signup")
  public ResponseEntity<String> signup(@RequestBody Signuprequest signUpRequest) {
    try {
      hospitalAuthService.signup(signUpRequest);
      return ResponseEntity.ok("Hospital registered successfully. Pending verification.");
    } catch (Exception e) {
      log.error("Hospital signup error: {}", e.getMessage());
      return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
    }
  }

  @PostMapping("/login")
  public ResponseEntity<?> login(@RequestBody HospitalLoginRequest loginRequest) {
    try {
      log.info("Hospital login request for email: {}", loginRequest.getEmail());
      return hospitalAuthService.login(loginRequest);
    } catch (Exception e) {
      log.error("Hospital login error: {}", e.getMessage());
      return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(e.getMessage());
    }
  }

  @PostMapping("/refresh")
  public ResponseEntity<RefreshTokenResponseDTO> refreshToken(@RequestBody String token) {
    try {
      log.info("Hospital refresh token request");
      return refereshTokenService.refreshToken(token);
    } catch (Exception e) {
      log.error("Hospital refresh token error: {}", e.getMessage());
      return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
    }
  }
}
