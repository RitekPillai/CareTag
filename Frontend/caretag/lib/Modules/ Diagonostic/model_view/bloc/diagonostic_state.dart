part of 'diagonostic_bloc.dart';

sealed class DiagonosticState {}

class DiagonosticInitiall extends DiagonosticState {}

class DiagonosticFalied extends DiagonosticState {}

class DiagonosticLoading extends DiagonosticState {}

class DiagonosticListFetched extends DiagonosticState {
  final List<DiagonosticListModel> diagonosticListModel;

  DiagonosticListFetched({required this.diagonosticListModel});
}

class DiagonosticDetailFetched extends DiagonosticState {
  final DiagonosticDetailModel diagonosticDetailModel;

  DiagonosticDetailFetched({required this.diagonosticDetailModel});
}
