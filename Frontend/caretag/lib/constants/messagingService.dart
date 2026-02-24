import 'dart:convert';

import 'package:caretag/Modules/auth/model_view/service/AuthenticationService.dart';
import 'package:caretag/Modules/home/model/permissionRequestModel.dart';
import 'package:caretag/Modules/home/widgets/careTagHome/dialogBox.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  Future<String?> getToken() async {
    try {
      String? token = await _fcm.getToken();
      return token;
    } catch (e) {
      debugPrint("Error fetching FCM token: $e");
      return null;
    }
  }

  Future<void> initialize() async {
    try {
      NotificationSettings settings = await _fcm.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        try {
          String? token = await _fcm.getToken().timeout(
            const Duration(seconds: 10),
          );
          if (token != null) {
            debugPrint(" FCM Token: $token");
            await updateTokenOnBackend(token);
          }
        } catch (e) {
          debugPrint(
            "FCM Token fetch failed (Service Busy), but listeners are active: $e",
          );
        }
      }

      _setupMessageListeners();
    } catch (e) {
      debugPrint(" General Notification Error: $e");
    }
  }

  void _setupMessageListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint(" Foreground Message Received: ${message.data}");
    });

    _fcm.onTokenRefresh.listen((newToken) {
      print("Token Refreshed: $newToken");
      updateTokenOnBackend(newToken);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint(message.toString());
      if (message.data.isNotEmpty) {
        Permissionrequestmodel model = Permissionrequestmodel.formMap(
          message.data,
        );
        showDialogBox(model.docName, model.placeName);

        ////-------ui

        debugPrint("foreground message test");
      }
    });
  }

  Future<void> updateTokenOnBackend(String token) async {
    try {
      Authenticationservice authenticationservice = Authenticationservice();
      var response = await authenticationservice.post(
        Uri.parse(
          'https://uncatastrophic-nonobserving-marylyn.ngrok-free.dev/paitent/update-fcmToken',
        ),
        body: jsonEncode({"fcmToken": token}),
      );

      if (response.statusCode == 200) {
        debugPrint("FCM Token updated on backend");
      } else {
        debugPrint(" Failed to update Token: ${response.statusCode}");
        debugPrint("Response Body: ${response.body}");
      }
    } catch (e) {
      debugPrint(" Error updating token: $e");
    }
  }
}
