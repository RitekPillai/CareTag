import 'dart:convert';
import 'dart:typed_data';

import 'package:caretag/Modules/card_registration/data/model/registrationresponsemodel.dart';
import 'package:caretag/utils/storageService.dart';
import 'package:cryptography/cryptography.dart' hide KeyPair, Hash;
import 'package:fast_rsa/fast_rsa.dart';
import 'package:flutter/cupertino.dart';

class Cryptographyservice {
  final Storageservice storageservice = Storageservice();
  final _aesAlgorithm = AesGcm.with256bits();

  Future<void> generatingRsaKey() async {
    KeyPair result = await RSA.generate(2048);
    debugPrint("Public Key:${result.publicKey}");
    debugPrint("Private Key:${result.privateKey}");

    await storageservice.saveRsaKeys(result);
  }

  Future<SecretKey> generatingAesKey() async {
    return _aesAlgorithm.newSecretKey();
  }

  Future<Registrationmodel> encrypingData(String data, SecretKey aesKey) async {
    final aeskeyBytes = await aesKey.extractBytes();
    final Uint8List uint8keybytes = Uint8List.fromList(aeskeyBytes);

    final String? rsaPublicKey = await storageservice.getRsaPublicKey();
    if (rsaPublicKey == null) {
      throw Exception("RSA Public Key not found. Please register first.");
    }

    ///encrypting the data
    final encrpyt = await _aesAlgorithm.encryptString(data, secretKey: aesKey);

    final aeskeyEncrytion = await RSA.encryptOAEPBytes(
      uint8keybytes,
      "CareTag-AES-KEY",
      Hash.SHA256,
      rsaPublicKey,
    );

    return Registrationmodel(
      ciphertext: base64Encode(encrpyt.cipherText),
      encryptedAesKey: base64Encode(aeskeyEncrytion),
      iv: base64Encode(encrpyt.nonce),
      mac: base64Encode(encrpyt.mac.bytes),
      rsaPublicKey: rsaPublicKey,
    );
  }

  Future<String> decryptingData(Registrationmodel model) async {
    ///getting the privater key RSA
    String? privateKey = await storageservice.getRsaPrivateKey();

    /// decoding the wrapone
    Uint8List encrytedAesKey = base64Decode(model.encryptedAesKey);
    Uint8List decodingKey = await RSA.decryptOAEPBytes(
      encrytedAesKey,
      "CareTag-AES-KEY",
      Hash.SHA256,
      privateKey!,
    );

    ///

    final aesKey = SecretKey(decodingKey);

    final secretbox = SecretBox(
      base64Decode(model.ciphertext),
      nonce: base64Decode(model.iv),
      mac: Mac(base64Decode(model.mac)),
    );
    try {
      return await _aesAlgorithm.decryptString(secretbox, secretKey: aesKey);
    } catch (e) {
      throw Exception(
        "Decryption failed: integrity check (MAC) failed or invalid key.",
      );
    }
  }
}
