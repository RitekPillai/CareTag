package com.example.CareTag.DTOs.PatientDTOs;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

@AllArgsConstructor
@Data

public class ProfileEditPaitentDTO {
    final private String fullName;
     final  private String dob;
     final private String gender;
     final private  String height;
     final private String bloodGroup;
     final private String weight;
     final private String allergies;
 private MultipartFile image;
}
