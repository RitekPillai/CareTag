package com.example.CareTag.Repos.Paitent;

import com.example.CareTag.Models.Paitent.Patient;
import com.example.CareTag.Models.doctor.Prescription;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PaitentRepo extends MongoRepository<Patient,Long> {
    boolean existsByCareTagId(String newId);
    Patient findByCareTagId(String careTagId);

    Patient findByEmail(String email);

    List<Patient> findByFullNameContainingIgnoreCase(String query);


}
