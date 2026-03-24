package com.example.CareTag.controllers.Diagnostic;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.CareTag.DTOs.diagonostic.AddTestRequestDTO;
import com.example.CareTag.Models.Diagnostic.DiagonosticTest;
import com.example.CareTag.Services.Diagnostic.DiagonosticService;

@RestController

@RequestMapping("diagnostic")
public class DiagonosticController {

  @Autowired
  private DiagonosticService diagonosticService;

  @PostMapping("/test/add")
  public void addTest(@RequestBody AddTestRequestDTO diagonosticTest) {
    diagonosticService.setDiagonosticTest(diagonosticTest);
  }

}
