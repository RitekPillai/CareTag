package com.example.CareTag.DTOs.PatientDTOs;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Builder
@Data
@AllArgsConstructor
public class NearByDoctorDTO {

  String imgUrl;
  String docName;
  int numLink;
  String specialities;
  String distance;
  String clincName;
}
