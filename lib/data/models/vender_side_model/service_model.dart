// ignore_for_file: public_member_api_docs, sort_constructors_first
class Vendor {
  String id;
  String name;
  String email;

  Vendor({required this.id, required this.name, required this.email});

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
    );
  }
}

class Category {
  String id;
  String categoryName;

  Category({required this.id, required this.categoryName});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["_id"] ?? "",
      categoryName: json["categoryName"] ?? "",
    );
  }
}

class Subcategory {
  String id;
  String subcategoryName;

  Subcategory({required this.id, required this.subcategoryName});

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      id: json["_id"] ?? "",
      subcategoryName: json["subcategoryName"] ?? "",
    );
  }
}

class Coupon {
  String id;
  String code;
  int discount;

  Coupon({required this.id, required this.code, required this.discount});

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json["_id"] ?? "",
      code: json["code"] ?? "",
      discount: json["discount"] ?? 0,
    );
  }
}

class ServiceModel {
  String id;
  Category category;
  Subcategory subcategory;
  Vendor vendor;
  String serviceName;
  double kilometerPrice;
  double weeklyPrice;
  List<String> serviceImage;
  String description;
  List<String> cityName;
  int noOfSeats;
  String registrationNo;
  String wheelChair;
  String makeAndModel;
  String toiletFacility;
  String aironFitted;
  String minimumDistance;
  String maximumDistance;
  String bookingTime;
  String serviceStatus;
  String serviceApproveStatus;
  String favouriteStatus;
  String bookingDateFrom;
  String bookingDateTo;
  String numberOfService;
  int rating;
  int noOfBooking;
  int offeringPrice;
  List<dynamic> specialPriceDays;
  int oneDayPrice;
  int weeklyDiscount;
  int monthlyDiscount;
  int extraTimeWaitingCharge;
  int extraMilesCharges;
  String cancellationPolicyType;
  List<Coupon> coupons;
  String createdAt;
  String updatedAt;

  ServiceModel({
    required this.id,
    required this.category,
    required this.subcategory,
    required this.vendor,
    required this.serviceName,
    required this.kilometerPrice,
    required this.weeklyPrice,
    required this.serviceImage,
    required this.description,
    required this.cityName,
    required this.noOfSeats,
    required this.registrationNo,
    required this.wheelChair,
    required this.makeAndModel,
    required this.toiletFacility,
    required this.aironFitted,
    required this.minimumDistance,
    required this.maximumDistance,
    required this.bookingTime,
    required this.serviceStatus,
    required this.serviceApproveStatus,
    required this.favouriteStatus,
    required this.bookingDateFrom,
    required this.bookingDateTo,
    required this.numberOfService,
    required this.rating,
    required this.noOfBooking,
    required this.offeringPrice,
    required this.specialPriceDays,
    required this.oneDayPrice,
    required this.weeklyDiscount,
    required this.monthlyDiscount,
    required this.extraTimeWaitingCharge,
    required this.extraMilesCharges,
    required this.cancellationPolicyType,
    required this.coupons,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json["_id"] ?? "",
      category: json["categoryId"] != null ? Category.fromJson(json["categoryId"]) : Category(id: "", categoryName: ""),
      subcategory: json["subcategoryId"] != null ? Subcategory.fromJson(json["subcategoryId"]) : Subcategory(id: "", subcategoryName: ""),
      vendor: json["vendorId"] != null ? Vendor.fromJson(json["vendorId"]) : Vendor(id: "", name: "", email: ""),
      serviceName: json["service_name"] ?? "",
      kilometerPrice: (json["kilometer_price"] ?? 0).toDouble(),
      weeklyPrice: (json["weekly_price"] ?? 0).toDouble(),
      serviceImage: List<String>.from(json["service_image"] ?? []),
      description: json["description"] ?? "",
      cityName: List<String>.from(json["city_name"] ?? []),
      noOfSeats: json["no_of_seats"] ?? 0,
      registrationNo: json["registration_no"] ?? "",
      wheelChair: json["wheel_chair"] ?? "",
      makeAndModel: json["make_and_model"] ?? "",
      toiletFacility: json["toilet_facility"] ?? "",
      aironFitted: json["airon_fitted"] ?? "",
      minimumDistance: json["minimum_distance"] ?? "",
      maximumDistance: json["maximum_distance"] ?? "",
      bookingTime: json["booking_time"] ?? "",
      serviceStatus: json["service_status"] ?? "",
      serviceApproveStatus: json["service_approve_status"] ?? "",
      favouriteStatus: json["favourite_status"] ?? "",
      bookingDateFrom: json["booking_date_from"] ?? "",
      bookingDateTo: json["booking_date_to"] ?? "",
      numberOfService: json["number_of_service"] ?? "",
      rating: json["rating"] ?? 0,
      noOfBooking: json["no_of_booking"] ?? 0,
      offeringPrice: json["offering_price"] ?? 0,
      specialPriceDays: List<dynamic>.from(json["special_price_days"] ?? []),
      oneDayPrice: json["one_day_price"] ?? 0,
      weeklyDiscount: json["weekly_discount"] ?? 0,
      monthlyDiscount: json["monthly_discount"] ?? 0,
      extraTimeWaitingCharge: json["extra_time_waiting_charge"] ?? 0,
      extraMilesCharges: json["extra_miles_charges"] ?? 0,
      cancellationPolicyType: json["cancellation_policy_type"] ?? "",
      coupons: (json["coupons"] as List?)?.map((coupon) => Coupon.fromJson(coupon)).toList() ?? [],
      createdAt: json["createdAt"] ?? "",
      updatedAt: json["updatedAt"] ?? "",
    );
  }
}

