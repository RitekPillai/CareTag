class Acceptreqmodel {
  final String docName;
  final String encryptedAesBlob;

  Acceptreqmodel({required this.docName, required this.encryptedAesBlob});

  Map<String, dynamic> toJson() {
    return {'docName': docName, 'encryptedAesBlob': encryptedAesBlob};
  }
}
