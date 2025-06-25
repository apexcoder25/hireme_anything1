class SubcategoryModels {
  final String id;
  final String categoryId;
  final String categoryName;
  final String subcategoryName;
  final String subcategoryStatus;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  SubcategoryModels({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.subcategoryName,
    required this.subcategoryStatus,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubcategoryModels.fromJson(Map<String, dynamic> json) {
    return SubcategoryModels(
      id: json['_id'] as String? ?? '',
      categoryId: (json['categoryId'] as Map<String, dynamic>?)?['_id'] as String? ?? '',
      categoryName: (json['categoryId'] as Map<String, dynamic>?)?['category_name'] as String? ?? '',
      subcategoryName: json['subcategory_name'] as String? ?? '',
      subcategoryStatus: json['subcategory_status'] as String? ?? '0',
      description: json['description'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String? ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] as String? ?? DateTime.now().toIso8601String()),
    );
  }
}