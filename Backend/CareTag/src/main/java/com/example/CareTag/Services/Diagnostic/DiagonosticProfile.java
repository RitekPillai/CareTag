package com.example.CareTag.Services.Diagnostic;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Builder
@Data
@AllArgsConstructor

public class DiagonosticProfile {

  String profileImageUrl;
  String workingTime;
  String workLocation;
  double linkRate;
  String aboutLab;
  String workingDays;

}
