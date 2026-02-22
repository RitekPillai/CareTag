import 'package:hive/hive.dart';
part 'profileModel.g.dart';

@HiveType(typeId: 1) // Must have @
class Profilemodel extends HiveObject {
  @HiveField(0) // Must have @
  final String fullName;

  @HiveField(1)
  final String bloodGroup;

  @HiveField(2)
  final String dob;

  @HiveField(3)
  final String address;

  @HiveField(4)
  final String careTagId;

  Profilemodel({
    required this.fullName,
    required this.bloodGroup,
    required this.dob,
    required this.address,
    required this.careTagId,
  });

  factory Profilemodel.formJson(Map<String, dynamic> json) {
    return Profilemodel(
      fullName: json['fullName'],
      bloodGroup: json['bloodGroup'],
      dob: json['dob'],
      address: json['address'],
      careTagId: json['careTagId'],
    );
  }
}
