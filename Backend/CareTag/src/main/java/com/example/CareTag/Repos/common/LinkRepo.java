package com.example.CareTag.Repos.common;

import com.example.CareTag.Models.common.Link;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface LinkRepo extends MongoRepository<Link,String> {
    Link findByDocIdAndPaitentId(Long id, long id1);

    List<Link> findByPaitentId(long id);

    List<Link> findByDocId(Long id);
}
