part of 'invoice_bloc.dart';

sealed class InvoiceBlocState {}

class InvoiceBlocInitial extends InvoiceBlocState {}

class Loading extends InvoiceBlocState {}

class Failed extends InvoiceBlocState {}

class InvoiceListLoaded extends InvoiceBlocState {
  final List<InvoiceListModel> invoiceList;
  InvoiceListLoaded({required this.invoiceList});
}

class InvoiceDetailLoaded extends InvoiceBlocState {
  final InvoiceDetailModel invoiceData;
  InvoiceDetailLoaded({required this.invoiceData});
}
