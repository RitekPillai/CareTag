import 'package:caretag/Modules/%20Diagonostic/model/diagonostic_detail_mode.dart';

class DiagonosticDetailModel {
  final String profileImageUrl;
  final String workingTime;
  final String workLocation;
  final double linkRate;
  final String aboutLab;
  final String workingDays;
  final String centerName;
  final List<DiagonosticTestModel> diagonosticTests;

  DiagonosticDetailModel({
    required this.profileImageUrl,
    required this.workingTime,
    required this.workLocation,
    required this.linkRate,
    required this.aboutLab,
    required this.workingDays,
    required this.diagonosticTests,
    required this.centerName,
  });

  factory DiagonosticDetailModel.fromJson(Map<String, dynamic> json) {
    return DiagonosticDetailModel(
      profileImageUrl: json['profileImageUrl'] ?? '',
      workingTime: json['workingTime'] ?? '',
      workLocation: json['workLocation'] ?? '',
      linkRate: (json['linkRate'] ?? 0).toDouble(),
      aboutLab: json['aboutLab'] ?? '',
      workingDays: json['workingDays'] ?? '',
      centerName: json['centerName'] ?? '',

      diagonosticTests:
          (json['diagonosticTest'] as List<dynamic>?)
              ?.map(
                (testJson) => DiagonosticTestModel.fromJson(
                  testJson as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
    );
  }
}
