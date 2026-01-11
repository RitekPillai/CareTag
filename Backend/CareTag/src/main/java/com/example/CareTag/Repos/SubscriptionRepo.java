package com.example.CareTag.Repos;

import com.example.CareTag.Models.Subscription;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SubscriptionRepo extends MongoRepository<Subscription, Long> {
}
