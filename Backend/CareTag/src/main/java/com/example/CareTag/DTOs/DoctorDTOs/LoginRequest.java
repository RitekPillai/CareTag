package com.example.CareTag.DTOs.DoctorDTOs;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class LoginRequest {
    private String jwtToken;
    private String responseToken;
}
