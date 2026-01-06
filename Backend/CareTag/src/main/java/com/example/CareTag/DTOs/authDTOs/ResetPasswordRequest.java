package com.example.CareTag.DTOs.authDTOs;

import lombok.Data;

@Data
public class ResetPasswordRequest {
    String resetToken;
    String newPassword;
}
