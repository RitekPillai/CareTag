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
import 'package:caretag/Modules/home/model/RecordAccessAcceptModel.dart';
import 'package:caretag/Modules/profile/model/profile_edit_model.dart';
import 'package:caretag/Modules/records_module/model/prescription_model.dart';
import 'package:caretag/Modules/records_module/model/prescription_detail_model.dart';
import 'package:caretag/utils/hiveService.dart';
import 'package:caretag/utils/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

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

  void requestAccept(String docId) async {
    log(docId);
    Map<String, dynamic> payload = {"docId": docId};
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
          "https://uncatastrophic-nonobserving-marylyn.ngrok-free.dev/link/block",
        ),
        body: jsonEncode(payload),
      );
      if (response.statusCode == 200) {
        log("Request sent sucessFully");
      }

      log("Response: ${response.body}");
    } catch (e) {
      log("Error in blockRequest: $e");
      rethrow;
    }
  }

  Future<List<PrescriptionModel>> getAllPrescription() async {
    try {
      final respons = await authenticationService.get(
        Uri.parse("$baseUrl/prescription/list"),
      );

      if (respons.statusCode == 200) {
        final List<dynamic> data = jsonDecode(respons.body);
        return data.map((e) => PrescriptionModel.fromJson(e)).toList();
      } else {
        throw Exception("Failed to fetch prescriptions");
      }
    } catch (e) {
      log("Error in getAllPrescription: $e");
      rethrow;
    }
  }

  Future<PrescriptionDetail> getPrescriptionDetail(
    String prescriptionId,
  ) async {
    try {
      final response = await authenticationService.post(
        Uri.parse("$baseUrl/prescription"),
        body: prescriptionId,
      );
      if (response.statusCode == 200) {
        return PrescriptionDetail.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to fetch prescription details");
      }
    } catch (e) {
      log("Error in getAllPrescription: $e");
      rethrow;
    }
  }

  Future<void> profileEdit(ProfileEditModel model) async {
    final authService = Authenticationservice();

    var uri = Uri.parse("$baseUrl/update");

    var request = http.MultipartRequest("POST", uri);

    request.fields['fullName'] = model.fullName ?? "";
    request.fields['dob'] = model.dob ?? "";
    request.fields['gender'] = model.gender ?? "";
    request.fields['bloodGroup'] = model.bloodGroup ?? "";
    request.fields['height'] = model.height ?? "";
    request.fields['weight'] = model.weight ?? "";
    request.fields['allergies'] = model.allergies ?? "";

    if (model.imagePath != null && model.imagePath!.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath('image', model.imagePath!),
      );
    }

    try {
      final streamedResponse = await authService.send(request);

      if (streamedResponse.statusCode == 200) {
        log("Profile updated successfully on server!");
      } else {
        log("Upload failed with status: ${streamedResponse.statusCode} ");
      }
    } catch (e) {
      log("Error sending multipart request: $e");
      rethrow;
    }
  }

  void recordAccessAccept(
    Recordaccessacceptmodel recordAccessAcceptModel,
  ) async {
    final paylaod = recordAccessAcceptModel.toJson();
    log("payload: $paylaod");

    try {
      final response = await authenticationService.post(
        Uri.parse("$baseUrl/record/accept"),
        body: jsonEncode(paylaod),
      );
      if (response.statusCode == 200) {
        log("Request has been send successfully");
      } else {
        throw Exception("Failed to accept record access request");
      }
    } catch (e) {
      log("Some error has been occured From repo:$e");
      rethrow;
    }
  }

  void recordAccessDeny(String encounterId, String docId) async {
    Map<String, String> payload = {"docId": docId, "encounterId": encounterId};
    try {
      final response = await authenticationService.post(
        Uri.parse("$baseUrl/record/deny"),
        body: jsonEncode(payload),
      );
      if (response.statusCode == 200) {
        log("Record access denied successfully");
      } else {
        throw Exception("Failed to deny record access request");
      }
    } catch (e) {
      log("Error denying record access: $e");
      rethrow;
    }
  }
}
