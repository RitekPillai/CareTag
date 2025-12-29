import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:caretag/Modules/auth/data/auth/forgot_password_request.dart';
import 'package:caretag/Modules/auth/data/auth/login_request.dart';
import 'package:caretag/Modules/auth/data/auth/signup_request.dart';
import 'package:caretag/Modules/auth/data/model/authException.dart';
import 'package:caretag/Modules/auth/data/model/otpVerifyRequest.dart';
import 'package:caretag/Modules/auth/data/model/tokenModel.dart';
import 'package:caretag/Modules/auth/data/repo/auth_repo.dart';
import 'package:caretag/Modules/auth/model_view/service/storageService.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;
  final Storageservice _storageservice;
  AuthBloc(this._authRepo, this._storageservice) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<AuthSignUpRequest>(_onSignUpRequest);
    on<AuthLoginRequest>(_onLoginRequest);
    on<AuthForgotPassword>(_onForgotPasswordRequest);
    on<AuthEmailVerification>(_onEmailVerification);
    on<AuthLoginOtpVerify>(_onLoginOtpVerify);
    on<AuthoauthLogin>(_onOauthLogin);
  }

  Future<void> _onSignUpRequest(
    AuthSignUpRequest event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      SignUpRequest req = SignUpRequest(
        email: event.email,
        password: event.password,
        username: event.phone,
      );
      await _authRepo.signUp(req);
      emit(AuthCompleted());
    } catch (e) {
      if (e is AuthException) {
        emit(AuthFailed(message: e.errorMessage));
      }
    }
  }

  Future<void> _onLoginOtpVerify(
    AuthLoginOtpVerify event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      OtpVerifyModel req = OtpVerifyModel(
        email: event.req.email,
        otpCode: event.req.otpCode,
      );
      debugPrint(req.email);
      Tokenmodel tokenmodel = await _authRepo.loginOtpVerify(req);
      debugPrint(tokenmodel.refreshToken);
      emit(Authenticated());
    } catch (e) {
      debugPrint(e.toString());
      emit(AuthFailed(message: e.toString()));
    }
  }

  Future<void> _onLoginRequest(AuthLoginRequest event, Emitter emit) async {
    emit(AuthLoading());
    try {
      String message = await _authRepo.login(event.loginRequest);
      debugPrint("from block---$message");
      emit(LoginCompleted(message: message));
    } catch (e) {
      if (e is AuthException) {
        emit(AuthFailed(message: e.errorMessage));
      }
    }
  }

  Future<void> _onEmailVerification(
    AuthEmailVerification event,
    Emitter emit,
  ) async {
    try {
      emit(AuthLoading());
      await _authRepo.emailVerification();
      emit(SignUpCOmpleted());
    } catch (e) {
      debugPrint(e.toString());
      //  emit(AuthFailed(message: e.toString()));
    }
  }

  @override
  void onChange(Change<AuthState> change) {
    debugPrint("Current State: ${change.currentState}");
    debugPrint("Next State:${change.nextState}");
    super.onChange(change);
  }

  FutureOr<void> _onForgotPasswordRequest(
    AuthForgotPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authRepo.forgotPasswordOTPRequest(event.req);
      emit(AuthCompleted());
    } catch (e) {
      emit(AuthFailed(message: e.toString()));
    }
  }

  FutureOr<void> _onOauthLogin(
    AuthoauthLogin event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      Tokenmodel tokenmodel = await _authRepo.GoogleOauthSignUp();
      if (tokenmodel.isNew) {
        emit(SignUpCOmpleted());
      } else {
        emit(Authenticated());
      }
    } catch (e) {
      if (e is AuthException) {
        debugPrint(e.errorMessage);
        emit(AuthFailed(message: e.errorMessage));
      }
    }
  }
}
