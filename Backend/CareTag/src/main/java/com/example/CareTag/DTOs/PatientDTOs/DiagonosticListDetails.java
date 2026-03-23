package com.example.CareTag.DTOs.PatientDTOs;

import lombok.Builder;
import lombok.Data;

@Data
@Builder

public class DiagonosticListDetails {
  Long id;
  String diagonosticName;
  String accrelationTypes;
  String timing;
  String imageUrl;
}
