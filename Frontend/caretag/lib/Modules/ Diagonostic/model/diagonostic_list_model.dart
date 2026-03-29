class DiagonosticListModel {
  final int id;
  final String diagonosticName;
  final String timing;
  final String imageUrl;
  final String worktTime;
  final String? workDays;
  final String locationAway;

  DiagonosticListModel({
    required this.id,
    required this.diagonosticName,
    required this.timing,
    required this.imageUrl,
    required this.worktTime,
    required this.workDays,
    required this.locationAway,
  });

  factory DiagonosticListModel.fromJson(Map<String, dynamic> json) {
    return DiagonosticListModel(
      id: json['id'],
      diagonosticName: json['diagonosticName'],
      timing: json['timing'],
      imageUrl: json['imageUrl'],
      worktTime: json['worktTime'],
      workDays: json['workDays'] ?? 'ALlDAY',
      locationAway: json['locationAway'],
    );
  }
}
