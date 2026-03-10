package com.example.CareTag.Services.PaitentServices;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.example.CareTag.DTOs.PatientDTOs.InvoiceListDTO;
import com.example.CareTag.Models.common.Invoice;
import com.example.CareTag.Repos.common.InvoiceRepo;

@Service
public class InvoiceService {

  @Autowired
  InvoiceRepo invoiceRepo;

  public List<InvoiceListDTO> getInvoices() {
    String email = SecurityContextHolder.getContext().getAuthentication().getName();

    List<Invoice> invoiceDataList = invoiceRepo.findByPatientEmail(email);
    return invoiceDataList.stream().map(invoice -> {
      return InvoiceListDTO.builder()
          .discription(invoice.getTitle())
          .docName(invoice.getDoctorName())
          .totalAmount(invoice.getTotalAmount())
          .hospitalName(invoice.getHosptialName())
          .invoiceId(invoice.getId())
          .transcationId(invoice.getTranscationNumber())
          .Status(invoice.getStatus()).build();

    }).toList();

  }

  public Invoice getInvoice(String invoiceId) throws Exception {
    Optional<Invoice> optionalInvoice = invoiceRepo.findById(invoiceId);
    if (optionalInvoice.isEmpty()) {
      throw new Exception("Oops no invoice found!!!");

    }
    return optionalInvoice.get();

  }
}
