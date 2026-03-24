package com.example.CareTag.Services.Diagnostic;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.example.CareTag.DTOs.diagonostic.AddTestRequestDTO;
import com.example.CareTag.Models.Diagnostic.DiagonosticTest;
import com.example.CareTag.Models.common.User;
import com.example.CareTag.Repos.Diagnostic.DiagonosticTestRepo;

@Service
public class DiagonosticService {

  @Autowired
  private DiagonosticTestRepo diagonosticTestRepo;

  public void setDiagonosticTest(
      AddTestRequestDTO req) {

    User id = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

    DiagonosticTest diagonosticTest = DiagonosticTest.builder().diagonosticId(id.getId()).title(req.getTitle())
        .discription(req.getDiscription()).price(req.getPrice()).iconType(req.getIconType()).build();
    diagonosticTestRepo.save(diagonosticTest);

  }

}
