/// serviceId : "67014712ac674e1598cfd926"
/// categoryId : "66fe724b482d39cca58273df"
/// category_name : "Limousine hire"
/// subcategoryId : "66fe76e6482d39cca582740f"
/// subcategory_name : "A1"
/// vendorId : "670146a9ac674e1598cfd918"
/// service_name : "tctc"
/// service_price : 28285
/// discount_price : 78.58
/// final_price : 6060
/// description : "g gv"
/// city_name : "Indore"
/// no_of_seats : 0
/// registration_no : ""
/// wheel_chair : ""
/// make_and_model : ""
/// toilet_facility : ""
/// airon_fitted : ""
/// coffee_machine : ""
/// minimum_distance : ""
/// maximum_distance : ""
/// booking_time : ""
/// service_image : ["1000056361_out.jpg","1000056297_out.jpg","1000056372_out.jpg","1000056110_out.jpg"]
/// service_approve_status : "1"

class VendorServiceList {
  List<VendorServiceListModel> vendorServiceList;
  VendorServiceList({required this.vendorServiceList});
  factory VendorServiceList.fromJson(List<dynamic> parsedJson) {
    List<VendorServiceListModel> temp = <VendorServiceListModel>[];

    temp = parsedJson.map((e) => VendorServiceListModel.fromJson(e)).toList();
    return VendorServiceList(vendorServiceList: temp);
  }
}


class VendorServiceListModel {
  VendorServiceListModel({
    String? serviceId,
    String? categoryId,
    String? categoryName,
    String? subcategoryId,
    String? subcategoryName,
    String? vendorId,
    String? serviceName,
    num? servicePrice,
    num? discountPrice,
    num? finalPrice,
    String? description,
    String? cityName,
    num? noOfSeats,
    String? registrationNo,
    String? wheelChair,
    String? makeAndModel,
    String? toiletFacility,
    String? aironFitted,
    String? coffeeMachine,
    String? minimumDistance,
    String? maximumDistance,
    String? bookingTime,
    List<String>? serviceImage,
    String? serviceApproveStatus,}){
    _serviceId = serviceId;
    _categoryId = categoryId;
    _categoryName = categoryName;
    _subcategoryId = subcategoryId;
    _subcategoryName = subcategoryName;
    _vendorId = vendorId;
    _serviceName = serviceName;
    _servicePrice = servicePrice;
    _discountPrice = discountPrice;
    _finalPrice = finalPrice;
    _description = description;
    _cityName = cityName;
    _noOfSeats = noOfSeats;
    _registrationNo = registrationNo;
    _wheelChair = wheelChair;
    _makeAndModel = makeAndModel;
    _toiletFacility = toiletFacility;
    _aironFitted = aironFitted;
    _coffeeMachine = coffeeMachine;
    _minimumDistance = minimumDistance;
    _maximumDistance = maximumDistance;
    _bookingTime = bookingTime;
    _serviceImage = serviceImage;
    _serviceApproveStatus = serviceApproveStatus;
  }

