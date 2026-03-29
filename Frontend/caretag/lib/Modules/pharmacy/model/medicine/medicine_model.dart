class Medicine {
  final String id;
  final String name;
  final double price;
  final double? discountedPrice;
  final int? discountPercentage;
  final String category;
  final String manufacturer;
  final String brand;
  final String imageUrl;
  final bool requiresPrescription;
  final bool inStock;
  final String packageSize;
  final String form;
  final double? rating;
  final int? reviewCount;

  Medicine({
    required this.id,
    required this.name,
    required this.price,
    this.discountedPrice,
    this.discountPercentage,
    required this.category,
    required this.manufacturer,
    required this.brand,
    required this.imageUrl,
    required this.requiresPrescription,
    required this.inStock,
    required this.packageSize,
    required this.form,
    this.rating,
    this.reviewCount,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      discountedPrice: json['discountedPrice'] != null
          ? (json['discountedPrice']).toDouble()
          : null,
      discountPercentage: json['discountPercentage'],
      category: json['category'] ?? '',
      manufacturer: json['manufacturer'] ?? '',
      brand: json['brand'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      requiresPrescription: json['requiresPrescription'] ?? false,
      inStock: json['inStock'] ?? true,
      packageSize: json['packageSize'] ?? '',
      form: json['form'] ?? '',
      rating: json['rating'] != null ? (json['rating']).toDouble() : null,
      reviewCount: json['reviewCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'discountedPrice': discountedPrice,
      'discountPercentage': discountPercentage,
      'category': category,
      'manufacturer': manufacturer,
      'brand': brand,
      'imageUrl': imageUrl,
      'requiresPrescription': requiresPrescription,
      'inStock': inStock,
      'packageSize': packageSize,
      'form': form,
      'rating': rating,
      'reviewCount': reviewCount,
    };
  }
}
