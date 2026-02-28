package com.example.CareTag.DTOs.PatientDTOs;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Builder
@Data
@AllArgsConstructor
public class ProfileDataResponseDTO {
    private String fullName;
    private String bloodGroup;
    private String careTagId;
    private String imageUrl;
}
