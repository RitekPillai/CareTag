package com.example.CareTag.DTOs.PatientDTOs;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class MedicalRecordResponseDTO {
    private String ciphertext;
    private String iv;
    private String encryptedAesKey;
    private String mac;
    private String rsaPublicKey;
}
