package com.example.CareTag.DTOs;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class EncounterSealDTO {
    private String encounterId;
    private Long patientId;
    private Long doctorId;
    private String invoiceId;
    private String prescriptionId;
    private List<String> fileUrls;
}
