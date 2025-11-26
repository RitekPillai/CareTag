package com.example.CareTag.DTOs;

import lombok.Data;

@Data
public class VerfiyOtpRequest {
    String email;
    String otp;
}
