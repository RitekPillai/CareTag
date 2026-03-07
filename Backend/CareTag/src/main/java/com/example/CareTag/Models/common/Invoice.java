package com.example.CareTag.Models.common;

import java.time.LocalDateTime;

import org.springframework.data.annotation.Id;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor

public class Invoice {

  @Id
  private String id;

  private String doctorName;

  private String hosptialName;

  private String patientName;

  private LocalDateTime invoiceDate;

  private double totalAmount;

  private double discount;

  private double taxRate;
}
