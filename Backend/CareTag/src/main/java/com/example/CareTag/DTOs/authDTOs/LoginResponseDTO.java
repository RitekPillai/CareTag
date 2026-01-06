package com.example.CareTag.DTOs.authDTOs;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
  @AllArgsConstructor
public class LoginResponseDTO {
    String token;
    String username;
    String RefreshToken;
    boolean isNew;
    boolean isRegister;
}
