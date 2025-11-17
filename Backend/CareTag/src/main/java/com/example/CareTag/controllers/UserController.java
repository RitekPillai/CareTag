package com.example.CareTag.controllers;

import com.example.CareTag.DTOs.LoginRequestDTO;
import com.example.CareTag.DTOs.LoginResponseDTO;
import com.example.CareTag.DTOs.SignUpRequestDTO;
import com.example.CareTag.DTOs.SignUpResponseDTO;
import com.example.CareTag.Models.User;
import com.example.CareTag.Services.UserService;
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


}
