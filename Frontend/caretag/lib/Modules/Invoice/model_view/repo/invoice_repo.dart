import 'dart:convert';
import 'dart:developer';

import 'package:caretag/Modules/Invoice/model/invoice_detail_model.dart';
import 'package:caretag/Modules/Invoice/model/invoice_list_model.dart';
import 'package:caretag/Modules/auth/model_view/service/AuthenticationService.dart';
import 'package:flutter/widgets.dart';

class InvoiceRepo {
  final Authenticationservice auth;

  final String baseUrl =
      "https://uncatastrophic-nonobserving-marylyn.ngrok-free.dev/paitent";

  InvoiceRepo({required this.auth});

  Future<List<InvoiceListModel>> getInvoiceList() async {
    try {
      final response = await auth.get(Uri.parse("$baseUrl/invoice-list"));
      if (response.statusCode == 200) {
        debugPrint(response.body);
        final List data = jsonDecode(response.body);

        return data.map((e) => InvoiceListModel.fromJson(e)).toList();
      } else {
        throw Exception('some Error has been happend in repo');
      }
    } catch (e) {
      log("Error Message from Invoice Repo:${e.toString()}");
      rethrow;
    }
  }

  Future<InvoiceDetailModel> getInvoiceDetail(String invoiceId) async {
    try {
      final response = await auth.post(
        Uri.parse("$baseUrl/invoice"),
        body: invoiceId,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return InvoiceDetailModel.fromJson(data);
      } else {
        throw Exception("error");
      }
    } catch (e) {
      log("Error message form Invoice Repo:${e.toString()}");
      rethrow;
    }
  }
}
