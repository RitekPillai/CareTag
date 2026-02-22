class RecordRequestModel {
  final String ciphertext;
  final String iv;
  final String encryptedAesKey;
  final String mac;
  final String rsaPublicKey;

  RecordRequestModel({
    required this.ciphertext,
    required this.iv,
    required this.encryptedAesKey,
    required this.mac,
    required this.rsaPublicKey,
  });

  factory RecordRequestModel.fromJson(Map<String, dynamic> json) {
    return RecordRequestModel(
      ciphertext: json['ciphertext'],
      iv: json['iv'],
      encryptedAesKey: json['encryptedAesKey'],
      mac: json['mac'],
      rsaPublicKey: json['rsaPublicKey'],
    );
  }
}
