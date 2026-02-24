package com.example.CareTag.Repos.Paitent;

import com.example.CareTag.Models.Paitent.PatientRecords;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PatientRecordsRepo extends MongoRepository<PatientRecords,Long> {

//    PatientRecords findByCareTagId(String newId);
}
