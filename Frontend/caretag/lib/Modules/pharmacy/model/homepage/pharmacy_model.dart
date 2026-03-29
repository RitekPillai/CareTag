class PharmacyModel {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String imageUrl;
  final double? rating;
  final int? reviewCount;
  final String openingTime;
  final String closingTime;
  final bool isOpen24x7;
  final bool isOpenNow;
  final bool homeDelivery;
  final int? deliveryTime;
  final double? distance;

  PharmacyModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.imageUrl,
    this.rating,
    this.reviewCount,
    required this.openingTime,
    required this.closingTime,
    required this.isOpen24x7,
    required this.isOpenNow,
    required this.homeDelivery,
    this.deliveryTime,
    this.distance,
  });

  factory PharmacyModel.fromJson(Map<String, dynamic> json) {
    return PharmacyModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      rating: json['rating'] != null ? (json['rating']).toDouble() : null,
      reviewCount: json['reviewCount'],
      openingTime: json['openingTime'] ?? '09:00',
      closingTime: json['closingTime'] ?? '21:00',
      isOpen24x7: json['isOpen24x7'] ?? false,
      isOpenNow: json['isOpenNow'] ?? false,
      homeDelivery: json['homeDelivery'] ?? false,
      deliveryTime: json['deliveryTime'],
      distance: json['distance'] != null ? (json['distance']).toDouble() : null,
    );
  }
}
