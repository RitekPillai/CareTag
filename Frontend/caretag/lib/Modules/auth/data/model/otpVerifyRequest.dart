class OtpVerifyModel {
  String email;
  String otpCode;

  OtpVerifyModel({required this.email, required this.otpCode});

  factory OtpVerifyModel.formJson(Map<String, dynamic> json) {
    return OtpVerifyModel(email: json['email'], otpCode: json['otpCode']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['otpCode'] = otpCode;
    return data;
  }
}
