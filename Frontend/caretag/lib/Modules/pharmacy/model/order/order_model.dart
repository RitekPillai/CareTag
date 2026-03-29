import 'package:caretag/Modules/pharmacy/model/order/derlivery_address.dart';

class Order {
  final String id;
  final String patientName;
  final List<OrderItemModel> items;
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double discount;
  final double totalAmount;
  final String status;
  final String paymentMethod;
  final String paymentStatus;
  final DeliveryAddress? deliveryAddress;
  final String? pharmacyName;
  final String? promoCode;
  final DateTime createdAt;
  final DateTime? deliveredAt;

  Order({
    required this.id,
    required this.patientName,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.discount,
    required this.totalAmount,
    required this.status,
    required this.paymentMethod,
    required this.paymentStatus,
    this.deliveryAddress,
    this.pharmacyName,
    this.promoCode,
    required this.createdAt,
    this.deliveredAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? '',
      patientName: json['patientName'] ?? '',
      items: json['items'] != null
          ? (json['items'] as List)
                .map((e) => OrderItemModel.fromJson(e))
                .toList()
          : [],
      subtotal: (json['subtotal'] ?? 0).toDouble(),
      deliveryFee: (json['deliveryFee'] ?? 0).toDouble(),
      tax: (json['tax'] ?? 0).toDouble(),
      discount: (json['discount'] ?? 0).toDouble(),
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      status: json['status'] ?? 'PENDING',
      paymentMethod: json['paymentMethod'] ?? '',
      paymentStatus: json['paymentStatus'] ?? 'PENDING',
      deliveryAddress: json['deliveryAddress'] != null
          ? DeliveryAddress.fromJson(json['deliveryAddress'])
          : null,
      pharmacyName: json['pharmacyName'],
      promoCode: json['promoCode'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      deliveredAt: json['deliveredAt'] != null
          ? DateTime.parse(json['deliveredAt'])
          : null,
    );
  }
}

class OrderItemModel {
  final String medicineId;
  final String medicineName;
  final String medicineImage;
  final String packageSize;
  final double price;
  final double? discountedPrice;
  final int quantity;
  final double itemTotal;
  final bool requiresPrescription;

  OrderItemModel({
    required this.medicineId,
    required this.medicineName,
    required this.medicineImage,
    required this.packageSize,
    required this.price,
    this.discountedPrice,
    required this.quantity,
    required this.itemTotal,
    required this.requiresPrescription,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      medicineId: json['medicineId'] ?? '',
      medicineName: json['medicineName'] ?? '',
      medicineImage: json['medicineImage'] ?? '',
      packageSize: json['packageSize'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      discountedPrice: json['discountedPrice'] != null
          ? (json['discountedPrice']).toDouble()
          : null,
      quantity: json['quantity'] ?? 1,
      itemTotal: (json['itemTotal'] ?? 0).toDouble(),
      requiresPrescription: json['requiresPrescription'] ?? false,
    );
  }
}
