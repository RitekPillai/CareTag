package com.example.CareTag.Repos.Paitent;

import com.example.CareTag.Models.Paitent.Subscription;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SubscriptionRepo extends MongoRepository<Subscription, Long> {
}
