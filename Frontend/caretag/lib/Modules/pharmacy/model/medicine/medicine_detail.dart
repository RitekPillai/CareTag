class MedicineDetail {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? discountedPrice;
  final int? discountPercentage;
  final String category;
  final String manufacturer;
  final String brand;
  final String imageUrl;
  final List<String> images;
  final bool requiresPrescription;
  final int stock;
  final bool inStock;
  final String composition;
  final String dosage;
  final String packageSize;
  final String form;
  final List<String> uses;
  final List<String> sideEffects;
  final String storage;
  final double? rating;
  final int? reviewCount;
  final List<GenericAlternative> genericAlternatives;

  MedicineDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.discountedPrice,
    this.discountPercentage,
    required this.category,
    required this.manufacturer,
    required this.brand,
    required this.imageUrl,
    required this.images,
    required this.requiresPrescription,
    required this.stock,
    required this.inStock,
    required this.composition,
    required this.dosage,
    required this.packageSize,
    required this.form,
    required this.uses,
    required this.sideEffects,
    required this.storage,
    this.rating,
    this.reviewCount,
    required this.genericAlternatives,
  });

  factory MedicineDetail.fromJson(Map<String, dynamic> json) {
    return MedicineDetail(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      discountedPrice: json['discountedPrice'] != null
          ? (json['discountedPrice']).toDouble()
          : null,
      discountPercentage: json['discountPercentage'],
      category: json['category'] ?? '',
      manufacturer: json['manufacturer'] ?? '',
      brand: json['brand'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      images: json['images'] != null ? List<String>.from(json['images']) : [],
      requiresPrescription: json['requiresPrescription'] ?? false,
      stock: json['stock'] ?? 0,
      inStock: json['inStock'] ?? true,
      composition: json['composition'] ?? '',
      dosage: json['dosage'] ?? '',
      packageSize: json['packageSize'] ?? '',
      form: json['form'] ?? '',
      uses: json['uses'] != null ? List<String>.from(json['uses']) : [],
      sideEffects: json['sideEffects'] != null
          ? List<String>.from(json['sideEffects'])
          : [],
      storage: json['storage'] ?? '',
      rating: json['rating'] != null ? (json['rating']).toDouble() : null,
      reviewCount: json['reviewCount'],
      genericAlternatives: json['genericAlternatives'] != null
          ? (json['genericAlternatives'] as List)
                .map((e) => GenericAlternative.fromJson(e))
                .toList()
          : [],
    );
  }
}

class GenericAlternative {
  final String id;
  final String name;
  final String manufacturer;
  final double price;
  final double? discountedPrice;
  final String imageUrl;
  final String composition;
  final double priceDifference;
  final int savingsPercentage;
  final bool isRecommended;

  GenericAlternative({
    required this.id,
    required this.name,
    required this.manufacturer,
    required this.price,
    this.discountedPrice,
    required this.imageUrl,
    required this.composition,
    required this.priceDifference,
    required this.savingsPercentage,
    required this.isRecommended,
  });

  factory GenericAlternative.fromJson(Map<String, dynamic> json) {
    return GenericAlternative(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      manufacturer: json['manufacturer'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      discountedPrice: json['discountedPrice'] != null
          ? (json['discountedPrice']).toDouble()
          : null,
      imageUrl: json['imageUrl'] ?? '',
      composition: json['composition'] ?? '',
      priceDifference: (json['priceDifference'] ?? 0).toDouble(),
      savingsPercentage: json['savingsPercentage'] ?? 0,
      isRecommended: json['isRecommended'] ?? false,
    );
  }
}
