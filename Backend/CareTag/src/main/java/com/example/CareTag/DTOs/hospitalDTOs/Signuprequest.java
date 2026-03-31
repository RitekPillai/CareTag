package com.example.CareTag.DTOs.hospitalDTOs;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Signuprequest {

  private String name;
  private String email;
  private String password;
  private String phone;
  private String website;

  private String address;
  private String city;
  private String state;
  private String pincode;

  private Double latitude;
  private Double longitude;

  private String logoUrl;
  private Integer numberOfBeds;
  private List<String> departments;

  private String registrationNumber;
  private String registrationCertificateUrl;

  private String accreditationNumber;
  private String accreditationType;

  private String clinicalEstablishmentLicenseUrl;
  private String gstNumber;

  private List<BranchDTO> branches;

}
