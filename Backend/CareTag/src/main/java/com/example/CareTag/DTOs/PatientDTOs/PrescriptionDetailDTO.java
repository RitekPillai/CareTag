package com.example.CareTag.DTOs.PatientDTOs;

import com.example.CareTag.DTOs.DoctorDTOs.Medication;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class PrescriptionDetailDTO {

    String doctorName;
    String specialization;
    String hospitalName;
    String diagnosis;
    List<Medication> medications;
    String notes;

}
