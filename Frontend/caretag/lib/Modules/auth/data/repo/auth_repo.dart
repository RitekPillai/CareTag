import 'dart:convert';

import 'package:caretag/Modules/auth/data/auth/forgot_password_request.dart';
import 'package:caretag/Modules/auth/data/auth/login_request.dart';
import 'package:caretag/Modules/auth/data/auth/signup_request.dart';
import 'package:caretag/Modules/auth/data/model/authException.dart';
import 'package:caretag/Modules/auth/data/model/emailVerificationToken.dart';
import 'package:caretag/Modules/auth/data/model/otpVerifyRequest.dart';
import 'package:caretag/Modules/auth/data/model/tokenModel.dart';
import 'package:caretag/Modules/auth/model_view/service/storageService.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;

class AuthRepo {
  final String baseUrl =
      "https://uncatastrophic-nonobserving-marylyn.ngrok-free.dev/auth";
  final String oauthBaseUrl =
      "https://uncatastrophic-nonobserving-marylyn.ngrok-free.dev/oauth2/authorization/google";

  final Storageservice storageservice = Storageservice();

  Future<void> signUp(SignUpRequest req) async {
    Map<String, dynamic> payload = req.toJson();

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/signup"),
        body: jsonEncode(payload),
        headers: {'Content-Type': 'application/json'},
      );
      debugPrint(" response : ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        Emailverificationtoken emailToken = Emailverificationtoken.formJson(
          jsonDecode(response.body),
        );

        storageservice.saveEmailToken(emailToken.Token);
        debugPrint("Email Verification Token : ${emailToken.Token}");
      } else {
        AuthException authException = AuthException.fromJson(
          jsonDecode(response.body),
        );
        debugPrint("Auth Exceptipon${authException.errorMessage}");
        throw AuthException(
          StatusCode: authException.StatusCode,
          errorMessage: authException.errorMessage,
          timeStamp: authException.timeStamp,
        );
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

      if (response.statusCode == 202) {
        return response.body;
      } else {
        AuthException authException = AuthException.fromJson(
          jsonDecode(response.body),
        );
        debugPrint("Auth Exceptipon${authException.errorMessage}");
        throw AuthException(
          StatusCode: authException.StatusCode,
          errorMessage: authException.errorMessage,
          timeStamp: authException.timeStamp,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Tokenmodel> GoogleOauthSignUp() async {
    try {
      final result = await FlutterWebAuth2.authenticate(
        url: oauthBaseUrl,
        callbackUrlScheme: "caretag",
      );

      final queryParams = Uri.parse(result).queryParameters;
      final code = queryParams["code"];

      final bool isNewUser = queryParams['isNewUser'] == 'true';

      final response = await http.post(
        Uri.parse("$baseUrl/exchange"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'code': code}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        return Tokenmodel(
          accessToken: data['token'],
          refreshToken: data['refreshToken'],
          username: data['username'],
          isNew: isNewUser,
        );
      } else {
        final authException = AuthException.fromJson(jsonDecode(response.body));
        throw authException;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Tokenmodel> loginOtpVerify(OtpVerifyModel req) async {
    Map<String, dynamic> payload = req.toJson();

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login-verify"),
        body: jsonEncode(payload),
        headers: {'Content-Type': 'application/json'},
      );
      debugPrint("Response body : ${response.body}");
      if (response.statusCode >= 200) {
        Tokenmodel loginTokens = Tokenmodel.fromJson(jsonDecode(response.body));
        debugPrint(response.body);
        return loginTokens;
      }
      throw Exception();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> forgotPasswordOTPRequest(ForgotPasswordRequest req) async {
    Map<String, dynamic> payload = req.toJson();

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/forgot-password/request-otp"),
        body: jsonEncode(payload),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        debugPrint("Check the email otp has been sent");
      } else {
        throw Exception();
      }
    } catch (e) {
      debugPrint("Exception:${e.toString()}");
      rethrow;
    }
  }

  Future<void> emailVerification() async {
    try {
      String? emailToken = await storageservice.getEmailToken();
      debugPrint(emailToken);

      Emailverificationtoken token = Emailverificationtoken(Token: emailToken!);

      Map<String, dynamic> payload = token.toJson();
      debugPrint(payload.toString());

      debugPrint("------------------------ email Token -----------$emailToken");
      final response = await http.post(
        Uri.parse("$baseUrl/isValid"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );
      debugPrint(response.body);
      if (response.statusCode == 200) {
        Tokenmodel tokenmodel = Tokenmodel.fromJson(jsonDecode(response.body));
        await storageservice.saveToken(
          tokenmodel.accessToken,
          tokenmodel.refreshToken,
        );

        await storageservice.clearEmailToken();
        debugPrint("Token Model:${tokenmodel.accessToken}");
      } else {
        throw AuthException.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      debugPrint("Exception:${e.toString()}");

      rethrow;
    }
  }
}
