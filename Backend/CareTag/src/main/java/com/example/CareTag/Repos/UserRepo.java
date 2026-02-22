package com.example.CareTag.Repos;

import com.example.CareTag.Models.User;
import com.example.CareTag.Models.type.AuthProvider;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepo extends MongoRepository<User,Long> {

    User findByEmail(String email);
    User findByUsername(String username);

    Optional<User> findByProviderIdAndAuthProvider(String providerid, AuthProvider authProvider);

    Optional<User> findByPasswordResetToken(String token);

    boolean existsByEmail(String email);
}
