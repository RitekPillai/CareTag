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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prescriptionId'] = this.prescriptionId;
    data['doctorName'] = this.doctorName;
    data['specialization'] = this.specialization;
    data['hospitalName'] = this.hospitalName;
    data['prescriptionDate'] = this.prescriptionDate;
    data['diagnosis'] = this.diagnosis;
    data['status'] = this.status;
    return data;
  }
}
