import 'dart:convert';

class Medicarecordmodel {
  final BasicPersonalDetails basicPersonalDetails;
  final MedicalDetails medicalDetails;
  final EmergencyDetails emergencyDetails;
  final InsuranceDetails insuranceDetails;
  final LifeStyleDetails lifeStyleDetails;

  Medicarecordmodel({
    required this.basicPersonalDetails,
    required this.medicalDetails,
    required this.emergencyDetails,
    required this.insuranceDetails,
    required this.lifeStyleDetails,
  });

  factory Medicarecordmodel.fromJson(Map<String, dynamic> json) {
    return Medicarecordmodel(
      basicPersonalDetails: BasicPersonalDetails.fromJson(
        json['basicPersonalDetails'] ?? {},
      ),
      medicalDetails: MedicalDetails.fromJson(json["medicalDetails"] ?? {}),
      emergencyDetails: EmergencyDetails.fromJson(
        json['emergencyDetails'] ?? {},
      ),
      insuranceDetails: InsuranceDetails.fromJson(
        json['insuranceDetails'] ?? {},
      ),
      lifeStyleDetails: LifeStyleDetails.fromJson(
        json['lifeStyleDetails'] ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'basicPersonalDetails': basicPersonalDetails.toJson(),
      'medicalDetails': medicalDetails.toJson(),
      'emergencyDetails': emergencyDetails.toJson(),
      'insuranceDetails': insuranceDetails.toJson(),
      'lifeStyleDetails': lifeStyleDetails.toJson(),
    };
  }

  String toRawJson() => json.encode(toJson());
}

class BasicPersonalDetails {
  final String fullname;
  final String dob;
  final String address;
  final String bloodGroup;

  BasicPersonalDetails({
    required this.fullname,
    required this.dob,
    required this.address,
    required this.bloodGroup,
  });

  factory BasicPersonalDetails.fromJson(Map<String, dynamic> json) {
    return BasicPersonalDetails(
      fullname: json['fullName'] ?? '',
      dob: json['dob'] ?? '',
      address: json['address'] ?? '',
      bloodGroup: json['bloodGroup'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullname,
      'dob': dob,
      'address': address,
      'bloodGroup': bloodGroup,
    };
  }
}

class MedicalDetails {
  final String allegries;
  final String chronicConditions;
  final String pastSurgeries;
  final String vaccinationHistory;
  final String prefferedDoctor;
  final String drugReactions;
  final String diagonoses;
  final String hereditaryGenetic;

  MedicalDetails({
    required this.allegries,
    required this.chronicConditions,
    required this.pastSurgeries,
    required this.vaccinationHistory,
    required this.prefferedDoctor,
    required this.drugReactions,
    required this.diagonoses,
    required this.hereditaryGenetic,
  });

  factory MedicalDetails.fromJson(Map<String, dynamic> json) {
    return MedicalDetails(
      allegries: json['allegries'] ?? '',
      chronicConditions: json['chronicConditions'] ?? '',
      diagonoses: json['diagonoses'] ?? '',
      drugReactions: json['drugReactions'] ?? '',
      hereditaryGenetic: json['hereditaryGenetic'] ?? '',
      pastSurgeries: json['pastSurgeries'] ?? '',
      prefferedDoctor: json['prefferedDoctor'] ?? '',
      vaccinationHistory: json['vaccinationHistory'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'allegries': allegries,
      'chronicConditions': chronicConditions,
      'diagonoses': diagonoses,
      'drugReactions': drugReactions,
      'hereditaryGenetic': hereditaryGenetic,
      'pastSurgeries': pastSurgeries,
      'prefferedDoctor': prefferedDoctor,
      'vaccinationHistory': vaccinationHistory,
    };
  }
}

class EmergencyDetails {
  final String contact;
  final String name;

  EmergencyDetails({required this.contact, required this.name});

  factory EmergencyDetails.fromJson(Map<String, dynamic> json) {
    return EmergencyDetails(
      contact: json['contact'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'contact': contact, 'name': name};
  }
}

class InsuranceDetails {
  final String policyNumber;
  final String provider;

  InsuranceDetails({required this.policyNumber, required this.provider});

  factory InsuranceDetails.fromJson(Map<String, dynamic> json) {
    return InsuranceDetails(
      policyNumber: json['policynumber'] ?? '',
      provider: json['provider'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'policynumber': policyNumber, 'provider': provider};
  }
}

class LifeStyleDetails {
  final String smoke;
  final String alcohal;
  final String excercise;

  LifeStyleDetails({
    required this.smoke,
    required this.alcohal,
    required this.excercise,
  });

  factory LifeStyleDetails.fromJson(Map<String, dynamic> json) {
    return LifeStyleDetails(
      smoke: json['smoke'] ?? '',
      alcohal: json['alcohal'] ?? '',
      excercise: json['excercise'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'smoke': smoke, 'alcohal': alcohal, 'excercise': excercise};
  }
}
