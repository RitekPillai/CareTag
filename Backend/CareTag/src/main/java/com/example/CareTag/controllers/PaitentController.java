package com.example.CareTag.controllers;

import com.example.CareTag.DTOs.PatientDTOs.RegistrationRequestDTO;
import com.example.CareTag.Services.PaitentServices.PatientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/paitent")
public class PaitentController {
    @Autowired
    private PatientService paitentService;
    @PostMapping("/register")
    public String medicalRegistration(
           @RequestBody RegistrationRequestDTO requestDTOp
    )

    {
        return paitentService.registerMedicalRecord(requestDTOp);
    }
    @PostMapping("/record")
    public ResponseEntity< RegistrationRequestDTO> getMedicalRecord(
            @RequestBody String careTagId
    ){
        return paitentService.getMedicalRecord(careTagId);
    }

}
