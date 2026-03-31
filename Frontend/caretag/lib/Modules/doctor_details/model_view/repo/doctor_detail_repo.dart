import 'dart:convert';

import 'package:caretag/Modules/auth/model_view/service/AuthenticationService.dart';
import 'package:caretag/Modules/doctor_details/model/dashboard_model.dart';
import 'package:caretag/Modules/doctor_details/model/doctor_filer_model.dart';
import 'package:caretag/Modules/doctor_details/model/get_doctor_detail_model.dart';
import 'package:caretag/Modules/doctor_details/model/search_doctor_model.dart';
import 'package:flutter/rendering.dart';

class DoctorDetailRepo {
  final String baseUrl =
      "https://uncatastrophic-nonobserving-marylyn.ngrok-free.dev/paitent";

  Future<DoctorDashboardModel> getDoctorDashboard(
    Authenticationservice authenticationservice,
  ) async {
    try {
      final response = await authenticationservice.get(
        Uri.parse("$baseUrl/doctor-dashboard"),
      );

      debugPrint("Dashboard Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return DoctorDashboardModel.fromJson(data);
      } else {
        throw Exception("Failed to load dashboard: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error occurred in getDoctorDashboard Repo: ${e.toString()}");
      rethrow;
    }
  }

  // --- KEPT EXISTING DETAIL METHOD ---
  Future<GetDoctorDetailModel> getMyDoctorDetails(
    Authenticationservice authenticationservice,
    int docId,
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

  Future<List<SearchDoctorModel>> searchDoctors(
    Authenticationservice authService,
    DoctorFilterModel filter,
  ) async {
    try {
      final response = await authService.post(
        Uri.parse("$baseUrl/search"),
        body: jsonEncode(filter.toJson()),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => SearchDoctorModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to search doctors");
      }
    } catch (e) {
      debugPrint("Error in SearchRepo: ${e.toString()}");
      rethrow;
    }
  }
}
