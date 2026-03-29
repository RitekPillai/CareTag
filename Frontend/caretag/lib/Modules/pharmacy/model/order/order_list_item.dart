class OrderListItem {
  final String id;
  final int itemCount;
  final double totalAmount;
  final String status;
  final DateTime createdAt;
  final String? firstMedicineImage;
  final String? firstMedicineName;

  OrderListItem({
    required this.id,
    required this.itemCount,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    this.firstMedicineImage,
    this.firstMedicineName,
  });

  factory OrderListItem.fromJson(Map<String, dynamic> json) {
    return OrderListItem(
      id: json['id'] ?? '',
      itemCount: json['itemCount'] ?? 0,
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      status: json['status'] ?? 'PENDING',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      firstMedicineImage: json['firstMedicineImage'],
      firstMedicineName: json['firstMedicineName'],
    );
  }
}
