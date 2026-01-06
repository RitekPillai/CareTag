package com.example.CareTag.DTOs.authDTOs;

import lombok.Data;

@Data
public class EmailVerificationDTO {
    String token;
    String email;
}
