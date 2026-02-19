import 'package:fast_rsa/fast_rsa.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storageservice {
  final storage = const FlutterSecureStorage();
  final String _acessToken = "acessToken";
  final String _refreshToken = "refreshToken";

  final String _rsaPublicKey = "rsaPublicKey";
  final String _rsaPrivateKey = "rsaPrivateKey";

  final String _NewUser = "newuser";

  final String careTagId = "careTagId";

  final String bluetoothId = "bid";

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
    await storage.write(key: _NewUser, value: "true");
  }

  Future<bool> hasSeenIntro() async {
    String? value = await storage.read(key: _NewUser);
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
  }

  Future<String?> getAcessToken() async {
    return storage.read(key: _acessToken);
  }

  Future<String?> getRefreshToken() async {
    return storage.read(key: _refreshToken);
  }

  Future<void> clearAll() async {
    await storage.delete(key: _acessToken);
    await storage.delete(key: _refreshToken);
  }

  Future<void> saveBId(String bid) async {
    await storage.write(key: bluetoothId, value: bid);
  }

  Future<String?> getBid() async {
    return storage.read(key: bluetoothId);
  }
}
