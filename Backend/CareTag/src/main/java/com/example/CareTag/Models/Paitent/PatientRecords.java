package com.example.CareTag.Models.Paitent;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.Transient;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.MongoId;


@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Document(collection = "PatientsRecords")
public class PatientRecords {
    @Transient
    public static final String SEQUENCE_NAME = "user_id_sequence";

    @MongoId
    @Id
    private long id;///for ther paitent side fetchings
    @Indexed(unique = true)
    private String careTagId;/// for the doctor side fetching

    private String cipherText;
    private String iv;
    private String mac;
    private String wrappedKey;
    private String rsaPublickey;

}