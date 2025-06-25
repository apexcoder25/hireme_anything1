

class VendorServiceModel {
    final String? id;
  var serviceName; // Changed from late final String? to var
  final int? price;
  var description; // Changed from late final String? to var
  var weeklyPrice; // Changed from late final int? to var

  var categoryId; // Changed from late final Category to var
  var subcategoryId; // Changed from late final Subcategory to var
  var vendorId; // Changed from late final Vendor to var

  var kilometerPrice; // Changed from late final int to var

  var serviceImage; // Changed from late final List<String> to var

  var cityName; // Changed from late final List<String> to var
  var noOfSeats; // Changed from late final int to var
  var registrationNo; // Changed from late final String to var
  var wheelChair; // Changed from late final String to var
  var makeAndModel; // Changed from late final String to var
  final String toiletFacility;
  var aironFitted; // Changed from late final String to var
  var minimumDistance; // Changed from late final String to var
  var maximumDistance; // Changed from late final String to var
  final String bookingTime;
  var serviceStatus; // Changed from late final String to var
  final String serviceApproveStatus;
  final String favouriteStatus;
  var bookingDateFrom; // Changed from late final String to var
  var bookingDateTo; // Changed from late final String to var
  final String numberOfService;
  final int rating;
  final int noOfBooking;
  final int offeringPrice;
  var specialPriceDays; // Changed from late final List<dynamic> to var
  var oneDayPrice; // Changed from late final int to var
  var weeklyDiscount; // Changed from late final int to var
  var monthlyDiscount; // Changed from late final int to var
  var extraTimeWaitingCharge; // Changed from late final int to var
  var extraMilesCharges; // Changed from late final int to var
  var cancellationPolicyType; // Changed from late final String to var
  var coupons; // Changed from late final List<Coupon> to var
  final String createdAt;
  final String updatedAt;
  VendorServiceModel({
     this.id,
    this.serviceName,
    this.price,
    this.description,
  this.weeklyPrice,
    required this.categoryId,
    required this.subcategoryId,
    required this.vendorId,

    required this.kilometerPrice,
  
    required this.serviceImage,
   
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
factory VendorServiceModel.fromJson(Map<String, dynamic> json) {
  return VendorServiceModel(
    id: json['_id'], // Allow null
    serviceName: json['service_name'],
    price: (json['price'] is double) ? (json['price'] as double).toInt() : json['price'],
    description: json['description'],
    categoryId: Category.fromJson(json['categoryId']),
    subcategoryId: Subcategory.fromJson(json['subcategoryId']),
    vendorId: Vendor.fromJson(json['vendorId']),
    kilometerPrice: (json['kilometer_price'] is double) ? (json['kilometer_price'] as double).toInt() : json['kilometer_price'],
    weeklyPrice: json['weekly_price'] != null
        ? (json['weekly_price'] is double ? (json['weekly_price'] as double).toInt() : json['weekly_price'])
        : 0,
    serviceImage: List<String>.from(json['service_image']),
    cityName: List<String>.from(json['city_name']),
    noOfSeats: json['no_of_seats'],
    registrationNo: json['registration_no'],
    wheelChair: json['wheel_chair'] ?? "",
    makeAndModel: json['make_and_model'],
    toiletFacility: json['toilet_facility'] ?? "",
    aironFitted: json['airon_fitted'] ?? "",
    minimumDistance: json['minimum_distance'],
    maximumDistance: json['maximum_distance'],
    bookingTime: json['booking_time'] ?? "",
    serviceStatus: json['service_status'],
    serviceApproveStatus: json['service_approve_status'],
    favouriteStatus: json['favourite_status'],
    bookingDateFrom: json['booking_date_from'],
    bookingDateTo: json['booking_date_to'],
    numberOfService: json['number_of_service'] ?? "",
    rating: (json['rating'] is double) ? (json['rating'] as double).toInt() : json['rating'],
    noOfBooking: (json['no_of_booking'] is double) ? (json['no_of_booking'] as double).toInt() : json['no_of_booking'],
    offeringPrice: (json['offering_price'] is double) ? (json['offering_price'] as double).toInt() : json['offering_price'],
    specialPriceDays: List<dynamic>.from(json['special_price_days']),
    oneDayPrice: (json['one_day_price'] is double) ? (json['one_day_price'] as double).toInt() : json['one_day_price'],
    weeklyDiscount: (json['weekly_discount'] is double) ? (json['weekly_discount'] as double).toInt() : json['weekly_discount'],
    monthlyDiscount: (json['monthly_discount'] is double) ? (json['monthly_discount'] as double).toInt() : json['monthly_discount'],
    extraTimeWaitingCharge: (json['extra_time_waiting_charge'] is double) ? (json['extra_time_waiting_charge'] as double).toInt() : json['extra_time_waiting_charge'],
    extraMilesCharges: (json['extra_miles_charges'] is double) ? (json['extra_miles_charges'] as double).toInt() : json['extra_miles_charges'],
    cancellationPolicyType: json['cancellation_policy_type'],
    coupons: (json['coupons'] as List).map((e) => Coupon.fromJson(e)).toList(),
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
  );
}

Map<String, dynamic> toJson() {
  return {
    '_id': id,
    'service_name': serviceName,
    'price': price,
    'description': description,
    'weekly_price': weeklyPrice,
    'categoryId': categoryId.toJson(),
    'subcategoryId': subcategoryId.toJson(),
    'vendorId': vendorId.toJson(),
    'kilometer_price': kilometerPrice,
    'service_image': serviceImage,
    'city_name': cityName,
    'no_of_seats': noOfSeats,
    'registration_no': registrationNo,
    'wheel_chair': wheelChair,
    'make_and_model': makeAndModel,
    'toilet_facility': toiletFacility,
    'airon_fitted': aironFitted,
    'minimum_distance': minimumDistance,
    'maximum_distance': maximumDistance,
    'booking_time': bookingTime,
    'service_status': serviceStatus,
    'service_approve_status': serviceApproveStatus,
    'favourite_status': favouriteStatus,
    'booking_date_from': bookingDateFrom,
    'booking_date_to': bookingDateTo,
    'number_of_service': numberOfService,
    'rating': rating,
    'no_of_booking': noOfBooking,
    'offering_price': offeringPrice,
    'special_price_days': specialPriceDays,
    'one_day_price': oneDayPrice,
    'weekly_discount': weeklyDiscount,
    'monthly_discount': monthlyDiscount,
    'extra_time_waiting_charge': extraTimeWaitingCharge,
    'extra_miles_charges': extraMilesCharges,
    'cancellation_policy_type': cancellationPolicyType,
    'coupons': coupons.map((coupon) => coupon.toJson()).toList(),
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };
}


}

class Category {
  final String id;
  final String categoryName;

  Category({required this.id, required this.categoryName});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      categoryName: json['category_name'],
    );
  }

