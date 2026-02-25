package com.example.CareTag.Repos.common;

import com.example.CareTag.Models.common.Report;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface ReportRepo extends MongoRepository<Report,String> {
    Boolean existsByDocIdAndPatientId(Long id, long id1);
}
