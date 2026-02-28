class ProfileEditModel {
  String? fullName;
  String? dob;
  String? gender;
  String? bloodGroup;
  String? height;
  String? weight;
  String? allergies;
  String? imagePath;

  ProfileEditModel({
    this.fullName,
    this.dob,
    this.gender,
    this.bloodGroup,
    this.height,
    this.weight,
    this.allergies,
    this.imagePath,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullName,
      'dabo': dob,
      'gender': gender,
      'bloodGroup': bloodGroup,
      'height': height,
      'weight': weight,
      'allergies': allergies,
      'imagePath': imagePath,
    };
  }
}
