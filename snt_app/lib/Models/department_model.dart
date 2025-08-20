class DepartmentModel {
  final String id; // department_id
  final String name;
  final String? imageUrl;
  final List<String> members; // uuid[] from supabase

  DepartmentModel({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.members,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: json['department_id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['image_url'] == "" ? null : json['image_url'],
      members: json['members'] == null
          ? []
          : List<String>.from(json['members']), // cast uuid[] into List<String>
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'department_id': id,
      'name': name,
      'image_url': imageUrl ?? "",
      'members': members,
    };
  }
}
