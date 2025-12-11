import 'dart:convert';

import 'package:caretag/Modules/auth/data/auth/login_request.dart';
import 'package:caretag/Modules/auth/data/auth/signup_request.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class AuthRepo {
  final String baseUrl = "http://192.168.0.104:8080/auth";

  Future<String> signUp(SignUpRequest req) async {
    Map<String, dynamic> payload = req.toJson();

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/signup"),
        body: jsonEncode(payload),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return "SignUp done Check the email for verfication";
      } else {
        throw "Something Happend SignUp Process failed";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> login(LoginRequest req) async {
    Map<String, dynamic> payload = req.toJson();
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login"),
        body: jsonEncode(payload),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200 || response.statusCode == 202) {
        debugPrint("Login Done SucessFully");

        return await jsonDecode(response.body);
      } else {
        throw Exception();
      }
    } catch (e) {
      debugPrint("from repo-${e.toString()}");
      rethrow;
    }
  }
}
