import 'dart:convert';

import 'package:caretag/Modules/Hospital/model/NearByHospitalModel.dart';
import 'package:caretag/Modules/auth/model_view/service/AuthenticationService.dart';

class HospitalRepo {
  Future<List<NearbyHospitalModel>> getNearbyHospitals(
    Authenticationservice authService,
  ) async {
      final String baseUrl =
      "https://uncatastrophic-nonobserving-marylyn.ngrok-free.dev/paitent";

    try {
      final response = await authService.get(
        Uri.parse("$baseUrl/nearby-hospitals"),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => NearbyHospitalModel.fromJson(json)).toList();
      }
      throw Exception("Failed to load hospitals");
    } catch (e) {
      rethrow;
    }
  }
}
