part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class Authenticated extends AuthState {}

final class NewUser extends AuthState {}

final class LoginScreen extends AuthState {}

final class LoginCompleted extends AuthState {
  final String message;

  LoginCompleted({required this.message});

  @override
  List<Object?> get props => [message, DateTime.now()];
}

final class AuthCompleted extends AuthState {
  final DateTime time = DateTime.now();
  @override
  List<Object?> get props => [time];
}

final class SignUpCOmpleted extends AuthState {
  final DateTime time = DateTime.now();
  @override
  List<Object?> get props => [time];
}

final class AuthFailed extends AuthState {
  final String message;

  AuthFailed({required this.message});
}
