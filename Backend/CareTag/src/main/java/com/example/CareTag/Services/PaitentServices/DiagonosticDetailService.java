package com.example.CareTag.Services.PaitentServices;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.geo.Distance;
import org.springframework.data.geo.Metrics;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.data.geo.Point;
import com.example.CareTag.DTOs.PatientDTOs.DiagonosticListDetails;
import com.example.CareTag.Models.Diagnostic.DiagnosticCenter;
import com.example.CareTag.Models.Paitent.Patient;
import com.example.CareTag.Models.common.User;
import com.example.CareTag.Repos.Diagnostic.DiagnosticRepo;
import com.example.CareTag.Repos.Paitent.PaitentRepo;
import com.example.CareTag.configs.SecurityConfig;

@Service

public class DiagonosticDetailService {

  @Autowired
  private PaitentRepo paitentRepo;

  @Autowired
  private DiagnosticRepo diagnosticRepo;

  public List<DiagonosticListDetails> getDiagonsitcList() {

    String email = SecurityContextHolder.getContext().getAuthentication().getName();
    Patient patient = paitentRepo.findByEmail(email);
    double radiusKm = 10000;
    double lon = patient.getLocation().getX();
    double latituge = patient.getLocation().getY();

    Point paitentLocation = new Point(lon, latituge);
    Distance distance = new Distance(radiusKm, Metrics.KILOMETERS);
    System.out.println(paitentLocation);
    System.out.println(distance);

    List<DiagnosticCenter> diagnosticCenters = diagnosticRepo.findByLocationNear(paitentLocation, distance);
    return diagnosticCenters.stream().map(diagonostic -> {
      return DiagonosticListDetails.builder().id(diagonostic.getId()).diagonosticName(diagonostic.getCenterName())
          .timing(diagonostic.getCenterPhone()).imageUrl(diagonostic.getCenterLogoUrl()).build();
    }).toList();
  }
}
