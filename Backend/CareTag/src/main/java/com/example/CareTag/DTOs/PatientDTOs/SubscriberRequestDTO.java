package com.example.CareTag.DTOs.PatientDTOs;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor

public class SubscriberRequestDTO {
    final String fullname;
   final String subscriptionType;
   final String phoneNumber;
   final String province;
   final String city;
   final String steetAddress;
   final String postalcode;
   final String paymentType;

}
