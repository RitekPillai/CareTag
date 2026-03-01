import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:caretag/Modules/card_registration/data/model/acceptReqModel.dart';
import 'package:caretag/Modules/card_registration/data/model/bloc_req_model.dart';
import 'package:caretag/Modules/card_registration/data/model/medicarecordmodel.dart';
import 'package:caretag/Modules/card_registration/data/model/profileModel.dart';
import 'package:caretag/Modules/card_registration/data/model/shippingRegistration.dart';
import 'package:caretag/Modules/card_registration/data/repos/paitent_repo.dart';
import 'package:caretag/Modules/card_registration/model_view/service/cryptographyservice.dart';
import 'package:caretag/Modules/home/model/permissionRequestModel.dart';
import 'package:caretag/Modules/profile/model/profile_edit_model.dart';
import 'package:caretag/Modules/records_module/model/prescription_model.dart';
import 'package:caretag/Modules/records_module/model/prescription_detail_model.dart';
import 'package:caretag/constants/messagingService.dart';

import 'package:cryptography/cryptography.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';

part 'patient_bloc_event.dart';
part 'patient_bloc_state.dart';

class PatientBloc extends Bloc<PatientBlocEvent, PatientBlocState> {
  final PaitientRepo _paitentRepo;

  PatientBloc(this._paitentRepo) : super(PatientBlocInitial()) {
    on<PatientRegistration>(_onPatientRegistration);
    on<GetPatientRecord>(_onGetPaitentRecord);
    on<SubscriptionEvent>(_onSubscription);
    on<BluetoothData>(_onBluetoohData);
    on<GetProfileData>(_onGetProfileData);
    on<RequestAccept>(_onRequestAccept);
    on<DenyPermission>(_onDenyPermission);
    on<ReportRequest>(_onReportRequest);
    on<GetAllPrescription>(_onGetAllPrescription);
    on<GetPrescriptionDetail>(_onGetPrescriptionDetail);
    on<ProfileEditEvent>(_onProfileEdit);
  }
  Future<void> _onPatientRegistration(
    PatientRegistration event,
    Emitter<PatientBlocState> emit,
  ) async {
    try {
      emit(Loading());
      NotificationService notificationService = NotificationService();
      String? token = await notificationService.getToken();
      if (token == null) {
        debugPrint("no token");
      }
      String careTagId = await _paitentRepo.medicalRegistration(
        event.medicalRecord,
        token!,
      );
      debugPrint(careTagId);
      emit(Success(careTagId: careTagId));
    } catch (e) {
      emit(Failed(message: e.toString()));
      debugPrint(e.toString());
    }
  }

  Future<void> _onGetPaitentRecord(GetPatientRecord event, Emitter emit) async {
    emit(Loading());
    try {
      await _paitentRepo.getRecord();

      //  emit(RecordFetched(record));
    } catch (e) {
      emit(Failed(message: e.toString()));
    }
  }

  Future<void> _onSubscription(SubscriptionEvent event, Emitter emit) async {
    emit(Loading());
    try {
      await _paitentRepo.subscription(event.shippingRegistration);
      emit(Subscribed());
    } catch (e) {
      emit(Failed(message: e.toString()));
    }
  }

  @override
  void onChange(Change<PatientBlocState> change) {
    debugPrint("State change hoagaa:$change");

    super.onChange(change);
  }

  FutureOr<void> _onBluetoohData(BluetoothData event, Emitter emit) {
    emit(Loading());
    try {} catch (e) {}
  }

  FutureOr<void> _onGetProfileData(
    GetProfileData event,
    Emitter<PatientBlocState> emit,
  ) async {
    emit(Loading());

    try {
      Profilemodel profilemodel = await _paitentRepo.getProfileData();
      emit(ProfileRecordFetched(profilemodel: profilemodel));
    } catch (e) {
      emit(Failed(message: e.toString()));
      debugPrint("Failed:$e");
    }
  }

  FutureOr<void> _onRequestAccept(
    RequestAccept event,
    Emitter<PatientBlocState> emit,
  ) async {
    emit(Loading());
    try {
      final recordBox = Hive.box('decrypted_records');
      final List<int>? aesKeyBytes = recordBox.get('aesKeyBytes');

      if (aesKeyBytes == null) {
        throw Exception("AES Key not found in local storage!");
      }

      debugPrint("rsa key :${event.permissionRequestModel.publicKey}");

      final SecretKey aesKey = SecretKey(aesKeyBytes);
      Cryptographyservice cryptographyservice = Cryptographyservice();

      final String encrytedAesBlob = await cryptographyservice.reEncrytion(
        aesKey,
        event.permissionRequestModel.publicKey,
      );
      _paitentRepo.requestAccept(
        Acceptreqmodel(
          docId: event.permissionRequestModel.docId,
          encryptedAesBlob: encrytedAesBlob,
        ),
      );
    } catch (e) {
      debugPrint(" erorr:$e");
    }
  }

  FutureOr<void> _onDenyPermission(
    DenyPermission event,
    Emitter<PatientBlocState> emit,
  ) {
    emit(Loading());

    try {
      _paitentRepo.denyRequest(event.docId);
    } catch (e) {
      log("Error while denying the permission:$e");
    }
  }

  FutureOr<void> _onReportRequest(
    ReportRequest event,
    Emitter<PatientBlocState> emit,
  ) {
    emit(Loading());
    try {
      _paitentRepo.blockRequest(event.blockReqModel);
    } catch (e) {
      log("Error while block the permission:$e");
    }
  }

  FutureOr<void> _onGetAllPrescription(
    GetAllPrescription event,
    Emitter<PatientBlocState> emit,
  ) async {
    emit(Loading());
    try {
      List<PrescriptionModel> allPrescriptions = await _paitentRepo
          .getAllPrescription();
      emit(AllPrescriptionFetched(prescriptionList: allPrescriptions));
    } catch (e) {
      log("Error in _onGetAllPrescription: $e");
    }
  }

  FutureOr<void> _onGetPrescriptionDetail(
    GetPrescriptionDetail event,
    Emitter<PatientBlocState> emit,
  ) async {
    emit(Loading());
    try {
      PrescriptionDetail prescriptionDetail = await _paitentRepo
          .getPrescriptionDetail(event.prescriptionId);
      emit(PrescriptionDetailFetched(prescriptionDetail: prescriptionDetail));
    } catch (e) {
      log("Error in _onGetPrescriptionDetail: $e");
    }
  }

  FutureOr<void> _onProfileEdit(
    ProfileEditEvent event,
    Emitter<PatientBlocState> emit,
  ) {
    emit(Loading());
    try {
      _paitentRepo.profileEdit(event.profileEditModel);
      emit(ProfileUpdateSuccess());
    } catch (e) {
      emit(Failed(message: e.toString()));
    }
  }
}
