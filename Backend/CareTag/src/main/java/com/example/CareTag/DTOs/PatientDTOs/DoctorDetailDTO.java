package com.example.CareTag.DTOs.PatientDTOs;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class DoctorDetailDTO {
    private Long id;
    private String doctorName;
    private String hospitalName;
    private String specialization;
}
