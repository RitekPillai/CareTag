package com.example.CareTag.Repos;

import com.example.CareTag.Models.ShippingDetails;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface ShippingDetailsRepo extends MongoRepository<ShippingDetails, Long> {
}
