/// bannerId : "66fd5abd2cef44cf3ccca5dc"
/// banner_type : "header"
/// banner_image : "Horse and Carriage.jpeg"

class HomeBannerFirstList {
  List<HomeBannerFirst> bannerList;
  HomeBannerFirstList({required this.bannerList});
  factory HomeBannerFirstList.fromJson(List<dynamic> parsedJson) {
    List<HomeBannerFirst> temp = <HomeBannerFirst>[];

    temp = parsedJson.map((e) => HomeBannerFirst.fromJson(e)).toList();
    return HomeBannerFirstList(bannerList: temp);
  }
}

class HomeFooterBannerFirstList {
  List<HomeBannerFirst> bannerList;
  HomeFooterBannerFirstList({required this.bannerList});
  factory HomeFooterBannerFirstList.fromJson(List<dynamic> parsedJson) {
    List<HomeBannerFirst> temp = <HomeBannerFirst>[];

    temp = parsedJson.map((e) => HomeBannerFirst.fromJson(e)).toList();
    return HomeFooterBannerFirstList(bannerList: temp);
  }
}



class HomeBannerFirst {
  HomeBannerFirst({
      String? bannerId, 
      String? bannerType, 
      String? bannerImage,}){
    _bannerId = bannerId;
    _bannerType = bannerType;
    _bannerImage = bannerImage;
}

  HomeBannerFirst.fromJson(dynamic json) {
    _bannerId = json['bannerId'];
    _bannerType = json['banner_type'];
    _bannerImage = json['banner_image'];
  }
  String? _bannerId;
  String? _bannerType;
  String? _bannerImage;
HomeBannerFirst copyWith({  String? bannerId,
  String? bannerType,
  String? bannerImage,
}) => HomeBannerFirst(  bannerId: bannerId ?? _bannerId,
  bannerType: bannerType ?? _bannerType,
  bannerImage: bannerImage ?? _bannerImage,
);
  String? get bannerId => _bannerId;
  String? get bannerType => _bannerType;
  String? get bannerImage => _bannerImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bannerId'] = _bannerId;
    map['banner_type'] = _bannerType;
    map['banner_image'] = _bannerImage;
    return map;
  }

}