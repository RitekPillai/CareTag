package com.example.CareTag.DTOs;

import lombok.Data;

@Data
public class ResetPasswordRequest {
    String resetToken;
    String newPassword;
}
