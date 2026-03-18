package com.example.CareTag.Models.doctor;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.MongoId;

import java.util.List;

@Document(collection = "doctor")
@Data
@AllArgsConstructor
@Builder
public class Doctor {
  @Id
  @MongoId
  private Long id;

  private String fullName;
  private String mobileNumber;
  private String email;
  private String imageUrl;

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
