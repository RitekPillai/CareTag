package com.example.CareTag.DTOs.DoctorDTOs;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class PaitentSearchDTO {
    private String paitentName;
    private String careTagId;
}
