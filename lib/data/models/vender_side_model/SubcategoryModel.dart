/// subcategoryId : "66fe76e6482d39cca582740f"
/// categoryId : "66fe724b482d39cca58273df"
/// subcategory_name : "A1"
/// subcategory_image : "download (3).jpeg"
/// subcategory_status : "0"

class SubCategoryList {
  List<SubcategoryModel> subcategoryList;
  SubCategoryList({required this.subcategoryList});
  factory SubCategoryList.fromJson(List<dynamic> parsedJson) {
    List<SubcategoryModel> temp = <SubcategoryModel>[];

    temp = parsedJson.map((e) => SubcategoryModel.fromJson(e)).toList();
    return SubCategoryList(subcategoryList: temp);
  }
}


class SubcategoryModel {
  SubcategoryModel({
      String? subcategoryId, 
      String? categoryId, 
      String? subcategoryName, 
      String? subcategoryImage, 
      String? subcategoryStatus,}){
    _subcategoryId = subcategoryId;
    _categoryId = categoryId;
    _subcategoryName = subcategoryName;
    _subcategoryImage = subcategoryImage;
    _subcategoryStatus = subcategoryStatus;
}

  SubcategoryModel.fromJson(dynamic json) {
    _subcategoryId = json['subcategoryId'];
    _categoryId = json['categoryId'];
    _subcategoryName = json['subcategory_name'];
    _subcategoryImage = json['subcategory_image'];
    _subcategoryStatus = json['subcategory_status'];
  }
  String? _subcategoryId;
  String? _categoryId;
  String? _subcategoryName;
  String? _subcategoryImage;
  String? _subcategoryStatus;
SubcategoryModel copyWith({  String? subcategoryId,
  String? categoryId,
  String? subcategoryName,
  String? subcategoryImage,
  String? subcategoryStatus,
}) => SubcategoryModel(  subcategoryId: subcategoryId ?? _subcategoryId,
  categoryId: categoryId ?? _categoryId,
  subcategoryName: subcategoryName ?? _subcategoryName,
  subcategoryImage: subcategoryImage ?? _subcategoryImage,
  subcategoryStatus: subcategoryStatus ?? _subcategoryStatus,
);
  String? get subcategoryId => _subcategoryId;
  String? get categoryId => _categoryId;
  String? get subcategoryName => _subcategoryName;
  String? get subcategoryImage => _subcategoryImage;
  String? get subcategoryStatus => _subcategoryStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subcategoryId'] = _subcategoryId;
    map['categoryId'] = _categoryId;
    map['subcategory_name'] = _subcategoryName;
    map['subcategory_image'] = _subcategoryImage;
    map['subcategory_status'] = _subcategoryStatus;
    return map;
  }

}