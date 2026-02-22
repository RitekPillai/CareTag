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

class GetProfileData extends PatientBlocEvent {}

class SubscriptionEvent extends PatientBlocEvent {
  final Shippingregistration shippingRegistration;

  const SubscriptionEvent({required this.shippingRegistration});
}

class BluetoothData extends PatientBlocEvent {
  final String heartrate;
  final String stepCount;

  const BluetoothData({required this.heartrate, required this.stepCount});
}
