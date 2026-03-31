import 'package:caretag/Modules/doctor_details/model/get_doctor_model.dart';
import 'package:caretag/Modules/doctor_details/model/near_by_doctor_model.dart';

class DoctorDashboardModel {
  final List<GetDoctorModel> myDoctors;
  final List<NearbyDoctorModel> nearbyTopRatedDoctors;

  DoctorDashboardModel({
    required this.myDoctors,
    required this.nearbyTopRatedDoctors,
  });

  factory DoctorDashboardModel.fromJson(Map<String, dynamic> json) {
    return DoctorDashboardModel(
      myDoctors:
          (json['myDoctors'] as List<dynamic>?)
              ?.map((e) => GetDoctorModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      nearbyTopRatedDoctors:
          (json['nearbyTopRatedDoctors'] as List<dynamic>?)
              ?.map(
                (e) => NearbyDoctorModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }
}
