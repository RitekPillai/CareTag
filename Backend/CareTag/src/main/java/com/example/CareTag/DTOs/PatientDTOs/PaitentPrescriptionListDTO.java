package com.example.CareTag.DTOs.PatientDTOs;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class PaitentPrescriptionListDTO {

    private String prescriptionId;
    private  String doctorName;
    private String specialization;
    private String hospitalName;
    private LocalDateTime prescriptionDate;
    private String diagnosis;
    private String status;


}
