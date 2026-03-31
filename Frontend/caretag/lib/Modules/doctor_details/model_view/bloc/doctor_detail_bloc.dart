import 'package:bloc/bloc.dart';
import 'package:caretag/Modules/auth/model_view/service/AuthenticationService.dart';
import 'package:caretag/Modules/doctor_details/model/doctor_filer_model.dart';
import 'package:caretag/Modules/doctor_details/model/get_doctor_detail_model.dart';
import 'package:caretag/Modules/doctor_details/model/get_doctor_model.dart';
import 'package:caretag/Modules/doctor_details/model/near_by_doctor_model.dart';
import 'package:caretag/Modules/doctor_details/model/search_doctor_model.dart';
import 'package:caretag/Modules/doctor_details/model_view/repo/doctor_detail_repo.dart';
import 'package:flutter/material.dart';

part 'doctor_detail_state.dart';
part 'doctor_detail_event.dart';

class DoctorDetailBloc extends Bloc<DoctorDetailEvent, DoctorDetailState> {
  final Authenticationservice authenticationservice;
  final DoctorDetailRepo _repo;

  DoctorDetailBloc(this.authenticationservice, this._repo)
    : super(InitinalState()) {
    on<FetchDoctorDashboard>(_onFetchDoctorDashboard); // Combined fetch
    on<GetMyDoctorDetails>(onGetMyDoctorDetails);

    on<PerformSearch>(_onPerformSearch);
  }

  Future<void> _onFetchDoctorDashboard(
    FetchDoctorDashboard event,
    Emitter emit,
  ) async {
    emit(DoctorDetailLoadingState());

    try {
      // Call your new Repo method that hits the combined endpoint
      final dashboardData = await _repo.getDoctorDashboard(
        authenticationservice,
      );

      emit(
        DoctorDashboardLoaded(
          myDoctors: dashboardData.myDoctors,
          nearbyDoctors: dashboardData.nearbyTopRatedDoctors,
        ),
      );
    } catch (e) {
      debugPrint("Error fetching dashboard: ${e.toString()}");
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
        event.id!,
      );
      emit(MyDoctorDetailSuccess(doctorDetails: myDoctorDetails));
    } catch (e) {
      debugPrint("Error:${e.toString()}");
      emit(ErrorState());
    }
  }

  Future<void> _onPerformSearch(PerformSearch event, Emitter emit) async {
    emit(DoctorDetailLoadingState());

    try {
      final doctors = await _repo.searchDoctors(
        authenticationservice,
        event.filter,
      );
      emit(SearchLoaded(doctors: doctors));
    } catch (e) {
      emit(ErrorState());
    }
  }
}
