package com.example.CareTag.Repos.doctor;

import com.example.CareTag.Models.Doctor;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface DoctorRepo extends MongoRepository<Doctor,Long> {
}
