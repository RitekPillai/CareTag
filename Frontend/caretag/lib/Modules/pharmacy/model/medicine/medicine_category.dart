class MedicineCategory {
  final String id;
  final String name;
  final String description;
  final String iconUrl;
  final String imageUrl;
  final String colorCode;
  final int productCount;

  MedicineCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.iconUrl,
    required this.imageUrl,
    required this.colorCode,
    required this.productCount,
  });

  factory MedicineCategory.fromJson(Map<String, dynamic> json) {
    return MedicineCategory(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      iconUrl: json['iconUrl'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      colorCode: json['colorCode'] ?? '#1CAB5C',
      productCount: json['productCount'] ?? 0,
    );
  }
}
