import 'dart:convert';

import 'package:caretag/Modules/%20Diagonostic/model/diagonostic_list_model.dart';
import 'package:caretag/Modules/auth/model_view/service/AuthenticationService.dart';

class DiagonosticRepo {
  final String baseUrl =
      "https://uncatastrophic-nonobserving-marylyn.ngrok-free.dev/paitent/dg";
  Authenticationservice authenticationservice = Authenticationservice();

  Future<List<DiagonosticListModel>> getDiagonosticList() async {
    try {
      final response = await authenticationservice.get(
        Uri.parse("$baseUrl/list"),
      );
      if (response.statusCode == 200) {
        final data = response.body;
        return data.map((e) {
          return DiagonosticListModel.fromJson(jsonDecode(e));
        });
      }
      throw Exception();
    } catch (e) {
      rethrow;
    }
  }
}
