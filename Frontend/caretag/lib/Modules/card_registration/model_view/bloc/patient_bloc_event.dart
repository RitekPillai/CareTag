part of 'patient_bloc_bloc.dart';

sealed class PatientBlocEvent extends Equatable {
  const PatientBlocEvent();

  @override
  List<Object> get props => [];
}

class PatientRegistration extends PatientBlocEvent {
  final Medicarecordmodel medicalRecord;

  const PatientRegistration({required this.medicalRecord});
}

class GetPatientRecord extends PatientBlocEvent {
  const GetPatientRecord();
}

class SubscriptionEvent extends PatientBlocEvent {
  final Shippingregistration shippingRegistration;

  const SubscriptionEvent({required this.shippingRegistration});
}
