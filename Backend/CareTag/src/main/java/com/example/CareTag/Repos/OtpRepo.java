package com.example.CareTag.Repos;

import com.example.CareTag.DTOs.OtpDTO;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.Optional;

public interface OtpRepo extends MongoRepository<OtpDTO,String> {
    Optional<OtpDTO> findByEmail(String email);
}
