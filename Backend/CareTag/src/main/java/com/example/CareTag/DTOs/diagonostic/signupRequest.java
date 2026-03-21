package com.example.CareTag.DTOs.diagonostic;

import lombok.Data;

@Data
public class signupRequest {
  String fullName;
  String email;
  String mobileNumber;
  String password;
  String centerName;
  String centerEmail;
  String centerAddress;
  String city;
  String state;
  String pincode;
  String website;
  String accreditationType;
  String accreditationNumber;
  String gstNumber;
  String registrationCertificationUrl;
  String ownerIdProofUrl;
  double latitude;
  double longitude;
  String centerLogoUrl;
  String centerMobileNumber;

}
