import 'dart:convert';

import 'package:caretag/Modules/auth/data/model/authException.dart';
import 'package:caretag/Modules/auth/model_view/service/AuthenticationService.dart';
import 'package:caretag/Modules/card_registration/data/model/medicarecordmodel.dart';
import 'package:caretag/Modules/card_registration/data/model/registrationresponsemodel.dart';
import 'package:caretag/Modules/card_registration/data/model/shippingRegistration.dart';
import 'package:caretag/Modules/card_registration/model_view/service/cryptographyservice.dart';
import 'package:caretag/utils/storageService.dart';
import 'package:flutter/material.dart';

class PaitientRepo {
  final Cryptographyservice cryptographyservice = Cryptographyservice();
  final Authenticationservice authenticationService = Authenticationservice();
  final Storageservice storageservice = Storageservice();
  final String baseUrl =
      "https://uncatastrophic-nonobserving-marylyn.ngrok-free.dev/paitent";

  Future<String> medicalRegistration(Medicarecordmodel medicalRecord) async {
    ///create rsa key
    await cryptographyservice.generatingRsaKey();

    ///create aes key
    final aeskey = await cryptographyservice.generatingAesKey();

    var data = jsonEncode(medicalRecord.toJson());

    Registrationmodel finalResposne = await cryptographyservice.encrypingData(
      data,
      aeskey,
    );

    final reponse = await authenticationService.post(
      Uri.parse("$baseUrl/register"),
      body: jsonEncode(finalResposne.toJson()),
    );

    if (reponse.statusCode >= 200 || reponse.statusCode <= 203) {
      String careTagId = reponse.body;
      debugPrint("CareTagID:$careTagId");
      await storageservice.saveCareTagId(careTagId);
      return careTagId;
    }
    throw Exception();
  }

  Future<Medicarecordmodel> getRecord() async {
    String? careTagId = await storageservice.getCareTagId();
    final response = await authenticationService.post(
      Uri.parse("$baseUrl/record"),
      body: careTagId,
    );
    debugPrint("response:${response.body}");
    try {
      if (response.statusCode == 200) {
        Registrationmodel data = Registrationmodel.fromJson(
          jsonDecode(response.body),
        );
        String jsonData = await cryptographyservice.decryptingData(data);
        return Medicarecordmodel.fromJson(jsonDecode(jsonData));
      } else {
        throw Exception();
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> subscription(Shippingregistration req) async {
    Map<String, dynamic> payload = req.toJson();
    final respoonse = await authenticationService.post(
      Uri.parse("$baseUrl/subscripiton"),
      body: jsonEncode(payload),
    );
    try {
      if (respoonse.statusCode == 200) {
        debugPrint("Saved Success fully");
      } else {
        throw AuthException(
          StatusCode: "",
          errorMessage: respoonse.body,
          timeStamp: "",
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
