import 'dart:convert';

class Recordaccessacceptmodel {
  String docId;
  String encounterId;
  String aesCrptedkey;
  Recordaccessacceptmodel({
    required this.docId,
    required this.encounterId,
    required this.aesCrptedkey,
  });

  Recordaccessacceptmodel copyWith({
    String? docId,
    String? encounterId,
    String? aesCrptedkey,
  }) {
    return Recordaccessacceptmodel(
      docId: docId ?? this.docId,
      encounterId: encounterId ?? this.encounterId,
      aesCrptedkey: aesCrptedkey ?? this.aesCrptedkey,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'docId': docId,
      'encounterId': encounterId,
      'aesCrptedkey': aesCrptedkey,
    };
  }
}
