class Model1 {
    String? id;
    CategoryId? categoryId;
    String? subcategoryName;
    String? subcategoryStatus;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? description;

    Model1({
        this.id,
        this.categoryId,
        this.subcategoryName,
        this.subcategoryStatus,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.description,
    });

    factory Model1.fromJson(Map<String, dynamic> json) => Model1(
        id: json["_id"] ?? "",
        categoryId: json["categoryId"] != null ? CategoryId.fromJson(json["categoryId"]) : null,
        subcategoryName: json["subcategory_name"] ?? "",
        subcategoryStatus: json["subcategory_status"] ?? "",
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
        updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
        v: json["__v"] ?? 0,
        description: json["description"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "_id": id ?? "",
        "categoryId": categoryId?.toJson(),
        "subcategory_name": subcategoryName ?? "",
        "subcategory_status": subcategoryStatus ?? "",
        "createdAt": createdAt?.toIso8601String() ?? "",
        "updatedAt": updatedAt?.toIso8601String() ?? "",
        "__v": v ?? 0,
        "description": description ?? "",
    };
}

class CategoryId {
    String? id;
    String? categoryName;

    CategoryId({
        this.id,
        this.categoryName,
    });

    factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
        id: json["_id"] ?? "",
        categoryName: json["category_name"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "_id": id ?? "",
        "category_name": categoryName ?? "",
    };
}
