package com.example.CareTag.Models.common;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "refreshTokenSequence")
public class refereshTokenDatabaseSeq {

    @Id
    private String id;

    private long seq;

}
