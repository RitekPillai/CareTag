class VerifyResponse {
  String? username;
  String? jwtToken;
  String? responseToken;

  VerifyResponse({this.username, this.jwtToken, this.responseToken});

  VerifyResponse.fromJson(Map<String, dynamic> json) {
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
