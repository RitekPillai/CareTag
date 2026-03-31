import 'package:bloc/bloc.dart';
import 'package:caretag/Modules/auth/model_view/service/AuthenticationService.dart';
import 'package:caretag/Modules/doctor_details/model/get_doctor_detail_model.dart';
import 'package:caretag/Modules/doctor_details/model/get_doctor_model.dart';
import 'package:caretag/Modules/doctor_details/model_view/repo/doctor_detail_repo.dart';
import 'package:flutter/material.dart';

part 'doctor_detail_state.dart';
part 'doctor_detail_event.dart';

class DoctorDetailBloc extends Bloc<DoctorDetailEvent, DoctorDetailState> {
  final Authenticationservice authenticationservice;
  final DoctorDetailRepo _repo;
  DoctorDetailBloc(this.authenticationservice, this._repo)
    : super(InitinalState()) {
    on<GetMyDoctor>(onGetDoctor);
    on<GetMyDoctorDetails>(onGetMyDoctorDetails);
  }

  Future<void> onGetDoctor(DoctorDetailEvent event, Emitter emit) async {
    emit(DoctorDetailLoadingState());

    try {
      final myDoctors = await _repo.getMyDoctor(authenticationservice);
      debugPrint("mydoctods--------------------- $myDoctors");
      emit(MyDoctorSuccess(myDoctors: myDoctors));
    } catch (e) {
      debugPrint("Error:${e.toString()}");
      emit(ErrorState());
    }
  }

  Future<void> onGetMyDoctorDetails(
    GetMyDoctorDetails event,
    Emitter emit,
  ) async {
    emit(DoctorDetailLoadingState());
    try {
      final myDoctorDetails = await _repo.getMyDoctorDetails(
        authenticationservice,
        event.id,
      );
      emit(MyDoctorDetailSuccess(doctorDetails: myDoctorDetails));
    } catch (e) {
      debugPrint("Error:${e.toString()}");
      emit(ErrorState());
    }
  }

  @override
  void onTransition(
    Transition<DoctorDetailEvent, DoctorDetailState> transition,
  ) {
    debugPrint("Current State:${transition.currentState}");
    debugPrint("next State:${transition.nextState}");
    super.onTransition(transition);
  }
}
