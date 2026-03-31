package com.example.CareTag.Models.hospital;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.Transient;
import org.springframework.data.mongodb.core.geo.GeoJsonPoint;
import org.springframework.data.mongodb.core.index.GeoSpatialIndexType;
import org.springframework.data.mongodb.core.index.GeoSpatialIndexed;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.MongoId;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Document(collection = "hospital")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Hospital {
  @Transient
  public static final String SEQUENCE_NAME = "hospital_id_sequence";

  @Id
  @MongoId
  private Long id;

  private String name;
  private String email;
  private String phone;
  private String website;

  private String address;
  private String city;
  private String state;
  private String pincode;

  private String logoUrl;
  private Integer numberOfBeds;

  @Builder.Default
  private List<String> departments = new ArrayList<>();

  private String registrationNumber;
  private String registrationCertificateUrl;

  private String accreditationNumber;
  private String accreditationType;

  private String clinicalEstablishmentLicenseUrl;
  private String gstNumber;

  private String verificationStatus;
  private String verificationNotes;
  private LocalDateTime verifiedAt;

  @GeoSpatialIndexed(type = GeoSpatialIndexType.GEO_2DSPHERE)
  private GeoJsonPoint mainBranchLocation;

  @Builder.Default
  private List<Branch> branches = new ArrayList<>();

  private LocalDateTime createdAt;
  private LocalDateTime updatedAt;

  private Boolean isActive;
  private Integer numOfLinks;
}
