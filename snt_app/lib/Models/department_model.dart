class DepartmentModel {
  final String name;
  final String? imageUrl;

  DepartmentModel({
    required this.name,
    this.imageUrl,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      name: json['name'] ?? '',
      imageUrl: json['image_url'] == "" ? null : json['image_url'], // cast uuid[] into List<String>
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image_url': imageUrl ?? "",
    };
  }
}
