import 'package:equatable/equatable.dart';

class Tokenmodel extends Equatable {
  final String refreshToken;
  final String accessToken;
  final bool isRegistered;

  const Tokenmodel({
    required this.refreshToken,
    required this.accessToken,
    required this.isRegistered,
  });

  factory Tokenmodel.fromJson(Map<String, dynamic> json) {
    return Tokenmodel(
      refreshToken: json['refreshToken'] ?? '',
      accessToken: json['jwtToken'] ?? '',
      isRegistered: json['isRegistered'] ?? false,
    );
  }

  @override
  List<Object?> get props => [refreshToken, accessToken];
}
