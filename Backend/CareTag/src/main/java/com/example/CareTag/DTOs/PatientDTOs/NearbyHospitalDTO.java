package com.example.CareTag.DTOs.PatientDTOs;

import java.util.List;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class NearbyHospitalDTO {
  private Long id;
  private String name;
  private String imageUrl;
  private String distance; // e.g., "1.2 km"
  private Double rating; // Placeholder since rating isn't in your Hospital model yet
  private List<String> specialties; // Maps to your 'departments'
  private boolean isOpen24_7; // Placeholder based on UI
}
