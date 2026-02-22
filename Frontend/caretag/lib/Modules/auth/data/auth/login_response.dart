class LoginOtpResponse {
  String? token;
  String? refreshToken;
  bool? registered; // You can keep this name in Dart...

  LoginOtpResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refreshToken = json['refreshToken'];
    // ...but point it to 'isRegistered' from the Java JSON
    registered = json['registered'];
  }
}
