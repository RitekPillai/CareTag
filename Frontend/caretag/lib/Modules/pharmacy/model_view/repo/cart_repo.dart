import 'dart:convert';

import 'package:caretag/Modules/auth/model_view/service/AuthenticationService.dart';
import 'package:caretag/Modules/pharmacy/model/cart/cart_model.dart';
import 'package:caretag/Modules/pharmacy/model/cart/cart_summary.dart';
import 'package:flutter/foundation.dart';

class CartRepo {
  final String baseUrl =
      "https://uncatastrophic-nonobserving-marylyn.ngrok-free.dev/paitent/pharmacy";

  Future<CartSummary> getCartSummary(
    Authenticationservice authService,
    List<CartItem> items,
  ) async {
    try {
      final List<Map<String, dynamic>> itemsJson = items
          .map((item) => item.toJson())
          .toList();

      final response = await authService.post(
        Uri.parse("$baseUrl/cart/summary"),
        body: jsonEncode(itemsJson),
      );

      if (response.statusCode == 200) {
        return CartSummary.fromJson(jsonDecode(response.body));
      }
      throw Exception("Failed to get cart summary");
    } catch (e) {
      debugPrint("Error getting cart summary: $e");
      rethrow;
    }
  }
}
