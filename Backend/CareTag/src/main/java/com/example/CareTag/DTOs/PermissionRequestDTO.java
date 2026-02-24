package com.example.CareTag.DTOs;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data

@Builder
public class PermissionRequestDTO {
        private     String publicKey;
    private String docName;
    private String hospitalName;
    private String careTagId;
}
