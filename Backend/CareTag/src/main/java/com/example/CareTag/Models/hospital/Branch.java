package com.example.CareTag.Models.hospital;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.geo.GeoJsonPoint;
import org.springframework.data.mongodb.core.index.GeoSpatialIndexType;
import org.springframework.data.mongodb.core.index.GeoSpatialIndexed;

import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Branch {
  private String branchId;
  private String name;
  private String address;
  private String city;
  private String state;
  private String pincode;
  private String phone;
  private String email;
  private Boolean isMainBranch;

  @GeoSpatialIndexed(type = GeoSpatialIndexType.GEO_2DSPHERE)
  private GeoJsonPoint location;

  private Boolean isActive;

  public Branch(String name, String address, String city, String state, String pincode,
      String phone, String email, Boolean isMainBranch, GeoJsonPoint location) {
    this.branchId = UUID.randomUUID().toString();
    this.name = name;
    this.address = address;
    this.city = city;
    this.state = state;
    this.pincode = pincode;
    this.phone = phone;
    this.email = email;
    this.isMainBranch = isMainBranch;
    this.location = location;
    this.isActive = true;
  }
}
