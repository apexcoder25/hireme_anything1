// /// serviceId : "67014712ac674e1598cfd926"
// /// categoryId : "66fe724b482d39cca58273df"
// /// subcategoryId : "66fe76e6482d39cca582740f"
// /// vendorId : "670146a9ac674e1598cfd918"
// /// service_name : "tctc"
// /// service_price : 28285
// /// discount_price : 78.58
// /// final_price : 6060
// /// description : "g gv"
// /// city_name : "Indore"
// /// service_image : ["1000056361_out.jpg","1000056297_out.jpg","1000056372_out.jpg","1000056110_out.jpg"]
// /// service_approve_status : "1"
//
// class ServiceList {
//   List<ServiceListMode> serviceList;
//   ServiceList({required this.serviceList});
//   factory ServiceList.fromJson(List<dynamic> parsedJson) {
//     List<ServiceListMode> temp = <ServiceListMode>[];
//
//     temp = parsedJson.map((e) => ServiceListMode.fromJson(e)).toList();
//     return ServiceList(serviceList: temp);
//   }
// }
//
//
// class ServiceListMode {
//   ServiceListMode({
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
//       String? serviceApproveStatus,
//       String? category_name,
//       String? subcategory_name,
//   }){
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
//     _category_name = category_name;
//     _subcategory_name = subcategory_name;
// }
//
//   ServiceListMode.fromJson(dynamic json) {
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
//     _category_name = json['category_name'];
//     _subcategory_name = json['subcategory_name'];
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
//   String? _category_name;
//   String? _subcategory_name;
// ServiceListMode copyWith({  String? serviceId,
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
//   String? category_name,
//   String? subcategory_name,
// }) => ServiceListMode(  serviceId: serviceId ?? _serviceId,
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
//   category_name: category_name ?? _category_name,
//   subcategory_name: subcategory_name ?? _subcategory_name,
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
//   String? get category_name => _category_name;
//   String? get subcategory_name => _subcategory_name;
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
//     map['category_name'] = _category_name;
//     map['subcategory_name'] = _subcategory_name;
//     return map;
//   }
//
// }