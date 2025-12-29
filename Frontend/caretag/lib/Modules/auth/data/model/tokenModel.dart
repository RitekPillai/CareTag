import 'package:equatable/equatable.dart';

class Tokenmodel extends Equatable {
  final String refreshToken;
  final String accessToken;
  final String username;
  final bool isNew;

  const Tokenmodel({
    required this.refreshToken,
    required this.accessToken,
    required this.username,
    this.isNew = false, // Optional parameter
  });

  factory Tokenmodel.fromJson(Map<String, dynamic> json) {
    return Tokenmodel(
      username: json['username'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      accessToken: json['token'] ?? '',
      isNew: json['isNew'] ?? false,
    );
  }

  @override
  List<Object?> get props => [refreshToken, accessToken, username, isNew];
}
