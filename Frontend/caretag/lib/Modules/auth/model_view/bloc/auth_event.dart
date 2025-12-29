part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthSignUpRequest extends AuthEvent {
  final String email;
  final String phone;
  final String password;

  AuthSignUpRequest({
    required this.email,
    required this.phone,
    required this.password,
  });
}

class AuthEmailVerification extends AuthEvent {}

class AuthoauthLogin extends AuthEvent {}

class AuthLoginRequest extends AuthEvent {
  final LoginRequest loginRequest;

  AuthLoginRequest({required this.loginRequest});
}

class AuthForgotPassword extends AuthEvent {
  final ForgotPasswordRequest req;
  AuthForgotPassword({required this.req});
}

class AuthLoginOtpVerify extends AuthEvent {
  final OtpVerifyModel req;

  AuthLoginOtpVerify({required this.req});
}
