package com.example.CareTag.Models.doctor;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "patient_prescription")
@AllArgsConstructor
@Data
@Builder
public class Prescription {

  @Id
  private String id;
  private final Long patientId;
  private final Long doctorId;
  private String encryptedData;

}
