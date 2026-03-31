package com.example.CareTag.Services.PaitentServices;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.geo.Circle;
import org.springframework.data.geo.Distance;
import org.springframework.data.geo.Metric;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.data.geo.Metrics;
import com.example.CareTag.DTOs.PatientDTOs.MyDoctorDetailsDTO;
import com.example.CareTag.DTOs.PatientDTOs.MydoctorDetails;
import com.example.CareTag.DTOs.PatientDTOs.NearByDoctorDTO;
import com.example.CareTag.Models.Paitent.Patient;
import com.example.CareTag.Models.common.Link;
import com.example.CareTag.Models.common.User;
import com.example.CareTag.Models.doctor.Doctor;
import com.example.CareTag.Repos.Paitent.PaitentRepo;
import com.example.CareTag.Repos.common.LinkRepo;
import com.example.CareTag.Repos.doctor.DoctorRepo;
import org.springframework.data.geo.Point;

@Service
public class DoctorDetailService {

  @Autowired
  private LinkRepo linkRepo;

  @Autowired
  private DoctorRepo doctorRepo;

  @Autowired
  private PaitentRepo paitentRepo;

  public List<MydoctorDetails> getMyDoctors() {

    User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    List<Link> getLinkedDoctors = linkRepo.findByPaitentId(user.getId());
    System.out.println(getLinkedDoctors);

    List<Doctor> doctors = getLinkedDoctors.stream().map(link -> {
      return doctorRepo.findById(link.getDocId()).get();
    }).toList();
    System.out.println(doctors);
    return doctors.stream().map(doctor -> {
      /// TODO:implement the imageUrl
      return MydoctorDetails.builder().docId(doctor.getId()).docName(doctor.getFullName())
          .speclization(doctor.getSpecialization()).imgUrl(doctor.getImageUrl()).build();
    }).toList();

  }

  public MyDoctorDetailsDTO getMyDoctorDetails(long docId) throws Exception {
    Optional<Doctor> optionalDoctor = doctorRepo.findById(docId);
    if (optionalDoctor.isEmpty()) {
      throw new Exception("Doctor not exsist");
    }
    Doctor doctor = optionalDoctor.get();
    return MyDoctorDetailsDTO.builder().docName(doctor.getFullName()).imgUrl(doctor.getImageUrl())
        .speclization(doctor.getSpecialization()).exp(doctor.getYearsOfExperience()).links(doctor.getNumOfLinks())
        .about(doctor.getAboutBio()).address(doctor.getClinicAddress()).hospitalName(doctor.getClinicName())
        .lat(doctor.getLocation().getY()).longit(doctor.getLocation().getX()).build();
  }

  public List<NearByDoctorDTO> getNearTopRatedDoctor() {
    Patient patient = paitentRepo.findByEmail(SecurityContextHolder.getContext().getAuthentication().getName());

    double patientLon = patient.getLocation().getX();
    double patientLat = patient.getLocation().getY();

    final Point point = new Point(patientLon, patientLat);
    Distance searchRadius = new Distance(10, Metrics.KILOMETERS);
    Circle searchArea = new Circle(point, searchRadius);

    List<Doctor> doctors = doctorRepo.findByLocationWithinOrderByNumOfLinksDesc(searchArea);

    return doctors.stream().map(doc -> {

      double actualDistanceKm = calculateHaversineDistance(
          patientLat, patientLon,
          doc.getLocation().getY(), doc.getLocation().getX());

      double roundedDistance = Math.round(actualDistanceKm * 10.0) / 10.0;

      return NearByDoctorDTO.builder()
          .imgUrl(doc.getImageUrl())
          .docName(doc.getFullName())
          .numLink(doc.getNumOfLinks())
          .specialities(doc.getSpecialization())
          // Assuming your DTO distance field takes a String or Double. Adjust as needed.
          .distance(String.valueOf(roundedDistance))
          .clincName(doc.getClinicName())
          .build();
    }).toList();
  }

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
