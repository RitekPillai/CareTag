import 'dart:convert';
import 'package:caretag/Modules/auth/model_view/service/AuthenticationService.dart';
import 'package:flutter/foundation.dart';

class AppointmentRepo {
  final String baseUrl =
      "https://your-api.ngrok-free.dev/patient"; // Adjust baseUrl

  Future<List<String>> getAvailableSlots(
    Authenticationservice authService,
    int doctorId,
    String date,
  ) async {
    try {
      final response = await authService.get(
        Uri.parse("$baseUrl/slots?doctorId=$doctorId&date=$date"),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.cast<String>();
      }
      throw Exception("Failed to load slots");
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> bookAppointment(
    Authenticationservice authService,
    int doctorId,
    String date,
    String time,
  ) async {
    try {
      final response = await authService.post(
        Uri.parse("$baseUrl/book-appointment"),
        body: jsonEncode({"doctorId": doctorId, "date": date, "time": time}),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
