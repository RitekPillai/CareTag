package com.example.CareTag.DTOs.commonDTOs;

import com.example.CareTag.DTOs.PatientDTOs.BasicDataDTO;
import com.example.CareTag.Models.common.Invoice;
import com.example.CareTag.Models.doctor.Prescription;
import lombok.Builder;
import lombok.Data;
import org.springframework.data.annotation.Id;
import java.time.LocalDateTime;
import java.util.List;

@Builder
@Data
public class EncounterDTO {

  @Id
  private String id;
  private Long patientId;
  private Long docId;

  private String encrptedAESKey;

  private String envrpytedBlob;
  private List<String> xrayUrls;

  private BasicDataDTO basicDataDTO;

  private Prescription prescription;
  private Invoice invoice;

  private String discription;
  private LocalDateTime nestSessionDate;

  private LocalDateTime createdAt;
  private LocalDateTime sealAt;

}
