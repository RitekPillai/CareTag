part of 'search_bloc.dart';

sealed class SearchEvent {}

class PerformSearch extends SearchEvent {
  final DoctorFilterModel filter;

  PerformSearch({required this.filter});
}

class ClearSearch extends SearchEvent {}
