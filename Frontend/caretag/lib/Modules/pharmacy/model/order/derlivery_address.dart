class DeliveryAddress {
  final String label;
  final String fullAddress;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final String? landmark;
  final double? latitude;
  final double? longitude;

  DeliveryAddress({
    required this.label,
    required this.fullAddress,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.landmark,
    this.latitude,
    this.longitude,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) {
    return DeliveryAddress(
      label: json['label'] ?? 'Home',
      fullAddress: json['fullAddress'] ?? '',
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      postalCode: json['postalCode'] ?? '',
      country: json['country'] ?? '',
      landmark: json['landmark'],
      latitude: json['latitude'] != null ? (json['latitude']).toDouble() : null,
      longitude: json['longitude'] != null
          ? (json['longitude']).toDouble()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'fullAddress': fullAddress,
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'landmark': landmark,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
