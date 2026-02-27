part of 'patient_bloc_bloc.dart';

sealed class PatientBlocState extends Equatable {
  const PatientBlocState();

  @override
  List<Object> get props => [];
}

final class PatientBlocInitial extends PatientBlocState {}

final class Loading extends PatientBlocState {}

final class Failed extends PatientBlocState {
  final String message;

  const Failed({required this.message});
}

final class PrescriptionDetailFetched extends PatientBlocState {
  final PrescriptionDetail prescriptionDetail;
  const PrescriptionDetailFetched({required this.prescriptionDetail});
}

final class AllPrescriptionFetched extends PatientBlocState {
  final List<PrescriptionModel> prescriptionList;
  const AllPrescriptionFetched({required this.prescriptionList});
}

final class ProfileRecordFetched extends PatientBlocState {
  final Profilemodel profilemodel;
  const ProfileRecordFetched({required this.profilemodel});
}

final class RecordFetched extends PatientBlocState {
  final Medicarecordmodel medicalRecord;
  const RecordFetched(this.medicalRecord);
}

final class Subscribed extends PatientBlocState {}

final class Success extends PatientBlocState {
  final String careTagId;

  const Success({required this.careTagId});
}
