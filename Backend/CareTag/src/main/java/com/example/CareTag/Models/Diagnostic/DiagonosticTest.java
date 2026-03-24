package com.example.CareTag.Models.Diagnostic;

import org.springframework.data.mongodb.core.mapping.Document;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Document(collection = "DiagonosticTests")
@AllArgsConstructor
@Builder
public class DiagonosticTest {

  private long diagonosticId;
  private String title;
  private String discription;
  private double price;
  private String iconType;

}
