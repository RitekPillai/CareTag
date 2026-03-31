package com.example.CareTag.controllers.Paitent;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.CareTag.DTOs.PatientDTOs.MyDoctorDetailsDTO;
import com.example.CareTag.DTOs.PatientDTOs.MydoctorDetails;
import com.example.CareTag.DTOs.PatientDTOs.NearByDoctorDTO;
import com.example.CareTag.Services.PaitentServices.DoctorDetailService;

@RestController
@RequestMapping("/paitent")
public class DoctorDetailController {

  @Autowired
  private DoctorDetailService doctorDetailService;

  @GetMapping("/mydoctor")
  public List<MydoctorDetails> getMydoctors() {

    return doctorDetailService.getMyDoctors();
  }

  @PostMapping("/mydoctor/detail")
  public MyDoctorDetailsDTO getMyDoctorDetails(
      @RequestParam long docId) throws Exception {
    return doctorDetailService.getMyDoctorDetails(docId);
  }

  @GetMapping("/nearby-doctor")
  public List<NearByDoctorDTO> getNearByTopRatedDoctor() {
    return doctorDetailService.getNearTopRatedDoctor();
  }

}
