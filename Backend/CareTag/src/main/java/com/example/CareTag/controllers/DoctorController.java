package com.example.CareTag.controllers;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController("/doctor")
public class DoctorController
{

    @GetMapping
    @PreAuthorize("hasRole('DOCTOR')")
    public String testingController(){
        return "hello";
    }

}
