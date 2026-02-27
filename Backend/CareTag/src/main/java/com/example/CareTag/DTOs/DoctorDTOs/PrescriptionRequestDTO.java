package com.example.CareTag.DTOs.DoctorDTOs;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import org.springframework.data.mongodb.core.mapping.Document;


import java.time.LocalDateTime;
import java.util.List;

@AllArgsConstructor
@Data
@Builder

public class PrecriptionRequestDTO {
    private final String careTagId;
    private  final String diagnosis;
    private final String notes;
    private final LocalDateTime validTill;
    private final int maxRefills;
    private final String status;
    private List<Medication> medications;



}
