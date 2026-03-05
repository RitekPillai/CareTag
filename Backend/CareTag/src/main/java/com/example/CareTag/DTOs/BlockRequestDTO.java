package com.example.CareTag.DTOs;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class BlockRequestDTO {

  final private String docID;
  final private String reason;
  final private String description;
}
