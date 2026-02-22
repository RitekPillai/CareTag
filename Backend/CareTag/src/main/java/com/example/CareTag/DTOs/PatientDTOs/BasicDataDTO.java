package com.example.CareTag.DTOs.PatientDTOs;

import lombok.Builder;
import lombok.Data;
@Builder
@Data
public class BasicDataDTO {

    private String fullName;

    private String bloodGroup;

    private String dob;

    private String address;

    private String careTagId;
}
