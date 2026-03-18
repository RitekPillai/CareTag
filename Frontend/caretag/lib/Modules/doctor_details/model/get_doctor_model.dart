class GetDoctorModel {
  final int id;
  final String docName;
  final String speclization;
  final String? imgUrl;

  GetDoctorModel({
    required this.id,
    required this.docName,
    required this.speclization,
    required this.imgUrl,
  });

  factory GetDoctorModel.fromJson(Map<String, dynamic> json) {
    return GetDoctorModel(
      id: json['docId'],
      docName: json['docName'],
      speclization: json['speclization'],
      imgUrl:
          json['imgUrl'] ??
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ1SCzaomgsuM_aOmglyOhA5F1nVmuMfOi4A&s',
    );
  }
}
