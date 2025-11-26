package com.example.CareTag.controllers;

import com.example.CareTag.DTOs.*;
import com.example.CareTag.Services.AuthUtil;
import com.example.CareTag.Services.PasswordResetService;
import com.example.CareTag.Services.RefereshTokenService;
import com.example.CareTag.Services.AuthService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/auth")
public class AuthController {
private final AuthService authService;
private final RefereshTokenService refereshTokenService;
private final PasswordResetService passwordResetService;
private final AuthUtil authUtil;
    @PostMapping("/signup")
    public ResponseEntity<SignUpResponseDTO> signUp(
            @RequestBody SignUpRequestDTO signUpRequestDTO
            ) throws Exception {
        return authService.signUp(signUpRequestDTO);
    }
    @PostMapping("/login")
    public ResponseEntity<String> login(
            @RequestBody LoginRequestDTO loginRequestDTO
            )throws  Exception{
        return  authService.login(loginRequestDTO);
    }

    @PostMapping("/refresh")
    public ResponseEntity<RefreshTokenResponseDTO> refreshToken(
            @RequestBody String token
    ) throws Exception {
        return  refereshTokenService.refreshToken(token);
    }
    @PostMapping("/forgot-password/request-otp")
    public ResponseEntity<Void> requestOtp(@RequestBody ForgotPasswordRequest forgotPasswordRequest){
        passwordResetService.sendOtp(forgotPasswordRequest);
        return ResponseEntity.ok().build();

    }
    @PostMapping("/forgot-password/verify-otp")
    public ResponseEntity<ResetPasswordResponse> verfiyOtp(
            @RequestBody VerfiyOtpRequest verfiyOtpRequest
    ){
      ResetPasswordResponse token  =  passwordResetService.verfiyOTPAndGenerateToken(verfiyOtpRequest);
      return new ResponseEntity<>(token, HttpStatus.OK);


    }

    @PostMapping("/reset-password")
    public ResponseEntity<Void> resetPassword(
            @RequestBody ResetPasswordRequest resetPasswordRequest
    ){
        passwordResetService.ResetPassword(resetPasswordRequest);
        return  ResponseEntity.ok().build();
    }

    @GetMapping("/verify")
    public String confirmAccount (@RequestParam String token){
        try{
            authService.verification(token);
            return authUtil.getHtmlSuccessMessage();
        } catch (Exception e) {
            return  authUtil.getHtmlErrorMessage(e.toString());
        }
    }
    @PostMapping("/login-verify")
    public ResponseEntity<LoginResponseDTO> verifyLogin(
            @RequestBody OtpRequest otpRequest
    ){
        log.info("CONTROLLER OTP REQUEST"+otpRequest.getOtpCode());
        return authService.verifyLogin(otpRequest);
    }


}
