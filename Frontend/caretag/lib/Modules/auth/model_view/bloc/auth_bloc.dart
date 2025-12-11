import 'package:bloc/bloc.dart';
import 'package:caretag/Modules/auth/data/auth/login_request.dart';
import 'package:caretag/Modules/auth/data/auth/signup_request.dart';
import 'package:caretag/Modules/auth/data/repo/auth_repo.dart';
import 'package:caretag/Modules/auth/model_view/service/storageService.dart';
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
      String resposne = await _authRepo.signUp(req);
      debugPrint("Response :- $resposne");
      emit(AuthCompleted());
    } catch (e) {
      debugPrint(e.toString());
      emit(AuthFailed(message: e.toString()));
    }
  }

  Future<void> _onLoginRequest(AuthLoginRequest event, Emitter emit) async {
    emit(AuthLoading());
    try {
      String response = await _authRepo.login(event.loginRequest);
      debugPrint("Reponse Login from Bloc -----$response");
      AuthCompleted();
    } catch (e) {
      debugPrint(e.toString());
      AuthFailed(message: e.toString());
    }
  }

  @override
  void onChange(Change<AuthState> change) {
    // TODO: implement onChange
    debugPrint("Current State: ${change.currentState}");
    debugPrint("Next State:${change.nextState}");
    super.onChange(change);
  }
}
