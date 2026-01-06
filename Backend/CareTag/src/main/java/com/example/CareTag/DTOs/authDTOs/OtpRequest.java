package com.example.CareTag.DTOs.authDTOs;

import lombok.Data;

@Data
public class OtpRequest {

    private String email;
    private String otpCode;
}
