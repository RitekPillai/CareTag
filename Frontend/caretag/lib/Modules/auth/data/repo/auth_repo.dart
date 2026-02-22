import 'dart:convert';
import 'dart:developer';

import 'package:caretag/Modules/auth/data/auth/forgot_password_request.dart';
import 'package:caretag/Modules/auth/data/auth/login_request.dart';
import 'package:caretag/Modules/auth/data/auth/login_response.dart';
import 'package:caretag/Modules/auth/data/auth/signup_request.dart';
import 'package:caretag/Modules/auth/data/model/authException.dart';
import 'package:caretag/Modules/auth/data/model/otpVerifyRequest.dart';
import 'package:caretag/Modules/auth/data/model/signupresponse.dart';
import 'package:caretag/Modules/auth/data/model/tokenModel.dart';
import 'package:caretag/Modules/auth/model_view/service/AuthenticationService.dart';
import 'package:caretag/utils/storageService.dart';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;

class AuthRepo {
  final String paitentUrl =
      "https://uncatastrophic-nonobserving-marylyn.ngrok-free.dev/auth/paitent";
  final String baseUrl =
      "https://uncatastrophic-nonobserving-marylyn.ngrok-free.dev/auth";
  final String oauthBaseUrl =
      "https://uncatastrophic-nonobserving-marylyn.ngrok-free.dev/oauth2/authorization/google";

  final Storageservice storageservice = Storageservice();
  final Authenticationservice _authenticationservice = Authenticationservice();

  Future<void> signUp(SignUpRequest req) async {
    Map<String, dynamic> payload = req.toJson();

    try {
      final response = await http.post(
        Uri.parse("$paitentUrl/signup"),
        body: jsonEncode(payload),
        headers: {'Content-Type': 'application/json'},
      );

      debugPrint("From repo : ${response.body}");
      if (response.statusCode == 200) {
        // Emailverificationtoken emailToken = Emailverificationtoken.formJson(
        //   jsonDecode(response.body),
        // );

        debugPrint("SUcesss");

        //   debugPrint(emailToken.Token);
      } else if (response.statusCode == 400) {
        debugPrint("already email done");
        throw AuthException(
          StatusCode: "",
          errorMessage:
              "Email is elready exsist try login or use deifferent email.",
          timeStamp: "",
        );
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

  Future<void> login(LoginRequest req) async {
    Map<String, dynamic> payload = req.toJson();

    try {
      final response = await http.post(
        Uri.parse("$paitentUrl/login"),
        body: jsonEncode(payload),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 202) {
        log("REQUEST SUCESS");
      } else {
        throw AuthException(
          StatusCode: response.statusCode.toString(),
          errorMessage: response.body,
          timeStamp: DateTime.now().toString(),
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
      if (queryParams.containsKey('error')) {
        final error = queryParams['error'];
        print("Login failed: $error");
        throw AuthException(
          StatusCode: "",
          errorMessage: error!,
          timeStamp: "",
        );
      }

      final bool isNewUser = queryParams['isNewUser'] == 'true';

      final response = await http.post(
        Uri.parse("$baseUrl/exchange"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'code': code}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        Tokenmodel model = Tokenmodel.fromJson(data);
        log("Token Model:$model");
        return model;
      } else {
        final authException = AuthException.fromJson(jsonDecode(response.body));
        throw authException;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginOtpResponse> loginOtpVerify(OtpVerifyModel req) async {
    Map<String, dynamic> payload = req.toJson();

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login-verify"),
        body: jsonEncode(payload),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log("Data :$data");
        return LoginOtpResponse.fromJson(data);
      } else {
        throw AuthException(
          StatusCode: response.statusCode.toString(),
          errorMessage: response.body,
          timeStamp: DateTime.now().toString(),
        );
      }
    } catch (e) {
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

  Future<void> emailVerification(String email) async {
    try {
      debugPrint(email);
      final response = await http.post(
        Uri.parse("$baseUrl/isValid"),

        body: email,
      );

      debugPrint(response.body);
      debugPrint("done..");
      if (response.statusCode == 200) {
        Signupresponse tokenmodel = Signupresponse.fromJson(
          jsonDecode(response.body),
        );
        await storageservice.saveToken(
          tokenmodel.accessToken,
          tokenmodel.refreshToken,
        );

        debugPrint("Token Model:${tokenmodel.accessToken}");
      } else {
        throw AuthException.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      debugPrint("Exception:${e.toString()}");

      rethrow;
    }
  }

  Future<String> isAuthenticated() async {
    String? accessToken = await storageservice.getAcessToken();
    String? refreshToken = await storageservice.getRefreshToken();
    bool isIntroSeeen = await storageservice.hasSeenIntro();

    debugPrint("accessToken: $accessToken");
    debugPrint("Refresh Token: $refreshToken");
    debugPrint(" is New User: ${isIntroSeeen.toString()}");
    if (!isIntroSeeen) {
      log(
        "--------------------------------------------------------This is a new User",
      );
      return "newuser";
    } else if (accessToken == null || refreshToken == null) {
      log(
        "------------------------- this is a new user but seen the intro but not yet logged in(may be got exisited in the middle of the process)",
      );
      return "loginScreen";
    } else {
      final response = await _authenticationservice.get(
        Uri.parse("$baseUrl/me"),
      );
      log(
        "---------------------------------------------------------------response:${response.body}",
      );
      debugPrint("Function done");
      return response.body;
    }
  }
}
