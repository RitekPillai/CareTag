class InvoiceDetailModel {
  final String id;
  final String doctorName;
  final String hospitalName;
  final String patientName;
  final String invoiceDate;
  final int totalAmount;
  final double taxRate;
  final double discount;
  final String title;
  final String status;
  final String transcationNumber;

  InvoiceDetailModel({
    required this.id,
    required this.doctorName,
    required this.hospitalName,
    required this.patientName,
    required this.invoiceDate,
    required this.totalAmount,
    required this.taxRate,
    required this.discount,
    required this.title,
    required this.status,
    required this.transcationNumber,
  });

  factory InvoiceDetailModel.fromJson(Map<String, dynamic> json) {
    return InvoiceDetailModel(
      id: json['id'] ?? '',
      doctorName: json['doctorName'] ?? '',
      hospitalName: json['hospitalName'] ?? '',
      patientName: json['patientName'] ?? '',
      invoiceDate: json['invoiceDate'] ?? '',
      totalAmount: (json['totalAmount'] as num?)?.toInt() ?? 0,
      taxRate: (json['taxRate'] as num?)?.toDouble() ?? 0.0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      title: json['title'] ?? '',
      status: json['status'] ?? '',
      transcationNumber: json['transcationNumber'] ?? '',
    );
  }
}
