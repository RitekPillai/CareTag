package com.example.CareTag.controllers;

import com.example.CareTag.DTOs.*;
import com.example.CareTag.Models.User;
import com.example.CareTag.Services.RefereshTokenService;
import com.example.CareTag.Services.UserService;
import com.nimbusds.oauth2.sdk.token.RefreshToken;
import lombok.RequiredArgsConstructor;
import org.apache.coyote.Response;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import sun.misc.SignalHandler;

@RestController
@RequiredArgsConstructor
@RequestMapping("/auth")
public class UserController {
private final  UserService userService;
private final RefereshTokenService refereshTokenService;
    @PostMapping("/signup")
    public ResponseEntity<SignUpResponseDTO> signUp(
            @RequestBody SignUpRequestDTO signUpRequestDTO
            ) throws Exception {
        return userService.signUp(signUpRequestDTO);
    }
    @PostMapping("/login")
    public ResponseEntity<LoginResponseDTO> login(
            @RequestBody LoginRequestDTO loginRequestDTO
            )throws  Exception{
        return  userService.login(loginRequestDTO);
    }

    @PostMapping("/refresh")
    public ResponseEntity<RefreshTokenResponseDTO> refreshToken(
            @RequestBody String token
    ) throws Exception {
        return  refereshTokenService.refreshToken(token);
    }


}
