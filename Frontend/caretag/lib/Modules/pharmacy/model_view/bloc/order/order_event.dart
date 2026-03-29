part of 'oder_bloc.dart';

sealed class OrderEvent {}

final class CreateOrder extends OrderEvent {
  final List<Map<String, dynamic>> items;
  final Map<String, dynamic> deliveryAddress;
  final String? deliveryInstructions;
  final String? prescriptionUrl;
  final String paymentMethod;
  final String? promoCode;

  CreateOrder({
    required this.items,
    required this.deliveryAddress,
    this.deliveryInstructions,
    this.prescriptionUrl,
    required this.paymentMethod,
    this.promoCode,
  });
}

final class LoadMyOrders extends OrderEvent {}

final class LoadOrderDetail extends OrderEvent {
  final String orderId;
  LoadOrderDetail(this.orderId);
}

final class ValidatePromoCode extends OrderEvent {
  final String code;
  final double orderAmount;
  ValidatePromoCode(this.code, this.orderAmount);
}
