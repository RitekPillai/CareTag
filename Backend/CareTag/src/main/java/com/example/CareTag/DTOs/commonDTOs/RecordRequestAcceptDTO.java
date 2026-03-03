package com.example.CareTag.DTOs.commonDTOs;

import lombok.Builder;
import lombok.Data;

@Builder
@Data

public class RecordRequestAcceptDTO {
    private String docId;
    private String encounterId;
    private String aesCrptedkey;

}
