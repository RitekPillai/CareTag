class Acceptreqmodel {
  final String docEmail;
  final String encryptedAesBlob;

  Acceptreqmodel({required this.docEmail, required this.encryptedAesBlob});

  Map<String, dynamic> toJson() {
    return {'docEmail': docEmail, 'encryptedAesBlob': encryptedAesBlob};
  }
}
