part of 'invoice_bloc.dart';

sealed class InvoiceBlocEvent {}

class GetInvoiceList extends InvoiceBlocEvent {}

class GetInvoiceDetail extends InvoiceBlocEvent {
  final String invoiceId;
  GetInvoiceDetail({required this.invoiceId});
}
