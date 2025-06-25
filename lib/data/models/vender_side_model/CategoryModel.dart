/// categoryId : "66fe724b482d39cca58273df"
/// category_name : "Limousine hire"
/// category_image : "vip-limo-service-rolls-royce-phantom-300-exterior-01-1500.jpg"
/// category_status : "0"

class CategoryList {
  List<CategoryModel> subcategoryList;
  CategoryList({required this.subcategoryList});
  factory CategoryList.fromJson(List<dynamic> parsedJson) {
    List<CategoryModel> temp = <CategoryModel>[];

    temp = parsedJson.map((e) => CategoryModel.fromJson(e)).toList();
    return CategoryList(subcategoryList: temp);
  }
}

class CategoryModel {
  CategoryModel({
      String? categoryId, 
      String? categoryName, 
      String? categoryImage, 
      String? categoryStatus,}){
    _categoryId = categoryId;
    _categoryName = categoryName;
    _categoryImage = categoryImage;
    _categoryStatus = categoryStatus;
}

  CategoryModel.fromJson(dynamic json) {
    _categoryId = json['categoryId'];
    _categoryName = json['category_name'];
    _categoryImage = json['category_image'];
    _categoryStatus = json['category_status'];
  }
  String? _categoryId;
  String? _categoryName;
  String? _categoryImage;
  String? _categoryStatus;
CategoryModel copyWith({  String? categoryId,
  String? categoryName,
  String? categoryImage,
  String? categoryStatus,
}) => CategoryModel(  categoryId: categoryId ?? _categoryId,
  categoryName: categoryName ?? _categoryName,
  categoryImage: categoryImage ?? _categoryImage,
  categoryStatus: categoryStatus ?? _categoryStatus,
);
  String? get categoryId => _categoryId;
  String? get categoryName => _categoryName;
  String? get categoryImage => _categoryImage;
  String? get categoryStatus => _categoryStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryId'] = _categoryId;
    map['category_name'] = _categoryName;
    map['category_image'] = _categoryImage;
    map['category_status'] = _categoryStatus;
    return map;
  }

}