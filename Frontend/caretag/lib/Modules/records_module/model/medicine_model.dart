class Medications {
  String? name;
  String? dosage;
  String? frequency;
  String? duration;
  int? morning;
  int? afternoon;
  int? night;
  String? mealTiming;

  Medications({
    this.name,
    this.dosage,
    this.frequency,
    this.duration,
    this.morning,
    this.afternoon,
    this.night,
    this.mealTiming,
  });

  Medications.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dosage = json['dosage'];
    frequency = json['frequency'];
    duration = json['duration'];
    morning = json['morning'];
    afternoon = json['afternoon'];
    night = json['night'];
    mealTiming = json['mealTiming'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = this.name;
    data['dosage'] = this.dosage;
    data['frequency'] = this.frequency;
    data['duration'] = this.duration;
    data['morning'] = this.morning;
    data['afternoon'] = this.afternoon;
    data['night'] = this.night;
    data['mealTiming'] = this.mealTiming;
    return data;
  }
}
