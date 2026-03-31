package com.example.CareTag.DTOs.PatientDTOs;

import lombok.Data;

@Data
public class BookAppointmentReq {
  private Long doctorId;
  private String date; // "yyyy-MM-dd"
  private String time; // "hh:mm a"
}
