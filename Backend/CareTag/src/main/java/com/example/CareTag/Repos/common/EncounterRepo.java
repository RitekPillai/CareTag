package com.example.CareTag.Repos.common;

import com.example.CareTag.Models.common.EncounterModel;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EncounterRepo extends MongoRepository<EncounterModel,String> {
    EncounterModel findByDocIdAndPatientId(Long id, long id1);
}
