package com.example.CareTag.DTOs.authDTOs;

import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor
@Data
public class LogResponseDTO {
    String token;
    String refreshToken;
    boolean isRegistered;
}
