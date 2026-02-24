package com.example.CareTag.Services;

import com.example.CareTag.DTOs.PermissionRequestDTO;
import com.example.CareTag.Models.Doctor;
import com.example.CareTag.Models.Paitent.Patient;
import com.example.CareTag.Repos.Paitent.PaitentRepo;
import com.example.CareTag.Repos.doctor.DoctorRepo;
import com.google.firebase.messaging.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
@Slf4j
@Service
public class LinkingService {

    @Autowired
    PaitentRepo paitentRepo;

    @Autowired
    DoctorRepo doctorRepo;

    public  void PermissionRequest(String careTagId){
        log.info(" careTagId:{}",careTagId);
        log.info(careTagId);
        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        Doctor doctor = doctorRepo.findByEmail(email);



        Patient patient =  paitentRepo.findByCareTagId(careTagId);
        log.info(" paitentId:{}",patient.getFullName());
        if(patient==null){
            throw new RuntimeException("patient not found");
        }
        PermissionRequestDTO permissionRequestDTO = PermissionRequestDTO.builder()
                .docName(doctor.getFullName())
                .hospitalName(doctor.getClinicName())
                .careTagId(careTagId)
                .publicKey(doctor.getPublicKey())
                .build();
        log.info(permissionRequestDTO.toString()+"careated");
        sendMessage(permissionRequestDTO, patient.getFcmToken());
log.info("done");




    }


    public void sendMessage(PermissionRequestDTO permissionRequestDTO,String  token) {
        Message message = Message.builder()
                .setToken(token)
                .putData("docName", permissionRequestDTO.getDocName())
                .putData("placeName", permissionRequestDTO.getHospitalName())
                .putData("publicKey", permissionRequestDTO.getPublicKey())
                .setNotification(Notification.builder()
                        .setTitle("Access Request")

                        .setBody("Dr. " + permissionRequestDTO.getDocName() + "wants to Access your data")

                        .build())
                .setAndroidConfig(AndroidConfig.builder()
                        .setPriority(AndroidConfig.Priority.HIGH)
                        .build())
                .build();
        try{
            FirebaseMessaging.getInstance().send(message);
        }catch (FirebaseMessagingException e){
            if (e.getMessagingErrorCode() == MessagingErrorCode.UNREGISTERED) {
                log.error("Token is no longer valid. Deleting from database...");
                // patient.setFcmToken(null);
                // paitentRepo.save(patient);
            } else {
                log.error("Failed to send FCM message", e);
            }
        }

    }
    }

