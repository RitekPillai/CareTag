class Permissionrequestmodel {
  final String docName;
  final String placeName;
  final String publicKey;
  final String docId;

  Permissionrequestmodel({
    required this.docName,
    required this.placeName,
    required this.publicKey,
    required this.docId,
  });

  factory Permissionrequestmodel.formMap(Map<String, dynamic> map) {
    return Permissionrequestmodel(
      docName: map['docName'] ?? '',
      placeName: map['placeName'],
      publicKey: map['publicKey'] ?? '',
      docId: map['docId'] ?? '',
    );
  }
}
