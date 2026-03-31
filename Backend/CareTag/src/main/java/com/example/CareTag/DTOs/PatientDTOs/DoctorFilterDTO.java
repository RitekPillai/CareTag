package com.example.CareTag.DTOs.PatientDTOs;

import lombok.Data;

@Data
public class DoctorFilterDTO {
  private String specialization;
  private String city;
  private Integer minExperience;
  private Integer maxConsultationFee;
  private String searchKeyword;
}
