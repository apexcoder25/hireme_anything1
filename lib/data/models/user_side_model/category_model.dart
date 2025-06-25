class CategoryModelss {
  final String id;
  final String categoryName;
  final String categoryImage;
  final String description;
  final String categoryStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  CategoryModelss({
    required this.id,
    required this.categoryName,
    required this.categoryImage,
    required this.description,
    required this.categoryStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create an instance from JSON
  factory CategoryModelss.fromJson(Map<String, dynamic> json) {
    return CategoryModelss(
      id: json["_id"] ?? "",
      categoryName: json["category_name"] ?? "",
      categoryImage: json["category_image"] ?? "",
      description: json["description"] ?? "",
      categoryStatus: json["category_status"] ?? "0",
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
    );
  }

  // Convert instance to JSON (if needed)
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "category_name": categoryName,
      "category_image": categoryImage,
      "description": description,
      "category_status": categoryStatus,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
    };
  }
}
