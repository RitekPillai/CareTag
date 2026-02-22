import 'dart:convert';
import 'dart:developer';

import 'package:caretag/Modules/auth/data/model/authException.dart';
import 'package:caretag/Modules/auth/data/model/tokenModel.dart';
import 'package:caretag/utils/storageService.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class Authenticationservice extends http.BaseClient {
  final storage = Storageservice();
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    String? accessToken = await storage.getAcessToken();

    if (accessToken == null ||
        accessToken.isEmpty ||
        JwtDecoder.isExpired(accessToken)) {
      try {
        log("Token invalid or expired. Attempting refresh...");
        await tokenRequest();

        log("New Token:$accessToken");
        accessToken = await storage.getAcessToken();
      } catch (e) {
        log("Refresh failed: $e");
        //   await storage.clearAll();
        return http.StreamedResponse(Stream.empty(), 401);
      }
    }

    if (accessToken == null || accessToken.isEmpty) {
      log("Abort: No token available after refresh attempt.");
      return http.StreamedResponse(Stream.empty(), 401);
    }
    request.headers['Authorization'] = 'Bearer $accessToken';

    request.headers['Content-Type'] = 'application/json';

    // send the request
    http.StreamedResponse response = await _inner.send(request);
    if (response.statusCode == 401) {
      log("Server returned 401. Clearing tokens.");
      await storage.clearAll();
    }
    return response;
  }

  Future<bool> hasToken() async {
    return await storage.getAcessToken() != null;
  }

  Future<String?> getAcessToken() async {
    final String? at = await storage.getAcessToken();
    return at;
  }

  Future<void> tokenRequest() async {
    String baseUrl =
        "https://uncatastrophic-nonobserving-marylyn.ngrok-free.dev/auth";
    try {
      final refreshToken = await storage.getRefreshToken();

      debugPrint("Current User Refresh  token : $refreshToken");
      if (refreshToken == null) {
        throw Exception("REFRESH TOKEN IS NULL");
      }

      final response = await http.post(
        Uri.parse("$baseUrl/refresh"),
        body: refreshToken,
      );

      if (response.statusCode == 200) {
        final newToken = Tokenmodel.fromJson(jsonDecode(response.body));
        await storage.saveToken(newToken.accessToken, newToken.refreshToken);
      } else if (response.statusCode == 500 || response.statusCode == 501) {
      } else {
        AuthException authException = AuthException.fromJson(
          jsonDecode(response.body),
        );

        throw authException;
      }
    } catch (e) {
      rethrow;
    }
  }
}
