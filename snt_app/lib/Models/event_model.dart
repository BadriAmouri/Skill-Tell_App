enum EventTiming { upcoming, previous }

class EventModel {
  final String name;
  final String description;
  final DateTime date;
  final String location;
  final String? imageUrl;
  final List<String> keyFeatures;
  final EventTiming eventTiming;

  const EventModel({
    required this.name,
    required this.description,
    required this.date,
    required this.location,
    this.imageUrl,
    required this.keyFeatures,
    required this.eventTiming,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      name: json['event_name'] ?? '',
      description: json['description'] ?? '',
      date: DateTime.parse(json['date'].toString()).toUtc(),
      location: json['location'] ?? '',
      imageUrl: json['image_url'] as String?, // null-safe
      keyFeatures: json['key_features'] == null
          ? []
          : List<String>.from(json['key_features']),
      eventTiming: (json['status']?.toString().toLowerCase() == 'upcoming')
          ? EventTiming.upcoming
          : EventTiming.previous,
    );
  }
}
