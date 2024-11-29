class PreEventsModel {
  final String eventName;
  final String eventType;
  final String eventStartDate;
  final String eventPoster;
  final String collegeName;
  final String collegeAddress;
  final String price;

  PreEventsModel({
    required this.eventName,
    required this.eventType,
    required this.eventStartDate,
    required this.eventPoster,
    required this.collegeName,
    required this.collegeAddress,
    required this.price,
  });

  factory PreEventsModel.fromJson(Map<String, dynamic> json) {
    return PreEventsModel(
      eventName: json['eventTitle'] as String? ?? 'Unknown Event',
      eventType: 'General',
      eventStartDate: json['eventStartDate'] as String? ?? '1970-01-01',
      eventPoster: json['eventImage'] as String? ?? '',
      collegeName: 'Unknown College',
      collegeAddress: json['eventLocation'] as String? ?? 'Unknown Location',
      price: 'Free',
    );
  }
}
