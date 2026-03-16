package com.example.CareTag.DTOs.commonDTOs;

import java.time.LocalDateTime;

import com.example.CareTag.Models.type.ActivityType;
import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Builder;
import lombok.Data;

@Builder
@Data

public class RecentActivityDTO {
  private String title;
  @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "MMM dd")
  private LocalDateTime activityDate;
  private String discription;
  private ActivityType activityType;

}
