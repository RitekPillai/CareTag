class Registrationmodel {
  final String ciphertext;
  final String iv;
  final String encryptedAesKey;
  final String mac;
  final String rsaPublicKey;

  Registrationmodel({
    required this.ciphertext,
    required this.iv,
    required this.encryptedAesKey,
    required this.mac,
    required this.rsaPublicKey,
  });

  Map<String, dynamic> toJson() {
    return {
      'ciphertext': ciphertext,
      'iv': iv,
      'encryptedAesKey': encryptedAesKey,
      'mac': mac,
      'rsaPublicKey': rsaPublicKey,
    };
  }

  factory Registrationmodel.fromJson(Map<String, dynamic> json) {
    return Registrationmodel(
      ciphertext: json['ciphertext'],
      iv: json['iv'],
      encryptedAesKey: json['encryptedAesKey'],
      mac: json['mac'],
      rsaPublicKey: json['rsaPublicKey'],
    );
  }
}
