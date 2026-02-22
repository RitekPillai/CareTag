import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:caretag/Modules/card_registration/data/model/medicarecordmodel.dart';
import 'package:caretag/Modules/card_registration/data/model/profileModel.dart';
import 'package:caretag/Modules/card_registration/data/model/shippingRegistration.dart';
import 'package:caretag/Modules/card_registration/data/repos/paitent_repo.dart';
import 'package:caretag/utils/hiveService.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'patient_bloc_event.dart';
part 'patient_bloc_state.dart';

class PatientBloc extends Bloc<PatientBlocEvent, PatientBlocState> {
  final PaitientRepo _paitentRepo;

  PatientBloc(this._paitentRepo) : super(PatientBlocInitial()) {
    on<PatientBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<PatientRegistration>(_onPatientRegistration);
    on<GetPatientRecord>(_onGetPaitentRecord);
    on<SubscriptionEvent>(_onSubscription);
    on<BluetoothData>(_onBluetoohData);
    on<GetProfileData>(_onGetProfileData);
  }
  Future<void> _onPatientRegistration(
    PatientRegistration event,
    Emitter<PatientBlocState> emit,
  ) async {
    try {
      emit(Loading());
      String careTagId = await _paitentRepo.medicalRegistration(
        event.medicalRecord,
      );
      debugPrint(careTagId);
      emit(Success(careTagId: careTagId));
    } catch (e) {
      emit(Failed(message: e.toString()));
      debugPrint(e.toString());
    }
  }

  Future<void> _onGetPaitentRecord(GetPatientRecord event, Emitter emit) async {
    emit(Loading());
    try {
      await _paitentRepo.getRecord();

      //  emit(RecordFetched(record));
    } catch (e) {
      emit(Failed(message: e.toString()));
    }
  }

  Future<void> _onSubscription(SubscriptionEvent event, Emitter emit) async {
    emit(Loading());
    try {
      await _paitentRepo.subscription(event.shippingRegistration);
      emit(Subscribed());
    } catch (e) {
      emit(Failed(message: e.toString()));
    }
  }

  @override
  void onChange(Change<PatientBlocState> change) {
    debugPrint("State change hoagaa:$change");

    super.onChange(change);
  }

  FutureOr<void> _onBluetoohData(BluetoothData event, Emitter emit) {
    emit(Loading());
    try {} catch (e) {}
  }

  FutureOr<void> _onGetProfileData(
    GetProfileData event,
    Emitter<PatientBlocState> emit,
  ) async {
    emit(Loading());

    try {
      Profilemodel profilemodel = await _paitentRepo.getProfileData();
      emit(ProfileRecordFetched(profilemodel: profilemodel));
    } catch (e) {
      emit(Failed(message: e.toString()));
      debugPrint("Failed:$e");
    }
  }
}
