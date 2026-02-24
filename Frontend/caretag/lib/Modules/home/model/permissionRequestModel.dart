class Permissionrequestmodel {
  final String docName;
  final String placeName;
  final String publicKey;

  Permissionrequestmodel({
    required this.docName,
    required this.placeName,
    required this.publicKey,
  });

  factory Permissionrequestmodel.formMap(Map<String, dynamic> map) {
    return Permissionrequestmodel(
      docName: map['docName'] ?? '',
      placeName: map['placeName'],
      publicKey: map['publicKey'] ?? '', // Ensure this key name matches exactly
    );
  }
}
