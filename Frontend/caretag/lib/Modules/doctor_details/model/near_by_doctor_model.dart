class NearbyDoctorModel {
  final String? imgUrl;
  final String? docName;
  final int? numLink;
  final String? specialities;
  final String? distance;
  final String? clinicName;

  NearbyDoctorModel({
    this.imgUrl,
    this.docName,
    this.numLink,
    this.specialities,
    this.distance,
    this.clinicName,
  });

  factory NearbyDoctorModel.fromJson(Map<String, dynamic> json) {
    return NearbyDoctorModel(
      imgUrl: json['imgUrl'] as String?,
      docName: json['docName'] as String?,
      numLink: json['numLink'] as int?,
      specialities: json['specialities'] as String?,
      distance: json['distance'] as String?,
      clinicName: json['clincName'] as String?,
    );
  }
}
