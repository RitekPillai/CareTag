part of 'doctor_detail_bloc.dart';

sealed class DoctorDetailState {}

final class InitinalState extends DoctorDetailState {}

final class MyDoctorSuccess extends DoctorDetailState {
  final List<GetDoctorModel> myDoctors;

  MyDoctorSuccess({required this.myDoctors});
}

final class ErrorState extends DoctorDetailState {}

final class DoctorDetailLoadingState extends DoctorDetailState {}
