package com.example.CareTag.DTOs.PatientDTOs;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class MydoctorDetails {
  private long docId;
  private String docName;
  private String speclization;
  private String imgUrl;

}
