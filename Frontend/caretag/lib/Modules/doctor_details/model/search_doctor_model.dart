class SearchDoctorModel {
  final int? id;
  final String? fullName;
  final String? specialization;
  final String? imageUrl;
  final String? clinicName;
  final int? yearsOfExperience;

  SearchDoctorModel({
    this.id,
    this.fullName,
    this.specialization,
    this.imageUrl,
    this.clinicName,
    this.yearsOfExperience,
  });

  factory SearchDoctorModel.fromJson(Map<String, dynamic> json) {
    return SearchDoctorModel(
      id: json['id'] as int?,
      fullName: json['fullName'] as String?,
      specialization: json['specialization'] as String?,
      imageUrl: json['imageUrl'] as String?,
      clinicName: json['clinicName'] as String?,
      yearsOfExperience: json['yearsOfExperience'] as int?,
    );
  }
}
