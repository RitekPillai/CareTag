package com.example.CareTag.DTOs;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@Data
@NoArgsConstructor
public class VerifyResponse {


      String token;
    String username;
    String RefreshToken;
}
