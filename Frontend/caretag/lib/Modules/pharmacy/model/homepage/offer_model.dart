class OfferModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String bannerUrl;
  final int? discountPercentage;
  final double? discountAmount;
  final double minimumOrderAmount;
  final String badge;
  final bool isNewUserOnly;
  final List<String> termsAndConditions;

  OfferModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.bannerUrl,
    this.discountPercentage,
    this.discountAmount,
    required this.minimumOrderAmount,
    required this.badge,
    required this.isNewUserOnly,
    required this.termsAndConditions,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      bannerUrl: json['bannerUrl'] ?? '',
      discountPercentage: json['discountPercentage'],
      discountAmount: json['discountAmount'] != null
          ? (json['discountAmount']).toDouble()
          : null,
      minimumOrderAmount: (json['minimumOrderAmount'] ?? 0).toDouble(),
      badge: json['badge'] ?? '',
      isNewUserOnly: json['isNewUserOnly'] ?? false,
      termsAndConditions: json['termsAndConditions'] != null
          ? List<String>.from(json['termsAndConditions'])
          : [],
    );
  }
}

class PromoCodeValidation {
  final bool isValid;
  final String message;
  final double discountAmount;
  final String code;

  PromoCodeValidation({
    required this.isValid,
    required this.message,
    required this.discountAmount,
    required this.code,
  });

  factory PromoCodeValidation.fromJson(Map<String, dynamic> json) {
    return PromoCodeValidation(
      isValid: json['isValid'] ?? false,
      message: json['message'] ?? '',
      discountAmount: (json['discountAmount'] ?? 0).toDouble(),
      code: json['code'] ?? '',
    );
  }
}
