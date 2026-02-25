import 'dart:convert';
import 'dart:developer';

import 'package:caretag/Modules/auth/data/model/authException.dart';
import 'package:caretag/Modules/auth/model_view/service/AuthenticationService.dart';
import 'package:caretag/Modules/card_registration/data/model/acceptReqModel.dart';
import 'package:caretag/Modules/card_registration/data/model/bloc_req_model.dart';
import 'package:caretag/Modules/card_registration/data/model/medicarecordmodel.dart';
import 'package:caretag/Modules/card_registration/data/model/profileModel.dart';
import 'package:caretag/Modules/card_registration/data/model/registrationresponsemodel.dart';
import 'package:caretag/Modules/card_registration/data/model/reordRequestModel.dart';
import 'package:caretag/Modules/card_registration/data/model/shippingRegistration.dart';
import 'package:caretag/Modules/card_registration/model_view/service/cryptographyservice.dart';
import 'package:caretag/Modules/home/model/permissionRequestModel.dart';
import 'package:caretag/utils/hiveService.dart';
import 'package:caretag/utils/storageService.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PaitientRepo {
  final Cryptographyservice cryptographyservice = Cryptographyservice();
  final Authenticationservice authenticationService = Authenticationservice();
  final Storageservice storageservice = Storageservice();
  final String baseUrl =
      "https://uncatastrophic-nonobserving-marylyn.ngrok-free.dev/paitent";
  final hiveservice = Hiveservice();

  Future<String> medicalRegistration(
    Medicarecordmodel medicalRecord,
    String fcmToken,
  ) async {
    await cryptographyservice.generatingRsaKey();

    final aeskey = await cryptographyservice.generatingAesKey();
    final box = Hive.box('decrypted_records');
    final bytes = await aeskey.extractBytes();
    await box.put('aesKeyBytes', bytes);

    final sensitiveData = {
      'medicalDetails': medicalRecord.medicalDetails.toJson(),
      'emergencyDetails': medicalRecord.emergencyDetails.toJson(),
      'insuranceDetails': medicalRecord.insuranceDetails.toJson(),
      'lifeStyleDetails': medicalRecord.lifeStyleDetails.toJson(),
    };

    Registrationmodel finalResposne = await cryptographyservice.encrypingData(
      jsonEncode(sensitiveData),
      aeskey,
      medicalRecord.basicPersonalDetails,
      fcmToken,
    );

    log(
      "PayLoad of the  Medical Registration:\n${finalResposne.basicPersonalDetails!.fullname}\n${finalResposne.ciphertext}",
    );

    final reponse = await authenticationService.post(
      Uri.parse("$baseUrl/register"),
      body: jsonEncode(finalResposne.toJson()),
    );
    log("paylaod :${finalResposne.toJson()}");
    log(jsonEncode(finalResposne.toJson()));

    if (reponse.statusCode >= 200 || reponse.statusCode <= 203) {
      String careTagId = reponse.body;
      debugPrint("CareTagID:$careTagId");
      await storageservice.saveCareTagId(careTagId);
      return careTagId;
    }
    throw Exception();
  }

  Future<Profilemodel> getProfileData() async {
    try {
      final response = await authenticationService.get(
        Uri.parse("$baseUrl/profile"),
      );
      if (response.statusCode >= 200 || response.statusCode <= 203) {
        Profilemodel profilemodel = Profilemodel.formJson(
          jsonDecode(response.body),
        );
        await hiveservice.saveProfileData(profilemodel);
        return profilemodel;
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

  Future<MedicalDetails> getRecord() async {
    String? careTagId = await storageservice.getCareTagId();

    final response = await authenticationService.post(
      Uri.parse("$baseUrl/record"),
      body: careTagId,
    );

    try {
      if (response.statusCode == 200) {
        RecordRequestModel recordRequestModel = RecordRequestModel.fromJson(
          jsonDecode(response.body),
        );
        log("Cipper text ${recordRequestModel.ciphertext}");
        log("IV ${recordRequestModel.iv}");
        log("mac ${recordRequestModel.mac}");
        log("aes ${recordRequestModel.encryptedAesKey}");
        log("rsa ${recordRequestModel.rsaPublicKey}");

        String decrptedData = await cryptographyservice.decryptingData(
          recordRequestModel,
        );

        await hiveservice.decryptAndSaveToHive(decrptedData);
        return MedicalDetails.fromJson(jsonDecode(decrptedData));

        // await hiveservice.decryptAndSaveToHive(registrationmodel);

        // Registrationmodel data = Registrationmodel.fromJson(
        //   jsonDecode(response.body),
        // );
        // log("response from getRecord ${data.iv},${data.basicPersonalDetails}");
        // String jsonData = await cryptographyservice.decryptingData(data);

        // await hiveservice.decryptAndSaveToHive(data);

        // return Medicarecordmodel.fromJson(jsonDecode(jsonData));
      } else {
        throw Exception();
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
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

  void requestAccept(Acceptreqmodel acceptReqModel) async {
    log(acceptReqModel.docEmail);
    Map<String, dynamic> payload = acceptReqModel.toJson();
    try {
      final response = await authenticationService.post(
        Uri.parse(
          "https://uncatastrophic-nonobserving-marylyn.ngrok-free.dev/link/accept",
        ),
        body: jsonEncode(payload),
      );
      if (response.statusCode == 200) {
        log(" Success: ${response.body}");
        return;
      }
      throw Exception(
        "Backend Error: ${response.statusCode} - ${response.body}",
      );
    } catch (e) {
      log("error$e");
      rethrow;
    }
  }

  void denyRequest(String docId) async {
    try {
      log("DocId: $docId");
      final response = await authenticationService.post(
        Uri.parse(
          'https://uncatastrophic-nonobserving-marylyn.ngrok-free.dev/link/deny',
        ),
        body: docId,
      );
      if (response.statusCode == 200) {
        log("Request sent sucessFully");
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }

  void blockRequest(BlockReqModel req) async {
    Map<String, dynamic> payload = req.toJson();
    try {
      final response = await authenticationService.post(
        Uri.parse(
          "https://uncatastrophic-nonobserving-marylyn.ngrok-free.dev/link/deny",
        ),
        body: jsonEncode(payload),
      );
      if (response.statusCode == 200) {
        log("Request sent sucessFully");
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }
}
