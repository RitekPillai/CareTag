import 'package:caretag/Modules/%20Diagonostic/model/diagonostic_detail_model.dart';
import 'package:caretag/Modules/%20Diagonostic/model/diagonostic_list_model.dart';
import 'package:caretag/Modules/%20Diagonostic/model_view/repo/diagonostic_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'diagonostic_state.dart';
part 'diagonostic_event.dart';

class DiagonosticBloc extends Bloc<DiagonosticEvent, DiagonosticState> {
  final DiagonosticRepo diagonosticRepo;
  DiagonosticBloc(this.diagonosticRepo) : super(DiagonosticInitiall()) {
    on<GetDiagnosticList>(_onGetDiagnosticList);
    on<GetDiagonosticDetail>(_onGetDiagonosticDetail);
  }

  Future<void> _onGetDiagnosticList(
    GetDiagnosticList event,
    Emitter<DiagonosticState> emit,
  ) async {
    emit(DiagonosticLoading());
    try {
      List<DiagonosticListModel> diagonosticListModel = await diagonosticRepo
          .getDiagonosticList();
      emit(DiagonosticListFetched(diagonosticListModel: diagonosticListModel));
    } catch (e) {
      emit(DiagonosticFalied());
    }
  }

  Future<void> _onGetDiagonosticDetail(
    GetDiagonosticDetail event,
    Emitter<DiagonosticState> emit,
  ) async {
    emit(DiagonosticLoading());
    try {
      DiagonosticDetailModel diagonosticDetailModel = await diagonosticRepo
          .getDiagonosticDetailModel(event.id);
      emit(
        DiagonosticDetailFetched(
          diagonosticDetailModel: diagonosticDetailModel,
        ),
      );
    } catch (e) {
      print(e.toString());
      emit(DiagonosticFalied());
    }
  }

  @override
  void onTransition(Transition<DiagonosticEvent, DiagonosticState> transition) {
    debugPrint("Current State:${transition.currentState}");
    debugPrint("next State:${transition.nextState}");
    super.onTransition(transition);
  }
}
