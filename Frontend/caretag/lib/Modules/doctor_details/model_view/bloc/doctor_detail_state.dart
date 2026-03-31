part of 'doctor_detail_bloc.dart';

sealed class DoctorDetailState {}

final class InitinalState extends DoctorDetailState {}

final class DoctorDetailLoadingState extends DoctorDetailState {}

final class ErrorState extends DoctorDetailState {}

// NEW: Combined Success State
final class DoctorDashboardLoaded extends DoctorDetailState {
  final List<GetDoctorModel> myDoctors;
  final List<NearbyDoctorModel> nearbyDoctors;

  DoctorDashboardLoaded({required this.myDoctors, required this.nearbyDoctors});
}

final class MyDoctorDetailSuccess extends DoctorDetailState {
  final GetDoctorDetailModel doctorDetails;
  MyDoctorDetailSuccess({required this.doctorDetails});
}

final class SearchLoaded extends DoctorDetailState {
  final List<SearchDoctorModel> doctors;

  SearchLoaded({required this.doctors});
}
