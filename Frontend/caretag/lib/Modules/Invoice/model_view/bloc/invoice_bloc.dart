import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:caretag/Modules/Invoice/model/invoice_detail_model.dart';
import 'package:caretag/Modules/Invoice/model/invoice_list_model.dart';
import 'package:caretag/Modules/Invoice/model_view/repo/invoice_repo.dart';

part 'invoice_bloc_state.dart';
part 'invoice_bloc_event.dart';

class InvoiceBloc extends Bloc<InvoiceBlocEvent, InvoiceBlocState> {
  final InvoiceRepo invoiceRepo;

  InvoiceBloc(this.invoiceRepo) : super(InvoiceBlocInitial()) {
    on<GetInvoiceList>(onGetInvoiceList);
    on<GetInvoiceDetail>(onGetInvoiceDetail);
  }
  Future<void> onGetInvoiceList(
    GetInvoiceList event,
    Emitter<InvoiceBlocState> emit,
  ) async {
    emit(Loading());
    try {
      List<InvoiceListModel> invoiceList = await invoiceRepo.getInvoiceList();
      emit(InvoiceListLoaded(invoiceList: invoiceList));
    } catch (e) {
      emit(Failed());
    }
  }

  Future<void> onGetInvoiceDetail(
    GetInvoiceDetail event,
    Emitter<InvoiceBlocState> emit,
  ) async {
    emit(Loading());
    try {
      InvoiceDetailModel invoiceData = await invoiceRepo.getInvoiceDetail(
        event.invoiceId,
      );
      emit(InvoiceDetailLoaded(invoiceData: invoiceData));
    } catch (e) {
      emit(Failed());
    }
  }
}
