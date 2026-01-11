package com.example.CareTag.Models;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import org.springframework.data.annotation.Id;

import java.time.LocalDateTime;
@Data
@AllArgsConstructor
@Builder
public class Subscription {
@Id
    final Long subscriberId;
    final  String subscriptionType;
    final LocalDateTime whenPurchased;
    final String paymentType;
    final String subscriberName;
    final  LocalDateTime expirationDate;

}
