package com.example.CareTag.Repos.doctor;

import com.example.CareTag.Models.doctor.Precription;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PrecriptionRepo extends MongoRepository<Precription,String> {
}
