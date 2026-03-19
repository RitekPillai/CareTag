part of 'doctor_detail_bloc.dart';

sealed class DoctorDetailEvent {}

final class GetMyDoctor extends DoctorDetailEvent {}

final class GetMyDoctorDetails extends DoctorDetailEvent {
  final double id;
  GetMyDoctorDetails({required this.id});
}
