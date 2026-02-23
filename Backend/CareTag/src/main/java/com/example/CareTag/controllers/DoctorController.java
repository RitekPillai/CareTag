package com.example.CareTag.controllers;

import com.example.CareTag.DTOs.DoctorDTOs.LoginRequest;
import com.example.CareTag.DTOs.DoctorDTOs.SignUpRequest;
import com.example.CareTag.DTOs.authDTOs.LoginRequestDTO;
import com.example.CareTag.Models.Doctor;
import com.example.CareTag.Services.doctorService.DoctorAuthService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
@Slf4j
@RestController()
@RequestMapping("/doctor")
@CrossOrigin(origins = "*", allowedHeaders = "*", methods = {RequestMethod.POST, RequestMethod.OPTIONS})
public class DoctorController
{
@Autowired
DoctorAuthService doctorAuthService;
    @GetMapping
    @PreAuthorize("hasRole('DOCTOR')")
    public String testingController(){
        return "hello";
    }


    @PostMapping("/signup")
    public ResponseEntity<?> signup(@RequestBody SignUpRequest signUpRequest){
        return doctorAuthService.signup(signUpRequest);


    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequestDTO loginRequestDTO){
        log.info("loginRequestDTO:{}",loginRequestDTO.getPassword());
        log.info(loginRequestDTO.getEmail());

        return doctorAuthService.login(loginRequestDTO);

    }



}
