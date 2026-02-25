package com.example.CareTag.Repos.common;

import com.example.CareTag.Models.common.Link;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface LinkRepo extends MongoRepository<Link,String> {
    Link findByDocIdAndPaitentId(Long id, long id1);
}
