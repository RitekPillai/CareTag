package com.example.CareTag.DTOs.hospitalDTOs;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class HospitalLoginRequest {
  private String email;
  private String password;
}
