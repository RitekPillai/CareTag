part of 'doctor_detail_bloc.dart';

sealed class DoctorDetailState {}

final class InitinalState extends DoctorDetailState {}

final class MyDoctorSuccess extends DoctorDetailState {
  final List<GetDoctorModel> myDoctors;

  MyDoctorSuccess({required this.myDoctors});
}

final class ErrorState extends DoctorDetailState {}

final class DoctorDetailLoadingState extends DoctorDetailState {}

final class MyDoctorDetailSuccess extends DoctorDetailState {
  final GetDoctorDetailModel doctorDetails;
  MyDoctorDetailSuccess({required this.doctorDetails});
}
