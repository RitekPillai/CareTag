package com.example.CareTag.controllers;

import com.example.CareTag.DTOs.*;
import com.example.CareTag.Services.RefereshTokenService;
import com.example.CareTag.Services.AuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/auth")
public class AuthController {
private final AuthService authService;
private final RefereshTokenService refereshTokenService;
    @PostMapping("/signup")
    public ResponseEntity<SignUpResponseDTO> signUp(
            @RequestBody SignUpRequestDTO signUpRequestDTO
            ) throws Exception {
        return authService.signUp(signUpRequestDTO);
    }
    @PostMapping("/login")
    public ResponseEntity<LoginResponseDTO> login(
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


}
