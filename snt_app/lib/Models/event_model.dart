class EventModel {

  final String name;
  final String description;
  final String date;
  final String location;
  final String? imageUrl;
  final List<String> keyFeatures;

  EventModel({
    required this.name,
    required this.description,
    required this.date,
    required this.location,
    this.imageUrl,
    required this.keyFeatures,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      name: json['name'],
      description: json['description'],
      date: json['date'],
      location: json['location'],
      imageUrl: json['image_url']==""?null:json['image_url'],
      keyFeatures: List<String>.from(json['key_features'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'date': date,
      'location': location,
      'image_url': imageUrl==null?"":imageUrl,
      'key_features': keyFeatures,
    };
  }
}