part of 'doctor_detail_bloc.dart';

sealed class DoctorDetailEvent {}

// final class GetMyDoctor extends DoctorDetailEvent {}

final class GetMyDoctorDetails extends DoctorDetailEvent {
  final int id;
  GetMyDoctorDetails({required this.id});
}
//
// final class FetchNearbyDoctors extends DoctorDetailEvent {}

final class FetchDoctorDashboard extends DoctorDetailEvent {}

class PerformSearch extends DoctorDetailEvent {
  final DoctorFilterModel filter;

  PerformSearch({required this.filter});
}

class ClearSearch extends DoctorDetailEvent {}
