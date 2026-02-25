package com.example.CareTag.Models.common;


import lombok.Builder;
import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.CompoundIndex;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;

@Document(collection = "report_block")
@CompoundIndex(name = "doc_paitent_idx", def = "{'docId': 1, 'patientId': 1}")
@Data
@Builder
public class Report {
    @Id
    private final String id;

    private final Long docId;
    private final Long patientId;

    private final String reason;

    private final String  additionalInfo;

    private final LocalDateTime reportDate;

}
