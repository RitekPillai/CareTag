package com.example.CareTag.Services.PaitentServices;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.example.CareTag.DTOs.PatientDTOs.MyDoctorDetailsDTO;
import com.example.CareTag.DTOs.PatientDTOs.MydoctorDetails;
import com.example.CareTag.Models.common.Link;
import com.example.CareTag.Models.common.User;
import com.example.CareTag.Models.doctor.Doctor;
import com.example.CareTag.Repos.common.LinkRepo;
import com.example.CareTag.Repos.doctor.DoctorRepo;

@Service
public class DoctorDetailService {

  @Autowired
  private LinkRepo linkRepo;

  @Autowired
  private DoctorRepo doctorRepo;

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

}
