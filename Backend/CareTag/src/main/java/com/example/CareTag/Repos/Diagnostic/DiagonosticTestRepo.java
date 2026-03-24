package com.example.CareTag.Repos.Diagnostic;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.example.CareTag.Models.Diagnostic.DiagonosticTest;

@Repository
public interface DiagonosticTestRepo extends MongoRepository<DiagonosticTest, Long> {

}