  Map<String, dynamic> toJson() {
  return {
    '_id': id,
    'category_name': categoryName,
  };
}

}

class Subcategory {
  final String id;
  final String subcategoryName;

  Subcategory({required this.id, required this.subcategoryName});

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      id: json['_id'],
      subcategoryName: json['subcategory_name'],
    );
  }
  Map<String, dynamic> toJson() {
  return {
    '_id': id,
    'subcategory_name': subcategoryName,
  };
}

}

class Vendor {
  final String id;
  final String companyName;
  final String name;
  final String cityName;

  Vendor({
    required this.id,
    required this.companyName,
    required this.name,
    required this.cityName,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['_id'],
      companyName: json['company_name'],
      name: json['name'],
      cityName: json['city_name'],
    );
  }
  Map<String, dynamic> toJson() {
  return {
    '_id': id,
    'company_name': companyName,
    'name': name,
    'city_name': cityName,
  };
}

}
class Coupon {
  final String? couponCode; // Nullable to handle missing/null values
  final String? discountType; // Nullable
  final int? discountValue; // Nullable
  final int? usageLimit; // Nullable
  final int? currentUsageCount; // Nullable
  final String? expiryDate; // Nullable
  final bool? isGlobal; // Nullable
  final String? id; // Nullable

  Coupon({
    required this.couponCode,
    required this.discountType,
    required this.discountValue,
    required this.usageLimit,
    required this.currentUsageCount,
    required this.expiryDate,
    required this.isGlobal,
    required this.id,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      couponCode: json['coupon_code'] as String?,
      discountType: json['discount_type'] as String?,
      discountValue: json['discount_value'] as int?,
      usageLimit: json['usage_limit'] as int?,
      currentUsageCount: json['current_usage_count'] as int?,
      expiryDate: json['expiry_date'] as String?,
      isGlobal: json['is_global'] as bool?,
      id: json['_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coupon_code': couponCode,
      'discount_type': discountType,
      'discount_value': discountValue,
      'usage_limit': usageLimit,
      'current_usage_count': currentUsageCount,
      'expiry_date': expiryDate,
      'is_global': isGlobal,
      '_id': id,
    };
  }
}




class TutorHireService {
  final String id;
  final Category? categoryId;
  final Subcategory? subcategoryId;
  final Vendor? vendorId;
  final String keyword;
  final int yearsOfExperience;
  final List<String> fieldsOfExpertise;
  final String highestDegree;
  final String specializations;
  final String employmentStatus;
  final List<String> certifications;
  final List<String> languagesKnown;
  final String profilePicture;
  final String serviceApproveStatus;
  final String serviceStatus;
  final List<Service> services;
  final String createdAt;
  final String updatedAt;
  final int v;

