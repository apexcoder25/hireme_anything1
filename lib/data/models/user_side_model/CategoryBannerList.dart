/// categoryBannerId : "66fe9a73f45c91fab9ad980c"
/// category_banner_image : "download (4).jpeg"
/// category_banner_status : "0"

class CategoryBannerList {
  CategoryBannerList({
      String? categoryBannerId, 
      String? categoryBannerImage, 
      String? categoryBannerStatus,}){
    _categoryBannerId = categoryBannerId;
    _categoryBannerImage = categoryBannerImage;
    _categoryBannerStatus = categoryBannerStatus;
}

  CategoryBannerList.fromJson(dynamic json) {
    _categoryBannerId = json['categoryBannerId'];
    _categoryBannerImage = json['category_banner_image'];
    _categoryBannerStatus = json['category_banner_status'];
  }
  String? _categoryBannerId;
  String? _categoryBannerImage;
  String? _categoryBannerStatus;
CategoryBannerList copyWith({  String? categoryBannerId,
  String? categoryBannerImage,
  String? categoryBannerStatus,
}) => CategoryBannerList(  categoryBannerId: categoryBannerId ?? _categoryBannerId,
  categoryBannerImage: categoryBannerImage ?? _categoryBannerImage,
  categoryBannerStatus: categoryBannerStatus ?? _categoryBannerStatus,
);
  String? get categoryBannerId => _categoryBannerId;
  String? get categoryBannerImage => _categoryBannerImage;
  String? get categoryBannerStatus => _categoryBannerStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryBannerId'] = _categoryBannerId;
    map['category_banner_image'] = _categoryBannerImage;
    map['category_banner_status'] = _categoryBannerStatus;
    return map;
  }

}