class InvoiceDetailModel {
  final String docName;
  final String hospitalName;
  final String paitentName;
  final String invoiceDate;
  final double totalAmount;
  final double taxRate;
  final String title;
  final String status;
  final String transactionNumber;
  final String paitentEmail;

  InvoiceDetailModel({
    required this.docName,
    required this.hospitalName,
    required this.paitentName,
    required this.invoiceDate,
    required this.totalAmount,
    required this.taxRate,
    required this.title,
    required this.status,
    required this.transactionNumber,
    required this.paitentEmail,
  });

  factory InvoiceDetailModel.fromJson(Map<String, dynamic> json) {
    return InvoiceDetailModel(
      docName: json['docName'],
      hospitalName: json['hospitalName'],
      paitentName: json['paitentName'],
      invoiceDate: json['invoiceDate'],
      totalAmount: json['totalAmount'],
      taxRate: json['taxRate'],
      title: json['title'],
      status: json['status'],
      transactionNumber: json['transactionNumber'],
      paitentEmail: json['paitentEmail'],
    );
  }
}
