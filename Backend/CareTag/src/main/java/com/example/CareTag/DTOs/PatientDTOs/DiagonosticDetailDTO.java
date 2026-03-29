package com.example.CareTag.DTOs.PatientDTOs;

import java.util.List;

import com.example.CareTag.Models.Diagnostic.DiagonosticTest;
import com.example.CareTag.Services.Diagnostic.DiagonosticProfile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor
public class DiagonosticDetailDTO {
  final String centerName;
  final DiagonosticProfile diagonosticProfile;
  final List<DiagonosticTest> diagonosticTest;

}
