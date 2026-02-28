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

class RequestAccept extends PatientBlocEvent {
  final Permissionrequestmodel permissionRequestModel;

  const RequestAccept({required this.permissionRequestModel});
}

class GetPatientRecord extends PatientBlocEvent {
  const GetPatientRecord();
}

class GetPrescriptionDetail extends PatientBlocEvent {
  final String prescriptionId;

  const GetPrescriptionDetail({required this.prescriptionId});
}

class GetAllPrescription extends PatientBlocEvent {}

class ReportRequest extends PatientBlocEvent {
  final BlockReqModel blockReqModel;

  const ReportRequest({required this.blockReqModel});
}

class ProfileEditEvent extends PatientBlocEvent {
  final ProfileEditModel profileEditModel;

  const ProfileEditEvent({required this.profileEditModel});
}

class DenyPermission extends PatientBlocEvent {
  final String docId;

  const DenyPermission({required this.docId});
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