  VendorServiceListModel.fromJson(dynamic json) {
    _serviceId = json['serviceId'];
    _categoryId = json['categoryId'];
    _categoryName = json['category_name'];
    _subcategoryId = json['subcategoryId'];
    _subcategoryName = json['subcategory_name'];
    _vendorId = json['vendorId'];
    _serviceName = json['service_name'];
    _servicePrice = json['service_price'];
    _discountPrice = json['discount_price'];
    _finalPrice = json['final_price'];
    _description = json['description'];
    _cityName = json['city_name'];
    _noOfSeats = json['no_of_seats'];
    _registrationNo = json['registration_no'];
    _wheelChair = json['wheel_chair'];
    _makeAndModel = json['make_and_model'];
    _toiletFacility = json['toilet_facility'];
    _aironFitted = json['airon_fitted'];
    _coffeeMachine = json['coffee_machine'];
    _minimumDistance = json['minimum_distance'];
    _maximumDistance = json['maximum_distance'];
    _bookingTime = json['booking_time'];
    _serviceImage = json['service_image'] != null ? json['service_image'].cast<String>() : [];
    _serviceApproveStatus = json['service_approve_status'];
  }
  String? _serviceId;
  String? _categoryId;
  String? _categoryName;
  String? _subcategoryId;
  String? _subcategoryName;
  String? _vendorId;
  String? _serviceName;
  num? _servicePrice;
  num? _discountPrice;
  num? _finalPrice;
  String? _description;
  String? _cityName;
  num? _noOfSeats;
  String? _registrationNo;
  String? _wheelChair;
  String? _makeAndModel;
  String? _toiletFacility;
  String? _aironFitted;
  String? _coffeeMachine;
  String? _minimumDistance;
  String? _maximumDistance;
  String? _bookingTime;
  List<String>? _serviceImage;
  String? _serviceApproveStatus;
  VendorServiceListModel copyWith({  String? serviceId,
    String? categoryId,
    String? categoryName,
    String? subcategoryId,
    String? subcategoryName,
    String? vendorId,
    String? serviceName,
    num? servicePrice,
    num? discountPrice,
    num? finalPrice,
    String? description,
    String? cityName,
    num? noOfSeats,
    String? registrationNo,
    String? wheelChair,
    String? makeAndModel,
    String? toiletFacility,
    String? aironFitted,
    String? coffeeMachine,
    String? minimumDistance,
    String? maximumDistance,
    String? bookingTime,
    List<String>? serviceImage,
    String? serviceApproveStatus,
  }) => VendorServiceListModel(  serviceId: serviceId ?? _serviceId,
    categoryId: categoryId ?? _categoryId,
    categoryName: categoryName ?? _categoryName,
    subcategoryId: subcategoryId ?? _subcategoryId,
    subcategoryName: subcategoryName ?? _subcategoryName,
    vendorId: vendorId ?? _vendorId,
    serviceName: serviceName ?? _serviceName,
    servicePrice: servicePrice ?? _servicePrice,
    discountPrice: discountPrice ?? _discountPrice,
    finalPrice: finalPrice ?? _finalPrice,
    description: description ?? _description,
    cityName: cityName ?? _cityName,
    noOfSeats: noOfSeats ?? _noOfSeats,
    registrationNo: registrationNo ?? _registrationNo,
    wheelChair: wheelChair ?? _wheelChair,
    makeAndModel: makeAndModel ?? _makeAndModel,
    toiletFacility: toiletFacility ?? _toiletFacility,
    aironFitted: aironFitted ?? _aironFitted,
    coffeeMachine: coffeeMachine ?? _coffeeMachine,
    minimumDistance: minimumDistance ?? _minimumDistance,
    maximumDistance: maximumDistance ?? _maximumDistance,
    bookingTime: bookingTime ?? _bookingTime,
    serviceImage: serviceImage ?? _serviceImage,
    serviceApproveStatus: serviceApproveStatus ?? _serviceApproveStatus,
  );
  String? get serviceId => _serviceId;
  String? get categoryId => _categoryId;
  String? get categoryName => _categoryName;
  String? get subcategoryId => _subcategoryId;
  String? get subcategoryName => _subcategoryName;
  String? get vendorId => _vendorId;
  String? get serviceName => _serviceName;
  num? get servicePrice => _servicePrice;
  num? get discountPrice => _discountPrice;
  num? get finalPrice => _finalPrice;
  String? get description => _description;
  String? get cityName => _cityName;
  num? get noOfSeats => _noOfSeats;
  String? get registrationNo => _registrationNo;
  String? get wheelChair => _wheelChair;
  String? get makeAndModel => _makeAndModel;
  String? get toiletFacility => _toiletFacility;
  String? get aironFitted => _aironFitted;
  String? get coffeeMachine => _coffeeMachine;
  String? get minimumDistance => _minimumDistance;
  String? get maximumDistance => _maximumDistance;
  String? get bookingTime => _bookingTime;
  List<String>? get serviceImage => _serviceImage;
  String? get serviceApproveStatus => _serviceApproveStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['serviceId'] = _serviceId;
    map['categoryId'] = _categoryId;
    map['category_name'] = _categoryName;
    map['subcategoryId'] = _subcategoryId;
    map['subcategory_name'] = _subcategoryName;
    map['vendorId'] = _vendorId;
    map['service_name'] = _serviceName;
    map['service_price'] = _servicePrice;
    map['discount_price'] = _discountPrice;
    map['final_price'] = _finalPrice;
    map['description'] = _description;
    map['city_name'] = _cityName;
    map['no_of_seats'] = _noOfSeats;
    map['registration_no'] = _registrationNo;
    map['wheel_chair'] = _wheelChair;
    map['make_and_model'] = _makeAndModel;
    map['toilet_facility'] = _toiletFacility;
    map['airon_fitted'] = _aironFitted;
    map['coffee_machine'] = _coffeeMachine;
    map['minimum_distance'] = _minimumDistance;
    map['maximum_distance'] = _maximumDistance;
    map['booking_time'] = _bookingTime;
    map['service_image'] = _serviceImage;
    map['service_approve_status'] = _serviceApproveStatus;
    return map;
  }

}
// class VendorServiceList {
//   List<VendorServiceListModel> vendorServiceList;
//   VendorServiceList({required this.vendorServiceList});
//   factory VendorServiceList.fromJson(List<dynamic> parsedJson) {
//     List<VendorServiceListModel> temp = <VendorServiceListModel>[];
//
//     temp = parsedJson.map((e) => VendorServiceListModel.fromJson(e)).toList();
//     return VendorServiceList(vendorServiceList: temp);
//   }
// }
//
//
// class VendorServiceListModel {
//   VendorServiceListModel({
//       String? serviceId,
//       String? categoryId,
//       String? subcategoryId,
//       String? vendorId,
//       String? serviceName,
//       num? servicePrice,
//       num? discountPrice,
//       num? finalPrice,
//       String? description,
//       String? cityName,
//       List<String>? serviceImage,
//       String? serviceApproveStatus,}){
//     _serviceId = serviceId;
//     _categoryId = categoryId;
//     _subcategoryId = subcategoryId;
//     _vendorId = vendorId;
//     _serviceName = serviceName;
//     _servicePrice = servicePrice;
//     _discountPrice = discountPrice;
//     _finalPrice = finalPrice;
//     _description = description;
//     _cityName = cityName;
//     _serviceImage = serviceImage;
//     _serviceApproveStatus = serviceApproveStatus;
// }
//
//   VendorServiceListModel.fromJson(dynamic json) {
//     _serviceId = json['serviceId'];
//     _categoryId = json['categoryId'];
//     _subcategoryId = json['subcategoryId'];
//     _vendorId = json['vendorId'];
//     _serviceName = json['service_name'];
//     _servicePrice = json['service_price'];
//     _discountPrice = json['discount_price'];
//     _finalPrice = json['final_price'];
//     _description = json['description'];
//     _cityName = json['city_name'];
//     _serviceImage = json['service_image'] != null ? json['service_image'].cast<String>() : [];
//     _serviceApproveStatus = json['service_approve_status'];
//   }
//   String? _serviceId;
//   String? _categoryId;
//   String? _subcategoryId;
//   String? _vendorId;
//   String? _serviceName;
//   num? _servicePrice;
//   num? _discountPrice;
//   num? _finalPrice;
//   String? _description;
//   String? _cityName;
//   List<String>? _serviceImage;
//   String? _serviceApproveStatus;
// VendorServiceListModel copyWith({  String? serviceId,
//   String? categoryId,
//   String? subcategoryId,
//   String? vendorId,
//   String? serviceName,
//   num? servicePrice,
//   num? discountPrice,
//   num? finalPrice,
//   String? description,
//   String? cityName,
//   List<String>? serviceImage,
//   String? serviceApproveStatus,
// }) => VendorServiceListModel(  serviceId: serviceId ?? _serviceId,
//   categoryId: categoryId ?? _categoryId,
//   subcategoryId: subcategoryId ?? _subcategoryId,
//   vendorId: vendorId ?? _vendorId,
//   serviceName: serviceName ?? _serviceName,
//   servicePrice: servicePrice ?? _servicePrice,
//   discountPrice: discountPrice ?? _discountPrice,
//   finalPrice: finalPrice ?? _finalPrice,
//   description: description ?? _description,
//   cityName: cityName ?? _cityName,
//   serviceImage: serviceImage ?? _serviceImage,
//   serviceApproveStatus: serviceApproveStatus ?? _serviceApproveStatus,
// );
//   String? get serviceId => _serviceId;
//   String? get categoryId => _categoryId;
//   String? get subcategoryId => _subcategoryId;
//   String? get vendorId => _vendorId;
//   String? get serviceName => _serviceName;
//   num? get servicePrice => _servicePrice;
//   num? get discountPrice => _discountPrice;
//   num? get finalPrice => _finalPrice;
//   String? get description => _description;
//   String? get cityName => _cityName;
//   List<String>? get serviceImage => _serviceImage;
//   String? get serviceApproveStatus => _serviceApproveStatus;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['serviceId'] = _serviceId;
//     map['categoryId'] = _categoryId;
//     map['subcategoryId'] = _subcategoryId;
//     map['vendorId'] = _vendorId;
//     map['service_name'] = _serviceName;
//     map['service_price'] = _servicePrice;
//     map['discount_price'] = _discountPrice;
//     map['final_price'] = _finalPrice;
//     map['description'] = _description;
//     map['city_name'] = _cityName;
//     map['service_image'] = _serviceImage;
//     map['service_approve_status'] = _serviceApproveStatus;
//     return map;
//   }
//
// }