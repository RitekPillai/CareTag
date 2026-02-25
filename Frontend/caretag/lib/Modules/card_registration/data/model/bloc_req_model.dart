class BlockReqModel {
  final String docID;
  final String reason;
  final String discription;

  BlockReqModel({
    required this.docID,
    required this.reason,
    required this.discription,
  });

  Map<String, dynamic> toJson() {
    return {'docID': docID, 'reason': reason, 'discription': discription};
  }
}
