package com.example.CareTag.Services.PaitentServices;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.geo.Distance;
import org.springframework.data.geo.GeoResults;
import org.springframework.data.geo.Metrics;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.data.geo.Point;

import com.example.CareTag.DTOs.PatientDTOs.DiagonosticDetailDTO;
import com.example.CareTag.DTOs.PatientDTOs.DiagonosticListDetails;
import com.example.CareTag.Models.Diagnostic.DiagnosticCenter;
import com.example.CareTag.Models.Diagnostic.DiagonosticTest;
import com.example.CareTag.Models.Paitent.Patient;
import com.example.CareTag.Repos.Diagnostic.DiagnosticRepo;
import com.example.CareTag.Repos.Diagnostic.DiagonosticTestRepo;
import com.example.CareTag.Repos.Paitent.PaitentRepo;

@Service

public class DiagonosticDetailService {

  @Autowired
  private PaitentRepo paitentRepo;

  @Autowired
  private DiagnosticRepo diagnosticRepo;

  @Autowired
  private DiagonosticTestRepo diagonosticTestRepo;

  public List<DiagonosticListDetails> getDiagonsitcList() {

    String email = SecurityContextHolder.getContext().getAuthentication().getName();
    Patient patient = paitentRepo.findByEmail(email);

    double radiusKm = 10000;
    double lon = patient.getLocation().getX();
    double latituge = patient.getLocation().getY();

    Point paitentLocation = new Point(lon, latituge);
    Distance distance = new Distance(radiusKm, Metrics.KILOMETERS);

    GeoResults<DiagnosticCenter> geoResults = diagnosticRepo.findByLocationNear(paitentLocation, distance);

    return geoResults.getContent().stream().map(geoResult -> {

      DiagnosticCenter diagonostic = geoResult.getContent();

      double distanceInKm = geoResult.getDistance().getValue();

      String formattedDistance = String.format("%.1f km away", distanceInKm);

      return DiagonosticListDetails.builder()
          .id(diagonostic.getId())
          .diagonosticName(diagonostic.getCenterName())
          .timing(diagonostic.getCenterPhone())
          .imageUrl(diagonostic.getDiagonosticProfile().getProfileImageUrl())
          .worktTime(diagonostic.getDiagonosticProfile().getWorkingTime())
          .locationAway(formattedDistance)
          .build();

    }).toList();
  }

  public DiagonosticDetailDTO getDiagonsticDetail(Long id) {
    Optional<DiagnosticCenter> data = diagnosticRepo.findById(id);
    final DiagnosticCenter daigonosticCenter = data.get();
    List<DiagonosticTest> daigonosticData = diagonosticTestRepo.findByDiagonosticId(id);
    return DiagonosticDetailDTO.builder().diagonosticProfile(daigonosticCenter.getDiagonosticProfile())
        .diagonosticTest(daigonosticData)
        .centerName(daigonosticCenter.getCenterName())
        .build();

  }
}
