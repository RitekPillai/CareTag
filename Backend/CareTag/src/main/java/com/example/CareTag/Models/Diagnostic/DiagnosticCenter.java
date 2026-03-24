package com.example.CareTag.Models.Diagnostic;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.geo.GeoJsonPoint;
import org.springframework.data.mongodb.core.index.GeoSpatialIndexType;
import org.springframework.data.mongodb.core.index.GeoSpatialIndexed;
import org.springframework.data.mongodb.core.mapping.Document;

import com.example.CareTag.Services.Diagnostic.DiagonosticProfile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor
@Document(collection = "Diagnostic")
public class DiagnosticCenter {
  @Id
  final long id;
  final String name;
  final String email;
  final String mobile;
  final String centerName;
  final String centerEmail;
  final String centerPhone;
  final String Centeraddress;
  final String city;
  final String state;
  final String pinCode;
  final String website;
  final String accrediationType;
  final String accreditationNumber;
  final String gstNumber;
  final String registrationCertificationUrl;
  final String ownerIdProofUrl;
  final DiagonosticProfile diagonosticProfile;

  @GeoSpatialIndexed(type = GeoSpatialIndexType.GEO_2DSPHERE)
  private GeoJsonPoint location;

}
