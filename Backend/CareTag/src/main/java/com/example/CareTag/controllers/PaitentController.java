package com.example.CareTag.controllers;

import com.example.CareTag.DTOs.PatientDTOs.BasicDataDTO;
import com.example.CareTag.DTOs.PatientDTOs.MedicalRecordResponseDTO;
import com.example.CareTag.DTOs.PatientDTOs.RegistrationRequestDTO;
import com.example.CareTag.DTOs.PatientDTOs.SubscriberRequestDTO;
import com.example.CareTag.Services.PaitentServices.PatientService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Slf4j
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

    @GetMapping("/profile")
    public ResponseEntity<BasicDataDTO>  getProfileData(){
        return  paitentService.getProfileData();
    }
    @PostMapping("/record")
    public ResponseEntity<MedicalRecordResponseDTO> getMedicalRecord(

    ){

        return paitentService.getMedicalRecord();
    }

    @PostMapping("/subscripiton")
    public void setSubscriber(
            @RequestBody SubscriberRequestDTO subscriber
            ){
         paitentService.setSubscriber(subscriber);
    }

}
