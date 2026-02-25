class Acceptreqmodel {
  final String docId;
  final String encryptedAesBlob;

  Acceptreqmodel({required this.docId, required this.encryptedAesBlob});

  Map<String, dynamic> toJson() {
    return {'docId': docId, 'encryptedAesBlob': encryptedAesBlob};
  }
}
