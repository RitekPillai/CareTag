package com.example.CareTag.Models.common;

import com.example.CareTag.Models.type.Status;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.CompoundIndex;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.MongoId;
import org.springframework.data.redis.core.index.Indexed;

import java.time.LocalDateTime;
@Document(collection = "link")
@CompoundIndex(name = "doc_paitent_idx", def = "{'docId': 1, 'paitentId': 1}")
@Data
@Builder
@AllArgsConstructor
public class Link {

    @Id
    @MongoId
    private String linkId;
    @Indexed
    private Long docId;
    @Indexed
    private Long paitentId;
    private LocalDateTime expiryDate;


   private Status status;
}
