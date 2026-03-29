class CartItem {
  final String medicineId;
  final String medicineName;
  final String medicineImage;
  final String packageSize;
  final double price;
  final double? discountedPrice;
  final int quantity;
  final double itemTotal;
  final bool requiresPrescription;
  final bool inStock;

  CartItem({
    required this.medicineId,
    required this.medicineName,
    required this.medicineImage,
    required this.packageSize,
    required this.price,
    this.discountedPrice,
    required this.quantity,
    required this.itemTotal,
    required this.requiresPrescription,
    required this.inStock,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
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
      inStock: json['inStock'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medicineId': medicineId,
      'medicineName': medicineName,
      'medicineImage': medicineImage,
      'packageSize': packageSize,
      'price': price,
      'discountedPrice': discountedPrice,
      'quantity': quantity,
      'itemTotal': itemTotal,
      'requiresPrescription': requiresPrescription,
      'inStock': inStock,
    };
  }

  CartItem copyWith({int? quantity}) {
    return CartItem(
      medicineId: medicineId,
      medicineName: medicineName,
      medicineImage: medicineImage,
      packageSize: packageSize,
      price: price,
      discountedPrice: discountedPrice,
      quantity: quantity ?? this.quantity,
      itemTotal: (discountedPrice ?? price) * (quantity ?? this.quantity),
      requiresPrescription: requiresPrescription,
      inStock: inStock,
    );
  }
}
