package com.example.CareTag.controllers.Doctor;

import com.example.CareTag.DTOs.DoctorDTOs.PaitentSearchDTO;
import com.example.CareTag.DTOs.DoctorDTOs.PrescriptionRequestDTO;
import com.example.CareTag.DTOs.DoctorDTOs.PrescriptionListDTO;
import com.example.CareTag.DTOs.DoctorDTOs.SignUpRequest;
import com.example.CareTag.DTOs.authDTOs.LoginRequestDTO;
import com.example.CareTag.Models.common.EncounterModel;
import com.example.CareTag.Services.doctorService.DoctorAuthService;
import com.example.CareTag.Services.doctorService.DoctorService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController()
@RequestMapping("/doctor")
@CrossOrigin(origins = "*", allowedHeaders = "*", methods = { RequestMethod.POST, RequestMethod.OPTIONS })
public class DoctorController {
  @Autowired
  DoctorAuthService doctorAuthService;

  @Autowired
  SimpMessagingTemplate simpMessagingTemplate;

  @Autowired
  DoctorService doctorService;

  @GetMapping
  @PreAuthorize("hasRole('DOCTOR')")
  public String testingController() {
    return "hello";
  }

  @PostMapping("/signup")
  public void signup(@RequestBody SignUpRequest signUpRequest) throws Exception {
    doctorAuthService.signup(signUpRequest);

  }

  @PostMapping("/login")
  public ResponseEntity<?> login(@RequestBody LoginRequestDTO loginRequestDTO) {
    log.info("loginRequestDTO:{}", loginRequestDTO.getPassword());
    log.info(loginRequestDTO.getEmail());

    return doctorAuthService.login(loginRequestDTO);

  }
  //
  // @GetMapping("/paitents")
  // public ResponseEntity<?> getPaitents(){
  // return doctorService.getPaitents();
  // }

  @PostMapping("/search")
  public List<PaitentSearchDTO> paitentSearch(@RequestBody String query) {
    log.info("paitentSearch:{}", query);
    return doctorService.paitentSearch(query);

  }

  @PostMapping("/prescription")
  public void createPrescription(@RequestBody PrescriptionRequestDTO requestDTO) throws Exception {
    log.info("createPrescription:{}", requestDTO);
    doctorService.createPrecription(requestDTO);

  }

  @GetMapping("/prescription/list")
  public List<PrescriptionListDTO> getAllPrescription() {
    return doctorService.getPrecriptionList();
  }

  @PostMapping("/record/request")
  public void requestRecordAcess(@RequestBody String careTagId) {

    doctorService.requestRecordAccess(careTagId);

  }

  @PostMapping("/session-end")
  public void sessionEnd(@RequestBody EncounterModel encounterModel) throws Exception {
    doctorService.endSession(encounterModel);
  }

}
