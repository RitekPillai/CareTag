package com.example.CareTag.DTOs.diagonostic;

import lombok.Data;

@Data
public class AddTestRequestDTO {

  private String title;
  private String discription;
  private double price;
  private String iconType;

}
