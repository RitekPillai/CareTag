package com.example.CareTag.controllers.Paitent;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.CareTag.DTOs.PatientDTOs.NearbyHospitalDTO;
import com.example.CareTag.Services.PaitentServices.HospitalDetailService;

@RestController
@RequestMapping("paitent")
public class HospitalDetailController {
  @Autowired
  private HospitalDetailService hospitalPatientService;

  @GetMapping("/nearby-hospitals")
  public List<NearbyHospitalDTO> getNearbyHospitals() {
    return hospitalPatientService.getNearbyHospitals();
  }
}
