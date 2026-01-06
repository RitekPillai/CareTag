import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:caretag/Modules/auth/data/auth/forgot_password_request.dart';
import 'package:caretag/Modules/auth/data/auth/login_request.dart';
import 'package:caretag/Modules/auth/data/auth/signup_request.dart';
import 'package:caretag/Modules/auth/data/model/authException.dart';
import 'package:caretag/Modules/auth/data/model/otpVerifyRequest.dart';
import 'package:caretag/Modules/auth/data/model/tokenModel.dart';
import 'package:caretag/Modules/auth/data/repo/auth_repo.dart';
import 'package:caretag/utils/storageService.dart';
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
    on<OnAppStart>(_onAppStart);
  }
  Future<void> _onAppStart(OnAppStart event, Emitter emit) async {
    emit(AuthLoading());
    try {
      final String message = await _authRepo.isAuthenticated();
      final String result = message.toLowerCase().trim();

      debugPrint("Auth State Check: $result");

      if (result == "homepage") {
        return emit(Authenticated());
      }

      if (result == "newuser") {
        return emit(NewUser());
      }

      if (result == "loginscreen") {
        return emit(LoginScreen());
      }

      if (result == "registration needed") {
        return emit(SignUpCOmpleted());
      }

      emit(LoginScreen());
    } catch (e) {
      debugPrint("Auth Error: $e");
      emit(AuthFailed(message: e.toString()));
    }
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
      debugPrint("done");
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

      Tokenmodel tokenmodel = await _authRepo.loginOtpVerify(req);
      debugPrint("isRegister:${tokenmodel.isRegister.toString()}");
      if (tokenmodel.isRegister == true) {
        emit(Authenticated());
      } else {
        emit(SignUpCOmpleted());
      }
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
      await _authRepo.emailVerification(event.email);
      emit(SignUpCOmpleted());
    } catch (e) {
      debugPrint(e.toString());
      emit(AuthFailed(message: e.toString()));
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

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    debugPrint("Current State:${transition.currentState}");
    debugPrint("next State:${transition.nextState}");
    super.onTransition(transition);
  }
}
