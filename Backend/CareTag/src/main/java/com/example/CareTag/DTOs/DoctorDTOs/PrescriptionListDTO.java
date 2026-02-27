package com.example.CareTag.DTOs.DoctorDTOs;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class PrescriptionListDTO {
private  String prescriptionID;
private  String dignosis;
private  String paitentName;
private  int  refills;
private  List<Medication> medications;
private  String notes;
private  LocalDateTime creationDate;
private  LocalDateTime vaildTill;
private  String status;


}
