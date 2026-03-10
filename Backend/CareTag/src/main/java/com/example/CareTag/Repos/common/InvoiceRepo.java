package com.example.CareTag.Repos.common;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.example.CareTag.Models.common.Invoice;

@Repository
public interface InvoiceRepo extends MongoRepository<Invoice, String> {

  List<Invoice> findByPatientEmail(String email);
}
