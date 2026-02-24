class Permissionrequestmodel {
  final String docName;
  final String placeName;
  final String publicKey;
  final String docEmail;

  Permissionrequestmodel({
    required this.docName,
    required this.placeName,
    required this.publicKey,
    required this.docEmail,
  });

  factory Permissionrequestmodel.formMap(Map<String, dynamic> map) {
    return Permissionrequestmodel(
      docName: map['docName'] ?? '',
      placeName: map['placeName'],
      publicKey: map['publicKey'] ?? '',
      docEmail: map['docEmail'] ?? '', // Ensure this key name matches exactly
    );
  }
}
