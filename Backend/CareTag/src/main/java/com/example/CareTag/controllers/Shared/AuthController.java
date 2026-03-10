package com.example.CareTag.controllers.Shared;

import com.example.CareTag.DTOs.authDTOs.*;
import com.example.CareTag.Services.AuthServices.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.Map;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/auth")

public class AuthController {
  private final AuthService authService;
  private final TokenExchangeService tokenExchangeService;
  private final RefereshTokenService refereshTokenService;
  private final PasswordResetService passwordResetService;
  private final AuthUtil authUtil;

  @PostMapping("/exchange")
  public ResponseEntity<LoginResponseDTO> exchangeCode(
      @RequestBody Map<String, String> body) {
    String code = body.get("code");
    LoginResponseDTO responseDTO = tokenExchangeService.consumeCode(code);
    if (responseDTO == null) {
      return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
    }

    return ResponseEntity.ok(responseDTO);
  }

  //
  // @PostMapping("/doctor/signup")
  // public ResponseEntity<String> doctorSignUp(
  // @RequestBody SignUpRequestDTO signUpRequestDTO
  // ) throws Exception {
  // return authService.doctorSignUp(signUpRequestDTO);
  // }

  @PostMapping("/paitent/signup")
  public ResponseEntity<String> paietentSignUp(
      @RequestBody SignUpRequestDTO signUpRequestDTO) throws Exception {
    log.info("Paitent Sign Up Request Received" + signUpRequestDTO);
    return authService.patientSignUp(signUpRequestDTO);
  }

  @PostMapping("/paitent/login")
  public ResponseEntity<String> paittentLogin(
      @RequestBody LoginRequestDTO loginRequestDTO) throws Exception {
    return authService.login(loginRequestDTO);
  }

  @PostMapping("/refresh")
  public ResponseEntity<RefreshTokenResponseDTO> refreshToken(
      @RequestBody String token) throws Exception {
    return refereshTokenService.refreshToken(token);
  }
  // @PostMapping("/forgot-password/request-otp")
  // public ResponseEntity<Void> requestOtp(@RequestBody ForgotPasswordRequest
  // forgotPasswordRequest){
  // passwordResetService.sendOtp(forgotPasswordRequest);
  // return ResponseEntity.ok().build();
  //
  // }
  // @PostMapping("/forgot-password/verify-otp")
  // public ResponseEntity<ResetPasswordResponse> verfiyOtp(
  // @RequestBody VerfiyOtpRequest verfiyOtpRequest
  // ){
  // ResetPasswordResponse token =
  // passwordResetService.verfiyOTPAndGenerateToken(verfiyOtpRequest);
  // return new ResponseEntity<>(token, HttpStatus.OK);
  //
  //
  // }

  @PostMapping("/reset-password")
  public ResponseEntity<Void> resetPassword(
      @RequestBody ResetPasswordRequest resetPasswordRequest) {
    passwordResetService.ResetPassword(resetPasswordRequest);
    return ResponseEntity.ok().build();
  }

  @GetMapping("/verify")
  public String confirmAccount(@RequestParam String email, @RequestParam String token) {
    try {
      authService.verification(email, token);
      return authUtil.getHtmlSuccessMessage();
    } catch (Exception e) {
      return authUtil.getHtmlErrorMessage(e.toString());
    }
  }

  @PostMapping("/isValid")
  public ResponseEntity<VerifyResponse> isValid(
      @RequestBody String email) throws Exception {

    return authService.isMyEmailVerified(email);
  }

  @PostMapping("/login-verify")
  public ResponseEntity<LogResponseDTO> verifyLogin(
      @RequestBody OtpRequest otpRequest) {
    log.info("CONTROLLER OTP REQUEST" + otpRequest.getOtpCode());
    return authService.verifyLogin(otpRequest.getEmail(), otpRequest.getOtpCode());
  }

  @GetMapping("/me")
  public ResponseEntity<String> getCurrentUser(Principal principal) {
    return authService.getCurrentUser(principal);

  }

}
