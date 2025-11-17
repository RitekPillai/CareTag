package com.example.CareTag.Repos;

import com.example.CareTag.Models.User;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepo extends MongoRepository<User,Long> {

    User findByEmail(String email);
}
