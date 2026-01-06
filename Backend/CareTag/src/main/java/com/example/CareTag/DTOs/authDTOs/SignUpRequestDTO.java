package com.example.CareTag.DTOs.authDTOs;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor

public class SignUpRequestDTO
{
    String username;
    String email;
    String password;
}