  TutorHireService({
    required this.id,
     this.categoryId,
   this.subcategoryId,
     this.vendorId,
    required this.keyword,
    required this.yearsOfExperience,
    required this.fieldsOfExpertise,
    required this.highestDegree,
    required this.specializations,
    required this.employmentStatus,
    required this.certifications,
    required this.languagesKnown,
    required this.profilePicture,
    required this.serviceApproveStatus,
    required this.serviceStatus,
    required this.services,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });
factory TutorHireService.fromJson(Map<String, dynamic> json) {
  return TutorHireService(
    id: json['_id'] ?? "",
    categoryId: json['categoryId'] != null ? Category.fromJson(json['categoryId']) : null,
    subcategoryId: json['subcategoryId'] != null ? Subcategory.fromJson(json['subcategoryId']) : null,
    vendorId: json['vendorId'] != null ? Vendor.fromJson(json['vendorId']) : null,
    keyword: json['keyword'] ?? "",
    yearsOfExperience: json['yearsOfExperience'] ?? 0,
    fieldsOfExpertise: json['fieldsOfExpertise'] != null
        ? List<String>.from(json['fieldsOfExpertise'])
        : [],
    highestDegree: json['highestDegree'] ?? "",
    specializations: json['specializations'] ?? "",
    employmentStatus: json['employmentStatus'] ?? "",
    certifications: json['certifications'] != null
        ? List<String>.from(json['certifications'])
        : [],
    languagesKnown: json['languages_known'] != null
        ? List<String>.from(json['languages_known'])
        : [],
    profilePicture: json['profilePicture'] ?? "",
    serviceApproveStatus: json['service_approve_status'] ?? "",
    serviceStatus: json['service_status'] ?? "",
   services: json['services'] != null
          ? (json['services'] as List).map((service) => Service.fromJson(service)).toList()
          : [],
    createdAt: json['createdAt'] ?? "",
    updatedAt: json['updatedAt'] ?? "",
    v: json['__v'] ?? 0,
  );
}

}



class Service {
  final String subject;
  final String serviceStatus;
  final List<String> daysAvailable;
  final String timeSlot;
  final String willingToTeach;
  final String trialClass;
  final bool needRecording;
  final List<GradeDetail> gradeDetails;
  final String id;

  Service({
    required this.subject,
    required this.serviceStatus,
    required this.daysAvailable,
    required this.timeSlot,
    required this.willingToTeach,
    required this.trialClass,
    required this.needRecording,
    required this.gradeDetails,
    required this.id,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      subject: json['subject'],
      serviceStatus: json['service_status'],
      daysAvailable: List<String>.from(json['daysAvailable']),
      timeSlot: json['timeSlot'] ?? "",
      willingToTeach: json['willingToTeach'],
      trialClass: json['trial_class'],
      needRecording: json['needRecording'],
      gradeDetails: (json['gradeDetails'] as List)
          .map((grade) => GradeDetail.fromJson(grade))
          .toList(),
      id: json['_id'],
    );
  }
}

class GradeDetail {
  final String grade;
  final double price;
  final String id;

  GradeDetail({required this.grade, required this.price, required this.id});

  factory GradeDetail.fromJson(Map<String, dynamic> json) {
    return GradeDetail(
      grade: json['grade'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      id: json['_id'] ?? '',
    );
  }
}


class AutomotiveHireService {
  final String id;
   final Category? categoryId;
  final Subcategory? subcategoryId;
  final Vendor? vendorId;
  
  final List<AutomotiveServiceOffered> automotiveServicesOffered;
  final int automativeYearsOfExperience;
  final List<String> automotiveSpecialization;
  final String serviceStatus;
  final String serviceApproveStatus;
  final String favouriteStatus;
  final List<String> automotiveKeyProjects;
  final List<String> automotiveServiceImage;
  final List<String> daysAvailable;
  final String timeSlot;
  final String automotiveJobTitle;
  final List<String> automotivePreferredWorkLocation;
  final int automativeDefaultPrice;
  final int oneDayPrice;
  final int perHourPrice;
  final String bookingDateFrom;
  final String bookingDateTo;
  final List<String> specialPriceDays;
  final List<String> automotiveKeySkills;
  final String createdAt;
  final String updatedAt;

