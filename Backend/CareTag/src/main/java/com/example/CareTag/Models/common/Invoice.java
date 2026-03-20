package com.example.CareTag.Models.common;

import java.time.LocalDateTime;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.MongoId;

import com.example.CareTag.Models.type.InvoiceStatus;
import com.example.CareTag.Models.type.InvoiceType;
import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
@Document(collection = "Invoice")
public class Invoice {

  @Id
  @MongoId
  private String id;

  /// TODO:Need to impelemnt the doctor signature.

  private String doctorName;

  private String hosptialName;

  private String patientName;

  @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "MMM dd")
  private LocalDateTime invoiceDate;

  private Integer totalAmount;

  private double discount;

  private double taxRate;

  private String title;

  private InvoiceStatus status;

  private String transcationNumber;

  private String patientEmail;

  private InvoiceType invoiceType;

}
