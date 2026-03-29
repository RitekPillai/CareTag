part of 'diagonostic_bloc.dart';

sealed class DiagonosticEvent {}

class GetDiagnosticList extends DiagonosticEvent {}

class GetDiagonosticDetail extends DiagonosticEvent {
  final int id;

  GetDiagonosticDetail({required this.id});
}
