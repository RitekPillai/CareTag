// hospital_event.dart
import 'package:caretag/Modules/Hospital/model/NearByHospitalModel.dart';
import 'package:caretag/Modules/Hospital/model_view/repo/Hospital_repo.dart';
import 'package:caretag/Modules/auth/model_view/service/AuthenticationService.dart';
import 'package:caretag/Modules/doctor_details/model_view/repo/doctor_detail_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class HospitalEvent {}

class FetchNearbyHospitals extends HospitalEvent {}

// hospital_state.dart
abstract class HospitalState {}

class HospitalInitial extends HospitalState {}

class HospitalLoading extends HospitalState {}

class HospitalLoaded extends HospitalState {
  final List<NearbyHospitalModel> hospitals;
  HospitalLoaded(this.hospitals);
}

class HospitalError extends HospitalState {
  final String message;
  HospitalError(this.message);
}

// hospital_bloc.dart
class HospitalBloc extends Bloc<HospitalEvent, HospitalState> {
  final HospitalRepo repo;
  final Authenticationservice auth;

  HospitalBloc(this.repo, this.auth) : super(HospitalInitial()) {
    on<FetchNearbyHospitals>((event, emit) async {
      emit(HospitalLoading());
      try {
        final hospitals = await repo.getNearbyHospitals(auth);
        emit(HospitalLoaded(hospitals));
      } catch (e) {
        emit(HospitalError(e.toString()));
      }
    });
  }
}
