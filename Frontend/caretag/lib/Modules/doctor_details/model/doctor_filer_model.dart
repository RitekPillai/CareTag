class DoctorFilterModel {
  final String? specialization;
  final String? city;
  final int? minExperience;
  final int? maxConsultationFee;
  final String? searchKeyword;

  DoctorFilterModel({
    this.specialization,
    this.city,
    this.minExperience,
    this.maxConsultationFee,
    this.searchKeyword,
  });

  Map<String, dynamic> toJson() {
    return {
      if (specialization != null) 'specialization': specialization,
      if (city != null) 'city': city,
      if (minExperience != null) 'minExperience': minExperience,
      if (maxConsultationFee != null) 'maxConsultationFee': maxConsultationFee,
      if (searchKeyword != null) 'searchKeyword': searchKeyword,
    };
  }
}
