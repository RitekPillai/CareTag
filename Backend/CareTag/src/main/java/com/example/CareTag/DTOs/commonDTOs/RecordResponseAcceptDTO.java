package com.example.CareTag.DTOs.commonDTOs;

import com.example.CareTag.DTOs.PatientDTOs.BasicDataDTO;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Builder
@Data
@AllArgsConstructor
public class RecordResponseAcceptDTO {
    private String encounterId;
    private Long patientId;
    private String encrptedAesKey;
    private String ciphyerText;
    private String docEmail;
    private BasicDataDTO basicDataDTO;
}
