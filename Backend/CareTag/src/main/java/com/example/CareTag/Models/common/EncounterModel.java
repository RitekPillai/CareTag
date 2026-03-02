package com.example.CareTag.Models.common;

import com.example.CareTag.Models.doctor.Prescription;
import com.example.CareTag.Models.type.Ecounterstatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;
import java.util.List;
@Data
@AllArgsConstructor
@Builder
@Document(collection = "encounter")
public class EncounterModel {
    @Id
    private String id;
    private Long patientId;
    private Long docId;

    private Ecounterstatus ecounterstatus;

    private String encrptedAESKey;

    private String envrpytedBlob;
    private List<String> xrayUrls;

    private Prescription prescription;
    private String invoice;


    private String discription;
    private LocalDateTime nestSessionDate;

    private LocalDateTime createdAt;
    private  LocalDateTime sealAt;




}
