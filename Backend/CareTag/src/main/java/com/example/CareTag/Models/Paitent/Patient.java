package com.example.CareTag.Models.Paitent;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class Patient {
    private long id;/// same as user id

    private String fullName;

    private String careTagId;

    private String bloodGroup;

    private String dob;

    private String address;


}
