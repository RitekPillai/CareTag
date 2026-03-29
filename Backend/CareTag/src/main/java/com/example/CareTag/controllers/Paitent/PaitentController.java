package com.example.CareTag.controllers.Paitent;

import com.example.CareTag.DTOs.PatientDTOs.*;
import com.example.CareTag.DTOs.commonDTOs.RecentActivityDTO;
import com.example.CareTag.DTOs.commonDTOs.RecordRequestAcceptDTO;
import com.example.CareTag.DTOs.commonDTOs.RecordResponseAcceptDTO;
import com.example.CareTag.Models.Paitent.Patient;
import com.example.CareTag.Repos.Paitent.PaitentRepo;
import com.example.CareTag.Services.PaitentServices.PatientService;
import com.example.CareTag.Services.RecordService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/paitent")
public class PaitentController {
  @Autowired
  private PatientService paitentService;
  @Autowired
  private PaitentRepo paitentRepo;

  @Autowired
  private SimpMessagingTemplate simpMessagingTemplate;

  @Autowired
  private RecordService recordService;

  @PostMapping("/register")
  public String medicalRegistration(
      @RequestBody RegistrationRequestDTO requestDTOp)

  {

    return paitentService.registerMedicalRecord(requestDTOp);
  }

  @GetMapping("/profile")
  public ResponseEntity<ProfileDataResponseDTO> getProfileData() {
    return paitentService.getProfileData();
  }

  @PostMapping("/record")
  public ResponseEntity<MedicalRecordResponseDTO> getMedicalRecord(

  ) {

    return paitentService.getMedicalRecord();
  }

  @PostMapping("/subscripiton")
  public void setSubscriber(
      @RequestBody SubscriberRequestDTO subscriber) {
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

  @GetMapping("/doctors")
  public ResponseEntity<?> getDoctors() {

    return paitentService.getDoctors();
  }

  @GetMapping("/prescription/list")
  public List<PaitentPrescriptionListDTO> getAllPrescriptions() {
    return paitentService.getAllPrescription();
  }

  @PostMapping("/prescription")
  public PrescriptionDetailDTO getPrescriptionDetail(@RequestBody String prescriptionId) throws Exception {
    return paitentService.getPrescriptionDetails(prescriptionId);

  }

  @PostMapping(value = "/update", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
  public void profileEdit(@ModelAttribute ProfileEditPaitentDTO dto) throws Exception {

    paitentService.updateProfilePage(dto);

  }

  @PostMapping("/record/accept")
  public void recordAccept(@RequestBody RecordRequestAcceptDTO dto) {

    log.info(dto.toString());
    RecordResponseAcceptDTO recordResponseAcceptDTO = recordService.recordAccept(dto);
    // id is email
    simpMessagingTemplate.convertAndSendToUser(recordResponseAcceptDTO.getDocEmail(), "/queue/record/approval",
        recordResponseAcceptDTO);

  }

  @PostMapping("/record/deny")
  public ResponseEntity<String> deny(@RequestBody Map<String, String> payload) {
    String docId = payload.get("docId");
    String encounterId = payload.get("encounterId");
    recordService.denyRequest(encounterId);

    simpMessagingTemplate.convertAndSendToUser(
        docId,
        "/queue/record/approval",
        Map.of("status", "DENIED"));
    return ResponseEntity.ok("Denial pushed to doctor");
  }

  @GetMapping("/timeline")
  public ResponseEntity<List<RecentActivityDTO>> getTimeline() {
    return ResponseEntity.ok(paitentService.getPatientTimeline());
  }

}
