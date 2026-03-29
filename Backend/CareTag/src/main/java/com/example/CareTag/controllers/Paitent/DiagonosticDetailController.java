package com.example.CareTag.controllers.Paitent;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.CareTag.DTOs.PatientDTOs.DiagonosticDetailDTO;
import com.example.CareTag.DTOs.PatientDTOs.DiagonosticListDetails;
import com.example.CareTag.Services.PaitentServices.DiagonosticDetailService;

@RestController
@RequestMapping("/patient/dg")
public class DiagonosticDetailController {

  @Autowired
  private DiagonosticDetailService diagonsticDetailSerivce;

  @GetMapping("/list")
  public List<DiagonosticListDetails> getDiagonsitcList() {
    return diagonsticDetailSerivce.getDiagonsitcList();
  }

  @PostMapping("/detail")
  public DiagonosticDetailDTO getDiagonosticDetail(@RequestBody long id) {
    return diagonsticDetailSerivce.getDiagonsticDetail(id);
  }

}
