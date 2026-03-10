package com.example.CareTag.DTOs.PatientDTOs;

import java.time.LocalDateTime;

import com.example.CareTag.Models.type.InvoiceStatus;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
@lombok.Builder
public class InvoiceListDTO {
  private String invoiceId;
  private String discription;
  private String docName;
  private Double totalAmount;
  private String hospitalName;
  private String transcationId;
  private InvoiceStatus Status;
  private LocalDateTime invoiceDate;
}
