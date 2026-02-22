package com.example.CareTag.Repos.Paitent;

import com.example.CareTag.Models.Paitent.Patient;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface PaitentRepo extends MongoRepository<Patient,Long> {
    boolean existsByCareTagId(String newId);
}