class AutomotiveHireServiceModel {
  String? id;
  Category? categoryId;
  Subcategory? subcategoryId;
   Category category;
  Subcategory subcategory;
  Vendor vendor;
  Vendor? vendorId;
  List<ServiceOffered>? automotiveServicesOffered;
  int? automativeYearsOfExperience;
  List<String>? automotiveSpecialization;
  String? serviceStatus;
  String? serviceApproveStatus;
  String? favouriteStatus;
  List<String>? automotiveKeyProjects;
  List<String>? automotiveServiceImage;
  List<String>? daysAvailable;
  String? timeSlot;
  String? automotiveJobTitle;
  List<String>? automotivePreferredWorkLocation;
  int? automativeDefaultPrice;
  int? oneDayPrice;
  int? perHourPrice;
  String? bookingDateFrom;
  String? bookingDateTo;
  List<String>? specialPriceDays;
  List<String>? automotiveKeySkills;
  String? createdAt;
  String? updatedAt;

  AutomotiveHireServiceModel({
    this.id,
    this.categoryId,
    this.subcategoryId,
    required this.category,
    required this.subcategory,
    required this.vendor,
    this.vendorId,
    this.automotiveServicesOffered,
    this.automativeYearsOfExperience,
    this.automotiveSpecialization,
    this.serviceStatus,
    this.serviceApproveStatus,
    this.favouriteStatus,
    this.automotiveKeyProjects,
    this.automotiveServiceImage,
    this.daysAvailable,
    this.timeSlot,
    this.automotiveJobTitle,
    this.automotivePreferredWorkLocation,
    this.automativeDefaultPrice,
    this.oneDayPrice,
    this.perHourPrice,
    this.bookingDateFrom,
    this.bookingDateTo,
    this.specialPriceDays,
    this.automotiveKeySkills,
    this.createdAt,
    this.updatedAt,
  });

  factory AutomotiveHireServiceModel.fromJson(Map<String, dynamic> json) {
    return AutomotiveHireServiceModel(
      id: json['_id'] ?? '',
      categoryId: json['categoryId'] != null ? Category.fromJson(json['categoryId']) : null,
      subcategoryId: json['subcategoryId'] != null ? Subcategory.fromJson(json['subcategoryId']) : null,
        category: json["categoryId"] != null ? Category.fromJson(json["categoryId"]) : Category(id: "", categoryName: ""),
      subcategory: json["subcategoryId"] != null ? Subcategory.fromJson(json["subcategoryId"]) : Subcategory(id: "", subcategoryName: ""),
      vendor: json["vendorId"] != null ? Vendor.fromJson(json["vendorId"]) : Vendor(id: "", name: "", email: ""),
      vendorId: json['vendorId'] != null ? Vendor.fromJson(json['vendorId']) : null,
      automotiveServicesOffered: json['automotiveServicesOffered'] != null
          ? (json['automotiveServicesOffered'] as List).map((e) => ServiceOffered.fromJson(e)).toList()
          : [],
      automativeYearsOfExperience: json['automativeYearsOfExperience'] ?? 0,
      automotiveSpecialization: (json['automotiveSpecialization'] as List?)?.map((e) => e.toString()).toList() ?? [],
      serviceStatus: json['service_status'] ?? '',
      serviceApproveStatus: json['service_approve_status'] ?? '',
      favouriteStatus: json['favourite_status'] ?? '',
      automotiveKeyProjects: (json['automotive_keyProjects'] as List?)?.map((e) => e.toString()).toList() ?? [],
      automotiveServiceImage: (json['automotiveService_image'] as List?)?.map((e) => e.toString()).toList() ?? [],
      daysAvailable: (json['daysAvailable'] as List?)?.map((e) => e.toString()).toList() ?? [],
      timeSlot: json['timeSlot'] ?? '',
      automotiveJobTitle: json['automotiveJobTitle'] ?? '',
      automotivePreferredWorkLocation: (json['automotivePreferredWorkLocation'] as List?)?.map((e) => e.toString()).toList() ?? [],
      automativeDefaultPrice: json['automativeDefaultPrice'] ?? 0,
      oneDayPrice: json['one_day_price'] ?? 0,
      perHourPrice: json['per_hour_price'] ?? 0,
      bookingDateFrom: json['booking_date_from'] ?? '',
      bookingDateTo: json['booking_date_to'] ?? '',
      specialPriceDays: (json['special_price_days'] as List?)?.map((e) => e.toString()).toList() ?? [],
      automotiveKeySkills: (json['automotive_keySkills'] as List?)?.map((e) => e.toString()).toList() ?? [],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}



class ServiceOffered {
  String? id;
  String? serviceName;
  int? originalPrice;
  int? discountedPrice;

  ServiceOffered({this.id, this.serviceName, this.originalPrice, this.discountedPrice});

  factory ServiceOffered.fromJson(Map<String, dynamic> json) {
    return ServiceOffered(
      id: json['_id'] ?? '',
      serviceName: json['service_name'] ?? '',
      originalPrice: json['original_price'] ?? 0,
      discountedPrice: json['discounted_price'] ?? 0,
    );
  }
}
