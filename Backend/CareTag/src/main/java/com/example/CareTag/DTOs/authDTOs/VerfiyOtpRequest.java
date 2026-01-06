package com.example.CareTag.DTOs.authDTOs;

import lombok.Data;

@Data
public class VerfiyOtpRequest {
    String email;
    String otp;
}
