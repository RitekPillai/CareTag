class Permissionrequestmodel {
  final String docName;
  final String placeName;
  final String docId;
  final String isRecord;
  final String encounterId;
  final String publicKey;

  Permissionrequestmodel({
    required this.docName,
    required this.placeName,
    required this.docId,
    required this.isRecord,
    required this.encounterId,
    required this.publicKey,
  });

  factory Permissionrequestmodel.formMap(Map<String, dynamic> map) {
    return Permissionrequestmodel(
      docName: map['docName'] ?? '',
      placeName: map['placeName'] ?? '',
      docId: map['docId'] ?? '',
      isRecord: map['isRecord'] ?? 'false',
      encounterId: map['encounterId'] ?? '',
      publicKey: map['publicKey'] ?? '',
    );
  }
}
