package com.example.CareTag.DTOs.PatientDTOs;

import java.time.LocalDateTime;

import com.example.CareTag.Models.type.InvoiceStatus;
import com.example.CareTag.Models.type.InvoiceType;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
@lombok.Builder
public class InvoiceListDTO {
  private String invoiceId;
  private String discription;
  private String docName;
  private Integer totalAmount;
  private String hospitalName;
  private String transcationId;
  private InvoiceStatus Status;
  private LocalDateTime invoiceDate;
  private InvoiceType invoiceType;
}
