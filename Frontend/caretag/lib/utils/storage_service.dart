import 'dart:convert';
import 'dart:typed_data';

import 'package:fast_rsa/fast_rsa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

class Storageservice {
  final storage = FlutterSecureStorage();

  final String _acessToken = "accessToken";

  final String _refreshToken = "refreshToken";

  final String _rsaPublicKey = "rsaPublicKey";
  final String _rsaPrivateKey = "rsaPrivateKey";

  final String _newUser = "newuser";

  final String careTagId = "careTagId";

  final String bluetoothId = "bid";

  final String _localKey = "hive_valut_key";

  ///saving local key
  Future<Uint8List> getOrCreateLocalKey() async {
    String? base64Key = await storage.read(key: _localKey);
    if (base64Key == null) {
      final List<int> newKey = Hive.generateSecureKey();
      await storage.write(key: _localKey, value: base64UrlEncode(newKey));

      return Uint8List.fromList(newKey);
    } else {
      return base64Url.decode(base64Key);
    }
  }

  Future<void> clearLocalKey() async {
    await storage.delete(key: _localKey);
  }

  ///RSA
  Future<void> saveRsaKeys(KeyPair keys) async {
    await storage.write(key: _rsaPublicKey, value: keys.publicKey);
    await storage.write(key: _rsaPrivateKey, value: keys.privateKey);
  }

  Future<void> saveCareTagId(String careTagIdValue) async {
    await storage.write(key: careTagId, value: careTagIdValue);
  }

  Future<String?> getCareTagId() async {
    return await storage.read(key: careTagId);
  }

  Future<void> setTrueNewUser() async {
    await storage.write(key: _newUser, value: "true");
  }

  Future<String?> getNewUser() async {
    return await storage.read(key: _newUser);
  }

  Future<bool> hasSeenIntro() async {
    String? value = await storage.read(key: _newUser);
    return value == "true";
  }

  Future<String?> getRsaPublicKey() async {
    return await storage.read(key: _rsaPublicKey);
  }

  Future<String?> getRsaPrivateKey() async {
    return await storage.read(key: _rsaPrivateKey);
  }

  ////JWT TOKESN

  Future<void> saveToken(String acessToken, String refreshToken) async {
    await storage.write(key: _acessToken, value: acessToken);
    await storage.write(key: _refreshToken, value: refreshToken);
    debugPrint("Keys saved :$acessToken and $refreshToken");
  }

  Future<String?> getAcessToken() async {
    return storage.read(key: _acessToken);
  }

  Future<String?> getRefreshToken() async {
    return storage.read(key: _refreshToken);
  }

  Future<void> saveBId(String bid) async {
    await storage.write(key: bluetoothId, value: bid);
  }

  Future<String?> getBid() async {
    return storage.read(key: bluetoothId);
  }

  Future<void> clearAll() async {
    await storage.delete(key: _acessToken);
    await storage.delete(key: _refreshToken);
  }
}
