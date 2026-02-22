package com.example.CareTag.Repos.Paitent;

import com.example.CareTag.Models.Paitent.ShippingDetails;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface ShippingDetailsRepo extends MongoRepository<ShippingDetails, Long> {
}
