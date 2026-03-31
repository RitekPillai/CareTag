package com.example.CareTag.DTOs.hospitalDTOs;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class HospitalLoginResponse {
  private String jwtToken;
  private String refreshToken;
  private Long hospitalId;
  private String email;
  private String name;
}
