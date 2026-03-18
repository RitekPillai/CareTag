package com.example.CareTag.Services.PaitentServices;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

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

}