  AutomotiveHireService({
    required this.id,
     this.categoryId,
     this.subcategoryId,
     this.vendorId,
    required this.automotiveServicesOffered,
    required this.automativeYearsOfExperience,
    required this.automotiveSpecialization,
    required this.serviceStatus,
    required this.serviceApproveStatus,
    required this.favouriteStatus,
    required this.automotiveKeyProjects,
    required this.automotiveServiceImage,
    required this.daysAvailable,
    required this.timeSlot,
    required this.automotiveJobTitle,
    required this.automotivePreferredWorkLocation,
    required this.automativeDefaultPrice,
    required this.oneDayPrice,
    required this.perHourPrice,
    required this.bookingDateFrom,
    required this.bookingDateTo,
    required this.specialPriceDays,
    required this.automotiveKeySkills,
    required this.createdAt,
    required this.updatedAt,
  });
factory AutomotiveHireService.fromJson(Map<String, dynamic> json) {
  return AutomotiveHireService(
    id: json['_id'] ?? "",
    categoryId: json['categoryId'] != null ? Category.fromJson(json['categoryId']) : null,
    subcategoryId: json['subcategoryId'] != null ? Subcategory.fromJson(json['subcategoryId']) : null,
    vendorId: json['vendorId'] != null ? Vendor.fromJson(json['vendorId']) : null,
    
    automotiveServicesOffered: json['automotiveServicesOffered'] != null
        ? (json['automotiveServicesOffered'] as List)
            .map((e) => AutomotiveServiceOffered.fromJson(e))
            .toList()
        : [],
    
    automativeYearsOfExperience: (json['automativeYearsOfExperience'] ?? 0).toInt(),

    automotiveSpecialization: json['automotiveSpecialization'] != null
        ? List<String>.from(json['automotiveSpecialization'].map((e) => e.toString()))
        : [],

    serviceStatus: json['service_status'] ?? "",
    serviceApproveStatus: json['service_approve_status'] ?? "",
    favouriteStatus: json['favourite_status'] ?? "",

    automotiveKeyProjects: json['automotive_keyProjects'] != null
        ? List<String>.from(json['automotive_keyProjects'].map((e) => e.toString()))
        : [],

    automotiveServiceImage: json['automotiveService_image'] != null
        ? List<String>.from(json['automotiveService_image'].map((e) => e.toString()))
        : [],

    daysAvailable: json['daysAvailable'] != null
        ? List<String>.from(json['daysAvailable'].map((e) => e.toString()))
        : [],

    timeSlot: json['timeSlot'] ?? "",
    automotiveJobTitle: json['automotiveJobTitle'] ?? "",

    automotivePreferredWorkLocation: json['automotivePreferredWorkLocation'] != null
        ? List<String>.from(json['automotivePreferredWorkLocation'].map((e) => e.toString()))
        : [],

   automativeDefaultPrice: (json['automativeDefaultPrice'] ?? 0).toInt(),

    oneDayPrice: json['one_day_price'] ?? 0,
    perHourPrice: (json['per_hour_price'] ?? 0).toInt(),

    bookingDateFrom: json['booking_date_from'] ?? "",
    bookingDateTo: json['booking_date_to'] ?? "",

    specialPriceDays: json['special_price_days'] != null
        ? List<String>.from(json['special_price_days'].map((e) => e.toString()))
        : [],

    automotiveKeySkills: json['automotive_keySkills'] != null
        ? List<String>.from(json['automotive_keySkills'].map((e) => e.toString()))
        : [],

    createdAt: json['createdAt'] ?? "",
    updatedAt: json['updatedAt'] ?? "",
  );
}
}




class AutomotiveServiceOffered {
  final String serviceName;
  final int originalPrice;
  final int discountedPrice;
  final String id;

  AutomotiveServiceOffered({
    required this.serviceName,
    required this.originalPrice,
    required this.discountedPrice,
    required this.id,
  });

  factory AutomotiveServiceOffered.fromJson(Map<String, dynamic> json) {
    return AutomotiveServiceOffered(
     serviceName: json['serviceName'] ?? "",
  
      originalPrice: json['original_price'] ?? 0,
      discountedPrice: json['discounted_price'] ?? 0,
      id: json['_id'] ?? "",
    );
  }
}
