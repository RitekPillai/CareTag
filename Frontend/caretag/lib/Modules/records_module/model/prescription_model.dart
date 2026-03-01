class PrescriptionModel {
  String prescriptionId;
  String doctorName;
  String specialization;
  String hospitalName;
  String prescriptionDate;
  String diagnosis;
  String status;

  PrescriptionModel({
    required this.prescriptionId,
    required this.doctorName,
    required this.specialization,
    required this.hospitalName,
    required this.prescriptionDate,
    required this.diagnosis,
    required this.status,
  });

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) {
    return PrescriptionModel(
      prescriptionId: json['prescriptionId'],
      doctorName: json['doctorName'],
      specialization: json['specialization'],
      hospitalName: json['hospitalName'],
      prescriptionDate: json['prescriptionDate'],
      diagnosis: json['diagnosis'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['prescriptionId'] = prescriptionId;
    data['doctorName'] = doctorName;
    data['specialization'] = specialization;
    data['hospitalName'] = hospitalName;
    data['prescriptionDate'] = prescriptionDate;
    data['diagnosis'] = diagnosis;
    data['status'] = status;
    return data;
  }
}
