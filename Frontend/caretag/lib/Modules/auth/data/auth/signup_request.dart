class SignUpRequest {
  String? username;
  String? password;
  String? email;

  SignUpRequest({this.username, this.password, this.email});

  SignUpRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['email'] = email;
    return data;
  }
}
