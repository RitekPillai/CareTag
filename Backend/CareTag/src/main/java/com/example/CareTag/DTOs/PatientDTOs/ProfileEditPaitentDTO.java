package com.example.CareTag.DTOs.PatientDTOs;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

@Data
@NoArgsConstructor
public class ProfileEditPaitentDTO {
     private String fullName;
       private String dob;
      private String gender;
      private  String height;
      private String bloodGroup;
      private String weight;
      private String allergies;
 private MultipartFile image;
}
