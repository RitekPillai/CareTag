import 'dart:convert';

import 'package:caretag/Modules/auth/model_view/service/AuthenticationService.dart';
import 'package:caretag/Modules/doctor_details/model/get_doctor_detail_model.dart';
import 'package:caretag/Modules/doctor_details/model/get_doctor_model.dart';
import 'package:flutter/rendering.dart';

class DoctorDetailRepo {
  final String baseUrl =
      "https://uncatastrophic-nonobserving-marylyn.ngrok-free.dev/paitent";
  Future<List<GetDoctorModel>> getMyDoctor(
    Authenticationservice authenticationservice,
  ) async {
    try {
      final response = await authenticationservice.get(
        Uri.parse("$baseUrl/mydoctor"),
      );
      debugPrint("response:${response.body}");
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        debugPrint("Response from the server : $data");
        return data.map((e) => GetDoctorModel.fromJson(e)).toList();
      }
      throw Exception();
    } catch (e) {
      debugPrint(
        "Some error has been occured From doctor detail repo: ${e.toString()}",
      );
      rethrow;
    }
  }

  Future<GetDoctorDetailModel> getMyDoctorDetails(
    Authenticationservice authenticationservice,
    double docId,
  ) async {
    try {
      final response = await authenticationservice.post(
        Uri.parse("$baseUrl/mydoctor/detail?docId=$docId"),
      );
      if (response.statusCode == 200) {
        return GetDoctorDetailModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }
}
