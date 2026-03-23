package com.example.CareTag.Models.Paitent;

import org.springframework.data.mongodb.core.geo.GeoJsonPoint;
import org.springframework.data.mongodb.core.index.GeoSpatialIndexType;
import org.springframework.data.mongodb.core.index.GeoSpatialIndexed;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class Patient {
  private long id;/// same as user id

  private String fullName;

  private String careTagId;

  private String bloodGroup;

  private String dob;

  private String address;

  private String fcmToken;

  private String email;

  private String male;

  private String gender;

  private String height;

  private String weight;

  private String allergies;

  private String imageUrl;
  @GeoSpatialIndexed(type = GeoSpatialIndexType.GEO_2DSPHERE)
  private GeoJsonPoint location;

}
