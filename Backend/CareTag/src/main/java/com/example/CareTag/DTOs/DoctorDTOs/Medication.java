package com.example.CareTag.DTOs.DoctorDTOs;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.checkerframework.checker.units.qual.A;

@Data

@AllArgsConstructor
@NoArgsConstructor
public class Medication {
    private  String name;
    private String dosage;
    private String frequency;
    private  String duration;
    private int morning;
    private int afternoon;
    private int night;
    private String mealTiming;
}
