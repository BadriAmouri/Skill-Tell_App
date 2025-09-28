// Updated DepartmentModel
class DepartmentModel {
  final String name;
  final String? description;
  final String? imageUrl;

  DepartmentModel({
    required this.name,
    this.description,
    this.imageUrl,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      name: json['name'],
      description: json['description'],
      imageUrl: json['image_url'] == "" ? null : json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'image_url': imageUrl ?? "",
    };
  }
}