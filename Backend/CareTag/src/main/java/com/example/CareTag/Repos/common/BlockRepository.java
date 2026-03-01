package com.example.CareTag.Repos.common;

import com.example.CareTag.Models.common.Block;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface BlockRepository extends MongoRepository<Block, String> {
    Optional<Block> findTopByOrderByIndexDesc();
}
