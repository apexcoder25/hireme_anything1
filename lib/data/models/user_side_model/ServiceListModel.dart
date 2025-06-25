/// serviceId : "67014712ac674e1598cfd926"
/// categoryId : "66fe724b482d39cca58273df"
/// subcategoryId : "66fe76e6482d39cca582740f"
/// vendorId : "670146a9ac674e1598cfd918"
/// service_name : "tctc"
/// service_price : 28285
/// discount_price : 78.58
/// final_price : 6060
/// service_image : ["1000056361_out.jpg","1000056297_out.jpg","1000056372_out.jpg","1000056110_out.jpg"]
/// description : "g gv"
/// city_name : "Indore"
/// service_status : "0"
/// service_approve_status : "1"

class ServiceListModel {
  ServiceListModel({
      String? serviceId, 
      String? categoryId, 
      String? subcategoryId, 
      String? vendorId, 
      String? serviceName, 
      num? servicePrice, 
      num? discountPrice, 
      num? finalPrice, 
      List<String>? serviceImage, 
      String? description, 
      String? cityName, 
      String? serviceStatus, 
      String? serviceApproveStatus,
      String? booking_time,
      String? rating,
      String? no_of_booking,
  }){
    _serviceId = serviceId;
    _categoryId = categoryId;
    _subcategoryId = subcategoryId;
    _vendorId = vendorId;
    _serviceName = serviceName;
    _servicePrice = servicePrice;
    _discountPrice = discountPrice;
    _finalPrice = finalPrice;
    _serviceImage = serviceImage;
    _description = description;
    _cityName = cityName;
    _serviceStatus = serviceStatus;
    _serviceApproveStatus = serviceApproveStatus;
    _booking_time = booking_time;
    _rating = rating;
    _no_of_booking = no_of_booking;
}

  ServiceListModel.fromJson(dynamic json) {
    _serviceId = json['serviceId'];
    _categoryId = json['categoryId'];
    _subcategoryId = json['subcategoryId'];
    _vendorId = json['vendorId'];
    _serviceName = json['service_name'];
    _servicePrice = json['service_price'];
    _discountPrice = json['discount_price'];
    _finalPrice = json['final_price'];
    _serviceImage = json['service_image'] != null ? json['service_image'].cast<String>() : [];
    _description = json['description'];
    _cityName = json['city_name'];
    _serviceStatus = json['service_status'];
    _serviceApproveStatus = json['service_approve_status'];
    _booking_time = json['booking_time'];
    _rating = json['rating'].toString();
    _no_of_booking = json['no_of_booking'].toString();
  }
  String? _serviceId;
  String? _categoryId;
  String? _subcategoryId;
  String? _vendorId;
  String? _serviceName;
  num? _servicePrice;
  num? _discountPrice;
  num? _finalPrice;
  List<String>? _serviceImage;
  String? _description;
  String? _cityName;
  String? _serviceStatus;
  String? _serviceApproveStatus;
  String? _booking_time;
  String? _rating;
  String? _no_of_booking;
ServiceListModel copyWith({  String? serviceId,
  String? categoryId,
  String? subcategoryId,
  String? vendorId,
  String? serviceName,
  num? servicePrice,
  num? discountPrice,
  num? finalPrice,
  List<String>? serviceImage,
  String? description,
  String? cityName,
  String? serviceStatus,
  String? serviceApproveStatus,
  String? booking_time,
  String? rating,
  String? no_of_booking,
}) => ServiceListModel(  serviceId: serviceId ?? _serviceId,
  categoryId: categoryId ?? _categoryId,
  subcategoryId: subcategoryId ?? _subcategoryId,
  vendorId: vendorId ?? _vendorId,
  serviceName: serviceName ?? _serviceName,
  servicePrice: servicePrice ?? _servicePrice,
  discountPrice: discountPrice ?? _discountPrice,
  finalPrice: finalPrice ?? _finalPrice,
  serviceImage: serviceImage ?? _serviceImage,
  description: description ?? _description,
  cityName: cityName ?? _cityName,
  serviceStatus: serviceStatus ?? _serviceStatus,
  serviceApproveStatus: serviceApproveStatus ?? _serviceApproveStatus,
  booking_time: booking_time ?? _booking_time,
  rating: rating ?? _rating,
  no_of_booking: no_of_booking ?? _no_of_booking,
);
  String? get serviceId => _serviceId;
  String? get categoryId => _categoryId;
  String? get subcategoryId => _subcategoryId;
  String? get vendorId => _vendorId;
  String? get serviceName => _serviceName;
  num? get servicePrice => _servicePrice;
  num? get discountPrice => _discountPrice;
  num? get finalPrice => _finalPrice;
  List<String>? get serviceImage => _serviceImage;
  String? get description => _description;
  String? get cityName => _cityName;
  String? get serviceStatus => _serviceStatus;
  String? get serviceApproveStatus => _serviceApproveStatus;
  String? get booking_time => _booking_time;
  String? get rating => _rating;
  String? get no_of_booking => _no_of_booking;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['serviceId'] = _serviceId;
    map['categoryId'] = _categoryId;
    map['subcategoryId'] = _subcategoryId;
    map['vendorId'] = _vendorId;
    map['service_name'] = _serviceName;
    map['service_price'] = _servicePrice;
    map['discount_price'] = _discountPrice;
    map['final_price'] = _finalPrice;
    map['service_image'] = _serviceImage;
    map['description'] = _description;
    map['city_name'] = _cityName;
    map['service_status'] = _serviceStatus;
    map['service_approve_status'] = _serviceApproveStatus;
    map['booking_time'] = _booking_time;
    map['rating'] = _rating;
    map['no_of_booking'] = _no_of_booking;
    return map;
  }

}