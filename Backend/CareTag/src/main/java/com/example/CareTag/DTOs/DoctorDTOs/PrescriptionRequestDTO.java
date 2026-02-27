package com.example.CareTag.DTOs.DoctorDTOs;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


import java.time.LocalDateTime;
import java.util.List;

@AllArgsConstructor
@Data
@Builder
@NoArgsConstructor

public class PrescriptionRequestDTO {
    private  String careTagId;
    private   String diagnosis;
    private  String notes;
    private  LocalDateTime validTill;
    private  int maxRefills;
    private  String status;
    private List<Medication> medications;
    private   LocalDateTime createdAt;
    private   LocalDateTime updatedAt;
    private  String paitentName;
    private  String doctorName;
    private  String speclization;
    private  String clinicName;


}
