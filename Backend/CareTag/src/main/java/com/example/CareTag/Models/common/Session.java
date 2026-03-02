package com.example.CareTag.Models.common;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;
@Document(collection = "session")
@AllArgsConstructor
@Builder
public class Session {
    @Id
    private String sessionId;
    private long docId;
    private long patientId;
    private LocalDateTime sessionAt;
    private LocalDateTime nestSessionDate;
    private String discription;
}
