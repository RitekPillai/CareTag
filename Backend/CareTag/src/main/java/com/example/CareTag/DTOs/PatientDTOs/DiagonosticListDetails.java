package com.example.CareTag.DTOs.PatientDTOs;

import lombok.Builder;
import lombok.Data;

@Data
@Builder

public class DiagonosticListDetails {
  Long id;
  String diagonosticName;
  String timing;
  String imageUrl;
  String worktTime;
  String workDays;
  String locationAway;
}
