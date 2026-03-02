package com.example.CareTag.Repos.common;

import com.example.CareTag.Models.common.Session;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SessionRepo extends MongoRepository<Session,String> {
}
