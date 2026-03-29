import 'dart:convert';

import 'package:caretag/Modules/auth/model_view/service/AuthenticationService.dart';
import 'package:caretag/Modules/home/model/RecentActivity.dart';
import 'package:flutter/foundation.dart';
// Import your model here
// import 'recent_activity.dart';

class TimelineRepository {
  final Authenticationservice authenticationservice = Authenticationservice();

  final String baseUrl =
      "https://uncatastrophic-nonobserving-marylyn.ngrok-free.dev/paitent";
  Future<List<RecentActivity>> fetchTimeline() async {
    try {
      final response = await authenticationservice.get(
        Uri.parse('$baseUrl/timeline'),
      );
      debugPrint("Response------------------:${response.body}");
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => RecentActivity.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load timeline: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
