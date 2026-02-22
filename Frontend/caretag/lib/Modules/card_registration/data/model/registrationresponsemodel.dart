import 'package:caretag/Modules/card_registration/data/model/medicarecordmodel.dart';

class Registrationmodel {
  final String ciphertext;
  final String iv;
  final String encryptedAesKey;
  final String mac;
  final String rsaPublicKey;
  final String? id;
  final BasicPersonalDetails? basicPersonalDetails;

  Registrationmodel({
    required this.ciphertext,
    required this.iv,
    required this.encryptedAesKey,
    required this.mac,
    required this.rsaPublicKey,
    this.id,
    this.basicPersonalDetails,
  });

  Map<String, dynamic> toJson() {
    return {
      'ciphertext': ciphertext,
      'iv': iv,
      'encryptedAesKey': encryptedAesKey,
      'mac': mac,
      'rsaPublicKey': rsaPublicKey,
      'basicDataDTO': basicPersonalDetails,
      'id': id,
    };
  }

  factory Registrationmodel.fromJson(Map<String, dynamic> json) {
    return Registrationmodel(
      ciphertext: json['ciphertext'] ?? '',
      iv: json['iv'] ?? '',
      encryptedAesKey: json['encryptedAesKey'] ?? '',
      mac: json['mac'] ?? '',
      rsaPublicKey: json['rsaPublicKey'] ?? '',
    );
  }
}
