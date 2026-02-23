package com.example.CareTag.Repos.common;

import com.example.CareTag.Models.common.RefreshToken;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.Optional;

public interface RefreshTokenRepo  extends MongoRepository<RefreshToken,Long> {

    Optional<RefreshToken> findByToken(String token);
}
