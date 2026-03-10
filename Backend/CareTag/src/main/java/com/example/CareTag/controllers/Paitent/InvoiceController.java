package com.example.CareTag.controllers.Paitent;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.CareTag.DTOs.PatientDTOs.InvoiceListDTO;
import com.example.CareTag.Services.PaitentServices.InvoiceService;

@RestController

@RequestMapping("/paitent")
public class InvoiceController {

  @Autowired
  private InvoiceService invoiceService;

  @GetMapping("invoice-list")
  public List<InvoiceListDTO> getInvoices() {

    return invoiceService.getInvoices();
  }

  /// TODO:Implement the GetInvoice(Single invoice detail)

}
