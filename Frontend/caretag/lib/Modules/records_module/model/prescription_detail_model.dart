import 'package:caretag/Modules/records_module/model/medicine_model.dart';

class PrescriptionDetail {
  String? doctorName;
  String? specialization;
  String? hospitalName;
  String? diagnosis;
  List<Medications>? medications;
  String? notes;

  PrescriptionDetail({
    this.doctorName,
    this.specialization,
    this.hospitalName,
    this.diagnosis,
    this.medications,
    this.notes,
  });

  PrescriptionDetail.fromJson(Map<String, dynamic> json) {
    doctorName = json['doctorName'];
    specialization = json['specialization'];
    hospitalName = json['hospitalName'];
    diagnosis = json['diagnosis'];
    if (json['medications'] != null) {
      medications = <Medications>[];
      json['medications'].forEach((v) {
        medications!.add(Medications.fromJson(v));
      });
    }
    notes = json['notes'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};

  //   data['doctorName'] = doctorName;
  //   data['specialization'] = specialization;
  //   data['hospitalName'] = hospitalName;
  //   data['diagnosis'] = diagnosis;
  //   if (medications != null) {
  //     data['medications'] = medications!.map((v) => v.toJson()).toList();
  //   }
  //   data['notes'] = notes;
  //   return data;
  // }
}
