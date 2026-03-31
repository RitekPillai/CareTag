package com.example.CareTag.DTOs.hospitalDTOs;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BranchDTO {
  private String branchId;
  private String name;
  private String address;
  private String city;
  private String state;
  private String pincode;
  private String phone;
  private String email;
  private Boolean isMainBranch;
  private Double latitude;
  private Double longitude;
  private Boolean isActive;
}
