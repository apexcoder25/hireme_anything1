/// offerId : "66fe7ec8dfcf156667a390c8"
/// title : "Hire Anything, Anytime"
/// description : "Hire professionals or tools easily, with flexible "
/// offer_status : "0"

class OffersList {
  List<OffersModel> bannerList;
  OffersList({required this.bannerList});
  factory OffersList.fromJson(List<dynamic> parsedJson) {
    List<OffersModel> temp = <OffersModel>[];

    temp = parsedJson.map((e) => OffersModel.fromJson(e)).toList();
    return OffersList(bannerList: temp);
  }
}

class OffersModel {
  OffersModel({
      String? offerId, 
      String? title, 
      String? description, 
      String? offerStatus,}){
    _offerId = offerId;
    _title = title;
    _description = description;
    _offerStatus = offerStatus;
}

  OffersModel.fromJson(dynamic json) {
    _offerId = json['offerId'];
    _title = json['title'];
    _description = json['description'];
    _offerStatus = json['offer_status'];
  }
  String? _offerId;
  String? _title;
  String? _description;
  String? _offerStatus;
OffersModel copyWith({  String? offerId,
  String? title,
  String? description,
  String? offerStatus,
}) => OffersModel(  offerId: offerId ?? _offerId,
  title: title ?? _title,
  description: description ?? _description,
  offerStatus: offerStatus ?? _offerStatus,
);
  String? get offerId => _offerId;
  String? get title => _title;
  String? get description => _description;
  String? get offerStatus => _offerStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['offerId'] = _offerId;
    map['title'] = _title;
    map['description'] = _description;
    map['offer_status'] = _offerStatus;
    return map;
  }

}