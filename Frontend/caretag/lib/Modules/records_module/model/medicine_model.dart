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
    data['name'] = name;
    data['dosage'] = dosage;
    data['frequency'] = frequency;
    data['duration'] = duration;
    data['morning'] = morning;
    data['afternoon'] = afternoon;
    data['night'] = night;
    data['mealTiming'] = mealTiming;
    return data;
  }
}
