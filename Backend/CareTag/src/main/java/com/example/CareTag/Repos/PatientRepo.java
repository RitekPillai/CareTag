package com.example.CareTag.Repos;

import com.example.CareTag.Models.Patient;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface PatientRepo extends MongoRepository<Patient,Long> {
    boolean existsByCareTagId(String newId);
    Patient findByCareTagId(String newId);

}
