import 'dart:convert';

import 'package:caretag/Modules/%20Diagonostic/model/diagonostic_detail_model.dart';
import 'package:caretag/Modules/%20Diagonostic/model/diagonostic_list_model.dart';
import 'package:caretag/Modules/auth/model_view/service/AuthenticationService.dart';
import 'package:flutter/material.dart';

class DiagonosticRepo {
  final String baseUrl =
      "https://uncatastrophic-nonobserving-marylyn.ngrok-free.dev/patient/dg";
  Authenticationservice authenticationservice = Authenticationservice();

  Future<List<DiagonosticListModel>> getDiagonosticList() async {
    try {
      final response = await authenticationservice.get(
        Uri.parse("$baseUrl/list"),
      );
      debugPrint(response.body);
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((e) => DiagonosticListModel.fromJson(e)).toList();
      }
      throw Exception();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<DiagonosticDetailModel> getDiagonosticDetailModel(int id) async {
    try {
      final response = await authenticationservice.post(
        Uri.parse("$baseUrl/detail"),
        body: id.toString(),
      );
      if (response.statusCode == 200) {
        return DiagonosticDetailModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception();
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
