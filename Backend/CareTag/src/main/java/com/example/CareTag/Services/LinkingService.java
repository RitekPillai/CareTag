package com.example.CareTag.Services;

import com.example.CareTag.DTOs.BlockRequestDTO;
import com.example.CareTag.DTOs.PermissionRequestDTO;
import com.example.CareTag.Models.doctor.Doctor;
import com.example.CareTag.Models.Paitent.Patient;
import com.example.CareTag.Models.common.Link;
import com.example.CareTag.Models.common.Report;
import com.example.CareTag.Models.type.Status;
import com.example.CareTag.Repos.common.LinkRepo;
import com.example.CareTag.Repos.Paitent.PaitentRepo;
import com.example.CareTag.Repos.common.ReportRepo;
import com.example.CareTag.Repos.doctor.DoctorRepo;
import com.google.firebase.messaging.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Map;
import java.util.Optional;

@Slf4j
@Service
public class LinkingService {

  @Autowired
  PaitentRepo paitentRepo;

  @Autowired
  DoctorRepo doctorRepo;

  @Autowired
  LinkRepo linkRepo;

  @Autowired
  ReportRepo reportRepo;

  @Autowired
  SimpMessagingTemplate simpMessagingTemplate;

  public static boolean isLinkedVaild(Link link) {
    if (link.getStatus() == Status.APPROVED)
      return true;
    if (link.getStatus() == Status.EXPIRED)
      return false;
    if (link.getStatus() == Status.BLOCKED)
      return false;
    if (LocalDateTime.now().isAfter(link.getExpiryDate())) {
      return false;

    }
    return link.getStatus() == Status.APPROVED;
  }

  public void PermissionRequest(String careTagId) throws InterruptedException {
    log.info(" careTagId:{}", careTagId);
    log.info(careTagId);
    String email = SecurityContextHolder.getContext().getAuthentication().getName();
    Doctor doctor = doctorRepo.findByEmail(email);

    log.info(email);
    Patient patient = paitentRepo.findByCareTagId(careTagId);
    log.info(" paitentId:{}", patient.getFullName());

    Link isLinked = linkRepo.findByDocIdAndPaitentId(doctor.getId(), patient.getId());
    log.info(" isLinked:{}", isLinked);
    if (isLinked != null) {

      log.info("It is already linked there is no  need to link it");
      simpMessagingTemplate.convertAndSendToUser(email, "/queue/approval", Map.of("status", "ALREADY SCANNED"));
      return;

    }
    boolean isBlocked = reportRepo.existsByDocIdAndPatientId(doctor.getId(), patient.getId());
    if (isBlocked) {
      log.info("You have been blocked can not send request");
      return;
    }

    PermissionRequestDTO permissionRequestDTO = PermissionRequestDTO.builder()
        .docName(doctor.getFullName())
        .hospitalName(doctor.getClinicName())
        .docId(doctor.getEmail())
        .encounterId("")
        .careTagId(careTagId)
        .isRecord(false)
        .publicKey("")
        .build();
    log.info(permissionRequestDTO.toString() + "careated");
    sendMessage(permissionRequestDTO, patient.getFcmToken());
    log.info("done");

  }

  @Transactional
  public void createLink(String docId) {
    log.info("docId:{}", docId);

    Doctor doctor = doctorRepo.findByEmail(docId);

    log.info("inisde function");

    log.info("doctor:{}", doctor);
    String patientEmail = SecurityContextHolder.getContext().getAuthentication().getName();
    log.info("patientEmail:{}", patientEmail);
    Patient patient = paitentRepo.findByEmail(patientEmail);
    log.info("patient:{}", patient);
    Link exsistanceLink = linkRepo.findByDocIdAndPaitentId(doctor.getId(), patient.getId());
    log.info("exsistanceLink:{}", exsistanceLink);
    if (exsistanceLink != null) {
      exsistanceLink.setExpiryDate(LocalDateTime.now().plusDays(7));
      exsistanceLink.setStatus(Status.APPROVED);
      linkRepo.save(exsistanceLink);

      return;

    }
    int docLinkNumber = doctor.getNumOfLinks();
    doctor.setNumOfLinks(docLinkNumber++);
    doctorRepo.save(doctor);
    Link newLink = Link.builder()
        .docId(doctor.getId())
        .paitentId(patient.getId())
        .expiryDate(LocalDateTime.now().plusDays(7))
        .status(Status.APPROVED)
        .build();
    log.info("newLink:{}", newLink);
    Link save = linkRepo.save(newLink);
    log.info("save:{}", save);
    log.info("Link has been Established");
  }

  public void sendMessage(PermissionRequestDTO permissionRequestDTO, String token) {
    log.info("token:{}", token);
    Message message = Message.builder()
        .setToken(token)
        .putData("docName", permissionRequestDTO.getDocName())
        .putData("placeName", permissionRequestDTO.getHospitalName())
        .putData("docId", permissionRequestDTO.getDocId().toString())
        .putData("isRecord", permissionRequestDTO.getIsRecord().toString())
        .putData("encounterId", permissionRequestDTO.getEncounterId())
        .putData("publicKey", permissionRequestDTO.getPublicKey())
        .setNotification(Notification.builder()
            .setTitle("Access Request")

            .setBody("Dr. " + permissionRequestDTO.getDocName() + " wants to Access your data")

            .build())
        .setAndroidConfig(AndroidConfig.builder()
            .setPriority(AndroidConfig.Priority.HIGH)
            .build())
        .build();
    try {
      FirebaseMessaging.getInstance().send(message);
    } catch (FirebaseMessagingException e) {
      if (e.getMessagingErrorCode() == MessagingErrorCode.UNREGISTERED) {
        log.error("Token is no longer valid. Deleting from database...");

      } else {
        log.error("Failed to send FCM message", e);
      }
    }

  }

  public void blockDoctor(BlockRequestDTO blockrequestDTO) {
    log.info("Inside the function");
    String patientEmail = SecurityContextHolder.getContext().getAuthentication().getName();

    Patient patient = paitentRepo.findByEmail(patientEmail);

    log.info("Doctor:{}", blockrequestDTO.getDocID());
    /// TODO:Change it to findById in future
    Optional<Doctor> doctorData = doctorRepo.findById(Long.parseLong(blockrequestDTO.getDocID()));
    Doctor doctor = doctorData.get();

    boolean isReportExsist = reportRepo.existsByDocIdAndPatientId(doctor.getId(), patient.getId());
    if ((isReportExsist)) {
      log.info("Report has been Made Already");
      return;
    }
    Report report = Report.builder()
        .docId(doctor.getId())
        .patientId(patient.getId())
        .reason(blockrequestDTO.getReason())
        .additionalInfo(blockrequestDTO.getDescription())
        .reportDate(LocalDateTime.now())
        .build();
    reportRepo.save(report);
    log.info("Report Has been Saved SucessFully:{}", report);

  }
}
