package com.example.CareTag.DTOs.PatientDTOs;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class MyDoctorDetailsDTO {
  private String imgUrl;
  private String docName;
  private String speclization;
  private int exp;
  private int links;
  private int fees;
  private String about;
  private String address;
  private String hospitalName;

  private double lat;
  private double longit;

}
