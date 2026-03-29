import 'package:caretag/Modules/pharmacy/model/cart/cart_model.dart';

class CartSummary {
  final List<CartItem> items;
  final int itemCount;
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double discount;
  final double totalAmount;
  final bool requiresPrescription;

  CartSummary({
    required this.items,
    required this.itemCount,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.discount,
    required this.totalAmount,
    required this.requiresPrescription,
  });

  factory CartSummary.fromJson(Map<String, dynamic> json) {
    return CartSummary(
      items: json['items'] != null
          ? (json['items'] as List).map((e) => CartItem.fromJson(e)).toList()
          : [],
      itemCount: json['itemCount'] ?? 0,
      subtotal: (json['subtotal'] ?? 0).toDouble(),
      deliveryFee: (json['deliveryFee'] ?? 0).toDouble(),
      tax: (json['tax'] ?? 0).toDouble(),
      discount: (json['discount'] ?? 0).toDouble(),
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      requiresPrescription: json['requiresPrescription'] ?? false,
    );
  }
}
