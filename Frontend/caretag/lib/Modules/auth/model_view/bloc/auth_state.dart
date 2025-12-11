part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthCompleted extends AuthState {}

final class AuthFailed extends AuthState {
  final String message;

  AuthFailed({required this.message});
}
