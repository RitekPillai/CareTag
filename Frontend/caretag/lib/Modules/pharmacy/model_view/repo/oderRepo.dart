import 'dart:convert';

import 'package:caretag/Modules/auth/model_view/service/AuthenticationService.dart';
import 'package:caretag/Modules/pharmacy/model/homepage/offer_model.dart';
import 'package:caretag/Modules/pharmacy/model/order/order_list_item.dart';
import 'package:caretag/Modules/pharmacy/model/order/order_model.dart';
import 'package:flutter/foundation.dart';

class Oderrepo {
  final String baseUrl =
      "https://uncatastrophic-nonobserving-marylyn.ngrok-free.dev/paitent/pharmacy";

  Future<Order> createOrder(
    Authenticationservice authService, {
    required List<Map<String, dynamic>> items,
    required Map<String, dynamic> deliveryAddress,
    String? deliveryInstructions,
    String? prescriptionUrl,
    required String paymentMethod,
    String? promoCode,
  }) async {
    try {
      final Map<String, dynamic> requestBody = {
        'items': items,
        'deliveryAddress': deliveryAddress,
        if (deliveryInstructions != null)
          'deliveryInstructions': deliveryInstructions,
        if (prescriptionUrl != null) 'prescriptionUrl': prescriptionUrl,
        'paymentMethod': paymentMethod,
        if (promoCode != null) 'promoCode': promoCode,
      };

      final response = await authService.post(
        Uri.parse("$baseUrl/orders"),
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return Order.fromJson(jsonDecode(response.body));
      }
      throw Exception("Failed to create order");
    } catch (e) {
      debugPrint("Error creating order: $e");
      rethrow;
    }
  }

  Future<List<OrderListItem>> getMyOrders(
    Authenticationservice authService,
  ) async {
    try {
      final response = await authService.get(Uri.parse("$baseUrl/orders"));
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((e) => OrderListItem.fromJson(e)).toList();
      }
      throw Exception("Failed to load orders");
    } catch (e) {
      debugPrint("Error getting orders: $e");
      rethrow;
    }
  }

  Future<Order> getOrderDetail(
    Authenticationservice authService,
    String orderId,
  ) async {
    try {
      final response = await authService.get(
        Uri.parse("$baseUrl/orders/$orderId"),
      );
      if (response.statusCode == 200) {
        return Order.fromJson(jsonDecode(response.body));
      }
      throw Exception("Failed to load order detail");
    } catch (e) {
      debugPrint("Error getting order detail: $e");
      rethrow;
    }
  }

  Future<PromoCodeValidation> validatePromoCode(
    Authenticationservice authService,
    String code,
    double orderAmount,
  ) async {
    try {
      final Map<String, dynamic> requestBody = {
        'code': code,
        'orderAmount': orderAmount,
      };

      final response = await authService.post(
        Uri.parse("$baseUrl/orders/validate-promo"),
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        return PromoCodeValidation.fromJson(jsonDecode(response.body));
      }
      throw Exception("Failed to validate promo code");
    } catch (e) {
      debugPrint("Error validating promo code: $e");
      rethrow;
    }
  }
}
