package com.example.CareTag.DTOs.DoctorDTOs;

import lombok.Data;

import java.util.List;

@Data
public class SignUpRequest {
    private String email;
    private String password;
    private String fullName;
    private String mobileNumber;

    private String primaryQualification;
    private String specialization;
    private Integer yearsOfExperience;
    private List<String> languagesSpoken;

    private String medicalCouncilNumber;
    private String registeringAuthority;
    private Integer registrationYear;
    private String degreeCertificateUrl;
    private String idProofUrl;
    private String professionalPhotoUrl;

    private String clinicName;
    private String clinicAddress;
    private String city;
    private String state;
    private String consultationType;

    private String publicKey;
}