class InvoiceListModel {
  final String discription;
  final String docName;
  final double totalAmount;
  final String hospitalName;
  final String transcationId;
  final String? status;
  final String invoiceDate;
  final String? invoiceId;

  InvoiceListModel({
    required this.discription,
    required this.docName,
    required this.totalAmount,
    required this.hospitalName,
    required this.transcationId,
    required this.status,
    required this.invoiceDate,
    required this.invoiceId,
  });

  factory InvoiceListModel.fromJson(Map<String, dynamic> json) {
    return InvoiceListModel(
      discription: json['discription'] ?? '',
      docName: json['docName'],
      totalAmount: json['totalAmount'],
      hospitalName: json['hospitalName'],
      transcationId: json['transcationId'],
      status: json['status'] ?? '',
      invoiceDate: json['invoiceDate'] ?? '',
      invoiceId: json['invoiceId'],
    );
  }
}
