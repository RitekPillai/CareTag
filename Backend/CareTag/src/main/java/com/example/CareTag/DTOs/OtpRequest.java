package com.example.CareTag.DTOs;

import lombok.Data;

@Data
public class OtpRequest {

    private String email;
    private String otpCode;
}
