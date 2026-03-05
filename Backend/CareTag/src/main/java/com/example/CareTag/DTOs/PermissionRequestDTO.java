package com.example.CareTag.DTOs;

import lombok.Builder;
import lombok.Data;

@Data

@Builder
public class PermissionRequestDTO {

  private String docName;
  private String docId;
  private String hospitalName;
  private String careTagId;
  private String encounterId;
  private Boolean isRecord;
  private String publicKey;
}
