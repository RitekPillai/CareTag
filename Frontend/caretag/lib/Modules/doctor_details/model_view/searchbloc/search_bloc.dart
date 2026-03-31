import 'package:bloc/bloc.dart';
import 'package:caretag/Modules/auth/model_view/service/AuthenticationService.dart';
import 'package:caretag/Modules/doctor_details/model/doctor_filer_model.dart';
import 'package:caretag/Modules/doctor_details/model/search_doctor_model.dart';
import 'package:caretag/Modules/doctor_details/model_view/bloc/doctor_detail_bloc.dart';
import 'package:caretag/Modules/doctor_details/model_view/repo/doctor_detail_repo.dart';
import 'package:flutter/material.dart';
// import models and repo here

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final DoctorDetailRepo repository;
  final Authenticationservice authService;

  SearchBloc(this.repository, this.authService) : super(SearchInitial()) {
    on<PerformSearch>(_onPerformSearch);
    on<ClearSearch>((event, emit) => emit(SearchInitial()));
  }

  Future<void> _onPerformSearch(
    PerformSearch event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());

    try {
      final doctors = await repository.searchDoctors(authService, event.filter);
      emit(SearchLoaded(doctors: doctors));
    } catch (e) {
      emit(SearchError(message: e.toString()));
    }
  }
}
