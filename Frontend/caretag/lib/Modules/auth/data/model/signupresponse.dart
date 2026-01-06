import 'package:equatable/equatable.dart';

class Signupresponse extends Equatable {
  final String refreshToken;
  final String accessToken;
  final String username;

  const Signupresponse({
    required this.refreshToken,
    required this.accessToken,
    required this.username,
  });

  factory Signupresponse.fromJson(Map<String, dynamic> json) {
    return Signupresponse(
      username: json['username'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      accessToken: json['token'] ?? '',
    );
  }

  @override
  List<Object?> get props => [refreshToken, accessToken, username];
}
