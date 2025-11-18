package com.example.CareTag.Repos;

import com.example.CareTag.Models.RefreshToken;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.Optional;

public interface RefreshTokenRepo  extends MongoRepository<RefreshToken,Long> {

    Optional<RefreshToken> findByToken(String token);
}
