import 'dart:convert';

import 'package:caretag/constants/secrets.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class NewsRepo {
  final String _apiKey = newsApiKey;
  final String _baseUrl = "https://newsdata.io/api/1/latest";

  Future<List<dynamic>> fetchHealthNews() async {
    String url = "$_baseUrl?apikey=$_apiKey&category=health&country=in";
    debugPrint("Inside this function:)");
    try {
      final response = await http.get(Uri.parse(url));
      debugPrint(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'success') {
          // IMPORTANT: Update the token for the NEXT call
          debugPrint(data['results']);
          return data['results'];
        }
      }
      return [];
    } catch (e) {
      print("Pagination Error: $e");
      return [];
    }
  }
}
