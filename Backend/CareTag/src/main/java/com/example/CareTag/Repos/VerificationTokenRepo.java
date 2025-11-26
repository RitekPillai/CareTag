package com.example.CareTag.Repos;

import com.example.CareTag.Models.VerificationToken;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.Optional;

public interface VerificationTokenRepo extends MongoRepository<VerificationToken,Long> {


    Optional<VerificationToken> findByToken(String Token);
}
