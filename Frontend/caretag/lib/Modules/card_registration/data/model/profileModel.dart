import 'package:hive/hive.dart';

class Profilemodel extends HiveObject {
  final String fullName;

  final String bloodGroup;
  final String careTagId;
  final String imageUrl;

  Profilemodel({
    required this.fullName,
    required this.bloodGroup,

    required this.careTagId,
    required this.imageUrl,
  });

  factory Profilemodel.formJson(Map<String, dynamic> json) {
    return Profilemodel(
      fullName: json['fullName'],
      bloodGroup: json['bloodGroup'],

      careTagId: json['careTagId'],
      imageUrl:
          json['imageUrl'] ??
          'https://i.pinimg.com/736x/2c/19/70/2c19700f986189e2f61d60f003edce74.jpg',
    );
  }
}
