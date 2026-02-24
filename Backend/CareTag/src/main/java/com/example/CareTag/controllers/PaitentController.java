package com.example.CareTag.controllers;

import com.example.CareTag.DTOs.PatientDTOs.BasicDataDTO;
import com.example.CareTag.DTOs.PatientDTOs.MedicalRecordResponseDTO;
import com.example.CareTag.DTOs.PatientDTOs.RegistrationRequestDTO;
import com.example.CareTag.DTOs.PatientDTOs.SubscriberRequestDTO;
import com.example.CareTag.Models.Paitent.Patient;
import com.example.CareTag.Repos.Paitent.PaitentRepo;
import com.example.CareTag.Services.PaitentServices.PatientService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/paitent")
public class PaitentController {
    @Autowired
    private PatientService paitentService;
    @Autowired
    private PaitentRepo paitentRepo;
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

    @PostMapping("/update-fcmToken")
    public ResponseEntity<?> updateFcmToken(@RequestBody Map<String, String> payload) {
        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        Patient patient = paitentRepo.findByEmail(email);

        if (patient != null) {
            patient.setFcmToken(payload.get("fcmToken"));
            paitentRepo.save(patient);
            return ResponseEntity.ok("Token updated successfully");
        }
        return ResponseEntity.status(404).body("Patient not found");
    }

}
