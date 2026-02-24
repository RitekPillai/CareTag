package com.example.CareTag.Models.common;

import com.example.CareTag.Models.type.Status;
import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.MongoId;

import java.time.LocalDateTime;
@Document(collection = "doctor_paitent_link")
@Data
public class DoctorPaitentLink {
    @Id
    @MongoId
    private Long linkId;
    private Long docId;
    private long paitentId;
    private LocalDateTime expiryDate;

    private String encryptedData;

    private Status status;
}
