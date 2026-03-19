class GetDoctorDetailModel {
  final String imgUrl;
  final String docName;
  final String speclization;
  final int exp;
  final int links;
  final int fees;
  final String about;
  final String address;
  final String hospitalName;
  final double lat;
  final double longit;

  GetDoctorDetailModel({
    required this.imgUrl,
    required this.docName,
    required this.speclization,
    required this.exp,
    required this.links,
    required this.fees,
    required this.about,
    required this.address,
    required this.hospitalName,
    required this.lat,
    required this.longit,
  });

  factory GetDoctorDetailModel.fromJson(Map<String, dynamic> json) {
    return GetDoctorDetailModel(
      imgUrl: json['imgUrl'] ?? '',
      docName: json['docName'] ?? '',
      speclization: json['speclization'] ?? '',
      exp: (json['exp'] ?? 0).toInt(),
      links: (json['links'] ?? 0).toInt(),
      fees: (json['fees'] ?? 0).toInt(),
      about: json['about'] ?? '',
      address: json['address'] ?? '',
      hospitalName: json['hospitalName'] ?? '',
      lat: (json['lat'] ?? 0.0).toDouble(),
      longit: (json['longit'] ?? 0.0).toDouble(),
    );
  }
}
