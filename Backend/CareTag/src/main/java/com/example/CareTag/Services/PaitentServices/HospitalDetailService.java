package com.example.CareTag.Services.PaitentServices;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.geo.Circle;
import org.springframework.data.geo.Distance;
import org.springframework.data.geo.Metrics;
import org.springframework.data.geo.Point;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.example.CareTag.DTOs.PatientDTOs.NearbyHospitalDTO;
import com.example.CareTag.Models.Paitent.Patient;
import com.example.CareTag.Models.hospital.Hospital;
import com.example.CareTag.Repos.Hospital.HospitalRepo;
import com.example.CareTag.Repos.Paitent.PaitentRepo;

@Service
public class HospitalDetailService {

  @Autowired
  private PaitentRepo paitentRepo;

  @Autowired
  private HospitalRepo hospitalRepo;

  public List<NearbyHospitalDTO> getNearbyHospitals() {
    // 1. Get current patient location
    String email = SecurityContextHolder.getContext().getAuthentication().getName();
    Patient patient = paitentRepo.findByEmail(email);

    double patientLon = patient.getLocation().getX();
    double patientLat = patient.getLocation().getY();

    final Point point = new Point(patientLon, patientLat);
    Distance searchRadius = new Distance(15, Metrics.KILOMETERS); // 15km radius
    Circle searchArea = new Circle(point, searchRadius);

    // 2. Fetch hospitals within radius (using your existing repo method)
    List<Hospital> nearbyHospitals = hospitalRepo.findByMainBranchLocationWithin(searchArea);

    // 3. Map to DTO and calculate distance
    return nearbyHospitals.stream().map(hospital -> {
      double actualDistanceKm = calculateHaversineDistance(
          patientLat, patientLon,
          hospital.getMainBranchLocation().getY(),
          hospital.getMainBranchLocation().getX());

      double roundedDistance = Math.round(actualDistanceKm * 10.0) / 10.0;

      // Limiting departments for UI (max 3)
      List<String> displayDepts = hospital.getDepartments();
      if (displayDepts != null && displayDepts.size() > 3) {
        displayDepts = displayDepts.subList(0, 3);
      }

      return NearbyHospitalDTO.builder()
          .id(hospital.getId())
          .name(hospital.getName())
          .imageUrl(hospital.getLogoUrl())
          .distance(roundedDistance + " km")
          // Defaulting to 4.5 and true as per your UI since they aren't in your DB model
          // yet
          .rating(4.5)
          .isOpen24_7(true)
          .specialties(displayDepts)
          .build();
    }).toList();
  }

  // Reuse your existing haversine distance method here
  private double calculateHaversineDistance(double lat1, double lon1, double lat2, double lon2) {
    final int EARTH_RADIUS_KM = 6371;
    double latDistance = Math.toRadians(lat2 - lat1);
    double lonDistance = Math.toRadians(lon2 - lon1);
    double a = Math.sin(latDistance / 2) * Math.sin(latDistance / 2)
        + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2))
            * Math.sin(lonDistance / 2) * Math.sin(lonDistance / 2);
    double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return EARTH_RADIUS_KM * c;
  }

}
