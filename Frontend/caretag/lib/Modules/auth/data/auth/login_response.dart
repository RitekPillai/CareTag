class LoginResponse {
  String? username;
  String? jwtToken;
  String? responseToken;

  LoginResponse({
    required this.username,
    required this.jwtToken,
    required this.responseToken,
  });

  LoginResponse.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    jwtToken = json['token'];
    responseToken = json['RefreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['token'] = jwtToken;
    data['RefreshToken'] = responseToken;
    return data;
  }
}
