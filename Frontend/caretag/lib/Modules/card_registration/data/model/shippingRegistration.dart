class Shippingregistration {
  final String fullName;
  final String subscriptionType;
  final String phoneNumber;
  final String province;
  final String city;
  final String steetAddress;
  final String postalcode;
  String paymentType;

  Shippingregistration({
    required this.fullName,
    required this.phoneNumber,
    required this.province,
    required this.city,
    required this.steetAddress,
    required this.postalcode,
    required this.subscriptionType,
    required this.paymentType,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullName,
      'subscriptionType': subscriptionType,
      'phoneNumber': phoneNumber,
      'province': province,
      'city': city,
      'steetAddress': steetAddress,
      'postalcode': postalcode,
      'paymentType': paymentType,
    };
  }
}
