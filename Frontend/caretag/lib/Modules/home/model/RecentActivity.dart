enum ActivityType { appointment, labReport, prescription, unknown }

class RecentActivity {
  final String? id;
  final ActivityType activityType;
  final String title;
  final String description;
  final DateTime activityDate;
  final Map<String, String> metadata;

  RecentActivity({
    this.id,
    required this.activityType,
    required this.title,
    required this.description,
    required this.activityDate,
    required this.metadata,
  });

  factory RecentActivity.fromJson(Map<String, dynamic> json) {
    return RecentActivity(
      id: json['id'],
      activityType: _parseActivityType(json['activityType']),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      activityDate: DateTime.parse(json['activityDate']),
      metadata: Map<String, String>.from(json['metadata'] ?? {}),
    );
  }

  static ActivityType _parseActivityType(String? type) {
    switch (type) {
      case 'APPOINTMENT':
        return ActivityType.appointment;
      case 'LAB_REPORT':
        return ActivityType.labReport;
      case 'PRESCRIPTION':
        return ActivityType.prescription;
      default:
        return ActivityType.unknown;
    }
  }
}
