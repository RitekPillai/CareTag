package com.example.CareTag.DTOs.PatientDTOs;

import java.time.LocalDateTime;
import java.util.Map;

import com.example.CareTag.Models.type.ActivityType;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Builder
@Data
@AllArgsConstructor
public class RecentActivityDto {
  private String id;
  private ActivityType activityType;
  private String title;
  private String description;
  private LocalDateTime activityDate;

  private Map<String, String> metadata;
}
