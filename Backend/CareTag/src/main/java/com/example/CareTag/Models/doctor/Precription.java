package com.example.CareTag.Models.doctor;

import com.example.CareTag.DTOs.DoctorDTOs.Medication;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;
import java.util.List;

@Document(collection = "patient_prescription")
@AllArgsConstructor
@Data
@Builder
public class Precription {

    @Id
    private String id;
    private final Long patientId;
    private final Long doctorId;
    private  final String diagnosis;
    private final String notes;
    private final LocalDateTime validTill;
    private final int maxRefills;
    private final String status;
    private final List<Medication> medications;
    private final  LocalDateTime createdAt;
    private final  LocalDateTime updatedAt;

}
