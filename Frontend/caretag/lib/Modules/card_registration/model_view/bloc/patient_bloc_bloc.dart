import 'package:bloc/bloc.dart';
import 'package:caretag/Modules/card_registration/data/model/medicarecordmodel.dart';
import 'package:caretag/Modules/card_registration/data/repos/paitent_repo.dart';
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
      Medicarecordmodel record = await _paitentRepo.getRecord();
      debugPrint(
        "Medical recod \n\n ${record.basicPersonalDetails.bloodgroup} ${record.lifeStyleDetails.excercise}",
      );
      emit(RecordFetched(record));
    } catch (e) {
      emit(Failed(message: e.toString()));
    }
  }
}
