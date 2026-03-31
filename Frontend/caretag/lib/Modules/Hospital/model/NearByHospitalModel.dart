class NearbyHospitalModel {
  final int? id;
  final String? name;
  final String? imageUrl;
  final String? distance;
  final double? rating;
  final List<String>? specialties;
  final bool? isOpen24_7;

  NearbyHospitalModel({
    this.id,
    this.name,
    this.imageUrl,
    this.distance,
    this.rating,
    this.specialties,
    this.isOpen24_7,
  });

  factory NearbyHospitalModel.fromJson(Map<String, dynamic> json) {
    return NearbyHospitalModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      distance: json['distance'],
      rating: json['rating']?.toDouble(),
      specialties: json['specialties'] != null
          ? List<String>.from(json['specialties'])
          : [],
      isOpen24_7: json['isOpen24_7'],
    );
  }
}
