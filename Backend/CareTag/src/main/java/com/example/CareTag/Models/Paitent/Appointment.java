package com.example.CareTag.Models.Paitent;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.Transient;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.MongoId;

import java.time.LocalDateTime;

@Document(collection = "appointments")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Appointment {
  @Transient
  public static final String SEQUENCE_NAME = "appointment_sequence";

  @Id
  @MongoId
  private Long id;

  private Long doctorId;
  private Long patientId;
  private String appointmentDate; // Format: "yyyy-MM-dd"
  private String appointmentTime; // Format: "hh:mm a" (e.g., "09:30 AM")

  private String status; // PENDING, CONFIRMED, CANCELLED
  private LocalDateTime createdAt;
}
