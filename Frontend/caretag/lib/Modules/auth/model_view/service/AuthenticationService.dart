import 'dart:convert';

import 'package:caretag/Modules/auth/data/model/authException.dart';
import 'package:caretag/Modules/auth/data/model/tokenModel.dart';
import 'package:caretag/Modules/auth/model_view/service/storageService.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class Authenticationservice extends http.BaseClient {
  final storage = Storageservice();
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    String? acessToken = await storage.getAcessToken();

    if (acessToken != null && JwtDecoder.isExpired(acessToken)) {
      /// Request for new Request token---
      await tokenRequest();
      acessToken = await storage.getAcessToken();
    }

    request.headers['Authorization'] = 'Bearer $acessToken';

    request.headers['Content-Type'] = 'application/json';
    debugPrint(
      "--------------------${request.headers.toString()},${request.method},${request.url}",
    );

    // send the request
    http.StreamedResponse response = await _inner.send(request);

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
    String baseUrl = "http://localhost:8080/auth";
    try {
      final refreshToken = await storage.getRefreshToken();
      debugPrint(refreshToken);
      if (refreshToken == null) {
        throw Exception("REFRESH TOKEN IS NULL");
      }

      final response = await http.post(
        Uri.parse("$baseUrl/refresh"),
        body: refreshToken,
      );
      if (response.statusCode == 200) {
        debugPrint(response.body);
        debugPrint("Done.");
        final newToken = Tokenmodel.fromJson(jsonDecode(response.body));
        await storage.saveToken(newToken.accessToken, newToken.refreshToken);
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
