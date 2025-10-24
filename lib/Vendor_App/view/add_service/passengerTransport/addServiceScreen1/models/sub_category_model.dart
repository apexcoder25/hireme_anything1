// To parse this JSON data, do
//
//     final subCategory = subCategoryFromJson(jsonString);

import 'dart:convert';

List<SubCategory> subCategoryFromJson(String str) => List<SubCategory>.from(json.decode(str).map((x) => SubCategory.fromJson(x)));

String subCategoryToJson(List<SubCategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubCategory {
    String id;
    CategoryId? categoryId;
    String subcategoryName;
    String subcategoryStatus;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    String? description;

    SubCategory({
        required this.id,
        required this.categoryId,
        required this.subcategoryName,
        required this.subcategoryStatus,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        this.description,
    });

    factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["_id"],
        categoryId: json["categoryId"] == null ? null : CategoryId.fromJson(json["categoryId"]),
        subcategoryName: json["subcategory_name"],
        subcategoryStatus: json["subcategory_status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "categoryId": categoryId?.toJson(),
        "subcategory_name": subcategoryName,
        "subcategory_status": subcategoryStatus,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "description": description,
    };
}

class CategoryId {
    String id;
    String categoryName;
    String categoryImage;

    CategoryId({
        required this.id,
        required this.categoryName,
        required this.categoryImage,
    });

    factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
        id: json["_id"],
        categoryName: json["category_name"],
        categoryImage: json["category_image"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "category_name": categoryName,
        "category_image": categoryImage,
    };
}
