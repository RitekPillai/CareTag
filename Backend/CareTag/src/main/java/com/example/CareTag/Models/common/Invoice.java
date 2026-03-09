package com.example.CareTag.Models.common;

import java.time.LocalDateTime;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.MongoId;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
@Document(collection = "Invoice")
public class Invoice {

  @Id
  @MongoId
  private String id;

  private String doctorName;

  private String hosptialName;

  private String patientName;

  private LocalDateTime invoiceDate;

  private double totalAmount;

  private double discount;

  private double taxRate;
}
