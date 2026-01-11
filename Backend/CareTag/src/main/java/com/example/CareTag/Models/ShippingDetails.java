package com.example.CareTag.Models;

import lombok.Builder;
import lombok.Data;
import org.springframework.data.annotation.Id;

@Data
@Builder
public class ShippingDetails {
    @Id
    private Long id;
    final String fullname;
    final String phoneNumber;
    final String province;
    final String city;
    final String streetaddress;
    final String postalCode;
    final String careTagID;

}
