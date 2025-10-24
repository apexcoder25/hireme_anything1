// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

List<Category> categoryFromJson(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
    String id;
    String categoryName;
    String categoryImage;
    String description;
    String categoryStatus;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Category({
        required this.id,
        required this.categoryName,
        required this.categoryImage,
        required this.description,
        required this.categoryStatus,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"] ?? "",
        categoryName: json["category_name"] ?? "",
        categoryImage: json["category_image"] ?? "",
        description: json["description"] ?? "",
        categoryStatus: json["category_status"] ?? "",
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(),
        updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
        v: json["__v"] ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "category_name": categoryName,
        "category_image": categoryImage,
        "description": description,
        "category_status": categoryStatus,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
