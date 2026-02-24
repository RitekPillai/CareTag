package com.example.CareTag.Services;

import com.example.CareTag.DTOs.PermissionRequestDTO;
import com.example.CareTag.Models.Doctor;
import com.example.CareTag.Models.Paitent.Patient;
import com.example.CareTag.Models.common.Link;
import com.example.CareTag.Repos.LinkRepo;
import com.example.CareTag.Repos.Paitent.PaitentRepo;
import com.example.CareTag.Repos.doctor.DoctorRepo;
import com.google.firebase.messaging.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Slf4j
@Service
public class LinkingService {

    @Autowired
    PaitentRepo paitentRepo;

    @Autowired
    DoctorRepo doctorRepo;

    @Autowired
    LinkRepo linkRepo;

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
                .docEmail(doctor.getEmail())
                .careTagId(careTagId)
                .publicKey(doctor.getPublicKey())
                .build();
        log.info(permissionRequestDTO.toString()+"careated");
        sendMessage(permissionRequestDTO, patient.getFcmToken());
log.info("done");




    }
    @Transactional
public void createLink(String docEmail,String aesEncryptedKey){

        Doctor doctor = doctorRepo.findByEmail(docEmail);
        log.info("doctor:{}",doctor);
        String patientEmail = SecurityContextHolder.getContext().getAuthentication().getName();
        Patient patient = paitentRepo.findByEmail(patientEmail);
        log.info("patient:{}",patient);
        Link exsistanceLink =  linkRepo.findByDocIdAndPaitentId(doctor.getId(),patient.getId());
        log.info("exsistanceLink:{}",exsistanceLink);
        if(exsistanceLink!=null){
          exsistanceLink.setExpiryDate(LocalDateTime.now().plusDays(7));
          exsistanceLink.setEncryptedData(aesEncryptedKey);
          linkRepo.save(exsistanceLink);
          return;

        }

    Link newLink =  Link.builder()
            .docId(doctor.getId())
            .paitentId(patient.getId())
            .expiryDate(LocalDateTime.now().plusDays(7))
            .encryptedData(aesEncryptedKey)
            .build();
        log.info("newLink:{}",newLink );
Link  save = linkRepo.save(newLink);
log.info("save:{}",save);
log.info("Link has been Established");
}
    public void sendMessage(PermissionRequestDTO permissionRequestDTO,String  token) {
        log.info("token:{}",token);
        Message message = Message.builder()
                .setToken(token)
                .putData("docName", permissionRequestDTO.getDocName())
                .putData("placeName", permissionRequestDTO.getHospitalName())
                .putData("publicKey", permissionRequestDTO.getPublicKey())
                .putData("docEmail",permissionRequestDTO.getDocEmail())
                .setNotification(Notification.builder()
                        .setTitle("Access Request")

                        .setBody("Dr. " + permissionRequestDTO.getDocName() + " wants to Access your data")

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

