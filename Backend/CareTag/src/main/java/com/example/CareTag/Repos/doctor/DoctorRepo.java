package com.example.CareTag.Repos.doctor;

import com.example.CareTag.Models.doctor.Doctor;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DoctorRepo extends MongoRepository<Doctor,Long> {
    Doctor findByEmail(String email);

    Doctor findByFullName(String docID);
}
