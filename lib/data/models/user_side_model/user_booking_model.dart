
class BookingDetails {
  BookingDetails({
    this.vendorBankDetails,
    this.id,
    this.userId,
    this.vendorId,
    this.serviceId,
    this.grandTotal,
    this.commissionPrice,
    this.pickupDate,
    this.pickupTime,
    this.pickupLocation,
    this.dropLocation,
    this.distance,
    this.bookingSeats,
    this.paypalOrderId,
    this.bookingStatus,
    this.otp,
    this.cancellationPolicyType,
    this.bookingServiceStatus,
    this.paymentMethod,
    this.refundAmount,
    this.orderNo,
    this.createdAt,
    this.updatedAt,
    this.version, // Renamed from __v to version
  });

  final VendorBankDetails? vendorBankDetails;
  final String? id;
  final String? userId;
  final VendorId? vendorId;
  final ServiceId? serviceId;
  final double? grandTotal;
  final double? commissionPrice;
  final DateTime? pickupDate;
  final String? pickupTime;
  final String? pickupLocation;
  final String? dropLocation;
  final double? distance;
  final int? bookingSeats;
  final String? paypalOrderId;
  final String? bookingStatus;
  final int? otp;
  final String? cancellationPolicyType;
  final String? bookingServiceStatus;
  final String? paymentMethod;
  final double? refundAmount;
  final int? orderNo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? version; // Renamed field

  factory BookingDetails.fromJson(Map<String, dynamic> json) {
    return BookingDetails(
      vendorBankDetails: json["vendorBankDetails"] == null
          ? null
          : VendorBankDetails.fromJson(json["vendorBankDetails"]),
      id: json["_id"],
      userId: json["userId"],
      vendorId: json["vendorId"] == null ? null : VendorId.fromJson(json["vendorId"]),
      serviceId: json["serviceId"] == null ? null : ServiceId.fromJson(json["serviceId"]),
      grandTotal: json["grand_total"]?.toDouble(),
      commissionPrice: json["commission_price"]?.toDouble(),
      pickupDate: DateTime.tryParse(json["pickup_date"] ?? ""),
      pickupTime: json["pickup_time"],
      pickupLocation: json["pickup_location"],
      dropLocation: json["drop_location"],
      distance: json["distance"]?.toDouble(),
      bookingSeats: json["booking_seats"],
      paypalOrderId: json["paypal_order_id"],
      bookingStatus: json["booking_status"],
      otp: json["otp"],
      cancellationPolicyType: json["cancellation_policy_type"],
      bookingServiceStatus: json["booking_service_status"],
      paymentMethod: json["payment_method"],
      refundAmount: json["refund_amount"]?.toDouble(),
      orderNo: json["order_no"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      version: json["__v"], // Map JSON "__v" to "version"
    );
  }

  Map<String, dynamic> toJson() => {
    "vendorBankDetails": vendorBankDetails?.toJson(),
    "_id": id,
    "userId": userId,
    "vendorId": vendorId?.toJson(),
    "serviceId": serviceId?.toJson(),
    "grand_total": grandTotal,
    "commission_price": commissionPrice,
    "pickup_date": pickupDate?.toIso8601String().split('T')[0],
    "pickup_time": pickupTime,
    "pickup_location": pickupLocation,
    "drop_location": dropLocation,
    "distance": distance,
    "booking_seats": bookingSeats,
    "paypal_order_id": paypalOrderId,
    "booking_status": bookingStatus,
    "otp": otp,
    "cancellation_policy_type": cancellationPolicyType,
    "booking_service_status": bookingServiceStatus,
    "payment_method": paymentMethod,
    "refund_amount": refundAmount,
    "order_no": orderNo,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": version, // Map "version" back to "__v"
  };
}
class ServiceId {
  ServiceId({
    this.id,
    this.categoryId,
    this.subcategoryId,
    this.vendorId,
    this.serviceName,
    this.kilometerPrice,
    this.weeklyPrice,
    this.serviceImage,
    this.description,
    this.cityName,
    this.noOfSeats,
    this.registrationNo,
    this.wheelChair,
    this.makeAndModel,
    this.toiletFacility,
    this.aironFitted,
    this.minimumDistance,
    this.maximumDistance,
    this.bookingTime,
    this.serviceStatus,
    this.serviceApproveStatus,
    this.favouriteStatus,
    this.bookingDateFrom,
    this.bookingDateTo,
    this.numberOfService,
    this.rating,
    this.noOfBooking,
    this.offeringPrice,
    this.specialPriceDays,
    this.oneDayPrice,
    this.weeklyDiscount,
    this.monthlyDiscount,
    this.extraTimeWaitingCharge,
    this.extraMilesCharges,
    this.cancellationPolicyType,
    this.coupons,
    this.createdAt,
    this.updatedAt,
    this.version, // Renamed from __v to version
  });

  final String? id;
  final String? categoryId;
  final String? subcategoryId;
  final String? vendorId;
  final String? serviceName;
  final int? kilometerPrice;
  final int? weeklyPrice;
  final List<String>? serviceImage;
  final String? description;
  final List<String>? cityName;
  final int? noOfSeats;
  final String? registrationNo;
  final String? wheelChair;
  final String? makeAndModel;
  final String? toiletFacility;
  final String? aironFitted;
  final String? minimumDistance;
  final String? maximumDistance;
  final String? bookingTime;
  final String? serviceStatus;
  final String? serviceApproveStatus;
  final String? favouriteStatus;
  final DateTime? bookingDateFrom;
  final DateTime? bookingDateTo;
  final String? numberOfService;
  final int? rating;
  final int? noOfBooking;
  final int? offeringPrice;
  final List<dynamic>? specialPriceDays;
  final int? oneDayPrice;
  final int? weeklyDiscount;
  final int? monthlyDiscount;
  final int? extraTimeWaitingCharge;
  final int? extraMilesCharges;
  final String? cancellationPolicyType;
  final List<Coupon>? coupons;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? version; // Renamed field

  factory ServiceId.fromJson(Map<String, dynamic> json) {
    return ServiceId(
      id: json["_id"],
      categoryId: json["categoryId"],
      subcategoryId: json["subcategoryId"],
      vendorId: json["vendorId"],
      serviceName: json["service_name"],
      kilometerPrice: json["kilometer_price"],
      weeklyPrice: json["weekly_price"],
      serviceImage: json["service_image"] == null
          ? null
          : List<String>.from(json["service_image"]!.map((x) => x.toString())),
      description: json["description"],
      cityName: json["city_name"] == null
          ? null
          : List<String>.from(json["city_name"]!.map((x) => x.toString())),
      noOfSeats: json["no_of_seats"],
      registrationNo: json["registration_no"],
      wheelChair: json["wheel_chair"],
      makeAndModel: json["make_and_model"],
      toiletFacility: json["toilet_facility"],
      aironFitted: json["airon_fitted"],
      minimumDistance: json["minimum_distance"],
      maximumDistance: json["maximum_distance"],
      bookingTime: json["booking_time"],
      serviceStatus: json["service_status"],
      serviceApproveStatus: json["service_approve_status"],
      favouriteStatus: json["favourite_status"],
      bookingDateFrom: DateTime.tryParse(json["booking_date_from"] ?? ""),
      bookingDateTo: DateTime.tryParse(json["booking_date_to"] ?? ""),
      numberOfService: json["number_of_service"],
      rating: json["rating"],
      noOfBooking: json["no_of_booking"],
      offeringPrice: json["offering_price"],
      specialPriceDays: json["special_price_days"] == null
          ? null
          : List<dynamic>.from(json["special_price_days"]!.map((x) => x)),
      oneDayPrice: json["one_day_price"],
      weeklyDiscount: json["weekly_discount"],
      monthlyDiscount: json["monthly_discount"],
      extraTimeWaitingCharge: json["extra_time_waiting_charge"],
      extraMilesCharges: json["extra_miles_charges"],
      cancellationPolicyType: json["cancellation_policy_type"],
      coupons: json["coupons"] == null
          ? null
          : List<Coupon>.from(json["coupons"]!.map((x) => Coupon.fromJson(x))),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      version: json["__v"], // Map JSON "__v" to "version"
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "categoryId": categoryId,
    "subcategoryId": subcategoryId,
    "vendorId": vendorId,
    "service_name": serviceName,
    "kilometer_price": kilometerPrice,
    "weekly_price": weeklyPrice,
    "service_image": serviceImage?.map((x) => x).toList(),
    "description": description,
    "city_name": cityName?.map((x) => x).toList(),
    "no_of_seats": noOfSeats,
    "registration_no": registrationNo,
    "wheel_chair": wheelChair,
    "make_and_model": makeAndModel,
    "toilet_facility": toiletFacility,
    "airon_fitted": aironFitted,
    "minimum_distance": minimumDistance,
    "maximum_distance": maximumDistance,
    "booking_time": bookingTime,
    "service_status": serviceStatus,
    "service_approve_status": serviceApproveStatus,
    "favourite_status": favouriteStatus,
    "booking_date_from": bookingDateFrom?.toIso8601String(),
    "booking_date_to": bookingDateTo?.toIso8601String(),
    "number_of_service": numberOfService,
    "rating": rating,
    "no_of_booking": noOfBooking,
    "offering_price": offeringPrice,
    "special_price_days": specialPriceDays?.map((x) => x).toList(),
    "one_day_price": oneDayPrice,
    "weekly_discount": weeklyDiscount,
    "monthly_discount": monthlyDiscount,
    "extra_time_waiting_charge": extraTimeWaitingCharge,
    "extra_miles_charges": extraMilesCharges,
    "cancellation_policy_type": cancellationPolicyType,
    "coupons": coupons?.map((x) => x.toJson()).toList(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": version, // Map "version" back to "__v"
  };
}
class Coupon {
  Coupon({
    this.couponCode,
    this.discountType,
    this.discountValue,
    this.usageLimit,
    this.currentUsageCount,
    this.expiryDate,
    this.isGlobal,
    this.id,
  });

  final String? couponCode;
  final String? discountType;
  final int? discountValue;
  final int? usageLimit;
  final int? currentUsageCount;
  final DateTime? expiryDate;
  final bool? isGlobal;
  final String? id;

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      couponCode: json["coupon_code"],
      discountType: json["discount_type"],
      discountValue: json["discount_value"],
      usageLimit: json["usage_limit"],
      currentUsageCount: json["current_usage_count"],
      expiryDate: DateTime.tryParse(json["expiry_date"] ?? ""),
      isGlobal: json["is_global"],
      id: json["_id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "coupon_code": couponCode,
    "discount_type": discountType,
    "discount_value": discountValue,
    "usage_limit": usageLimit,
    "current_usage_count": currentUsageCount,
    "expiry_date": expiryDate?.toIso8601String(),
    "is_global": isGlobal,
    "_id": id,
  };
}
class VendorBankDetails {
  VendorBankDetails({
    this.paypalId,
  });

  final String? paypalId;

  factory VendorBankDetails.fromJson(Map<String, dynamic> json) {
    return VendorBankDetails(
      paypalId: json["paypalId"],
    );
  }

  Map<String, dynamic> toJson() => {
    "paypalId": paypalId,
  };
}
class VendorId {
  VendorId({
    this.geoLocation,
    this.id,
    this.categoryId,
    this.countryCode,
    this.mobileNo,
    this.password,
    this.otp,
    this.companyName,
    this.name,
    this.email,
    this.streetName,
    this.cityName,
    this.pincode,
    this.vehicleImage,
    this.vendorStatus,
    this.vendorActiveStatus,
    this.walletAmount,
    this.commission,
    this.offeringPrice,
    this.legalDocuments,
    this.createdAt,
    this.updatedAt,
    this.version, // Renamed from __v to version
    this.countryName,
    this.description,
    this.gender,
    this.vendorImage,
    this.vendorIdId,
  });

  final GeoLocation? geoLocation;
  final String? id;
  final String? categoryId;
  final String? countryCode;
  final String? mobileNo;
  final String? password;
  final String? otp;
  final String? companyName;
  final String? name;
  final String? email;
  final String? streetName;
  final String? cityName;
  final String? pincode;
  final List<dynamic>? vehicleImage;
  final String? vendorStatus;
  final String? vendorActiveStatus;
  final int? walletAmount;
  final int? commission;
  final int? offeringPrice;
  final List<dynamic>? legalDocuments;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? version; // Renamed field
  final String? countryName;
  final String? description;
  final String? gender;
  final String? vendorImage;
  final String? vendorIdId;

  factory VendorId.fromJson(Map<String, dynamic> json) {
    return VendorId(
      geoLocation: json["geo_location"] == null
          ? null
          : GeoLocation.fromJson(json["geo_location"]),
      id: json["_id"],
      categoryId: json["categoryId"],
      countryCode: json["country_code"],
      mobileNo: json["mobile_no"],
      password: json["password"],
      otp: json["otp"],
      companyName: json["company_name"],
      name: json["name"],
      email: json["email"],
      streetName: json["street_name"],
      cityName: json["city_name"],
      pincode: json["pincode"],
      vehicleImage: json["vehicle_image"] == null
          ? null
          : List<dynamic>.from(json["vehicle_image"]!.map((x) => x)),
      vendorStatus: json["vendor_status"],
      vendorActiveStatus: json["vendor_active_status"],
      walletAmount: json["wallet_ammount"],
      commission: json["Commission"],
      offeringPrice: json["offering_price"],
      legalDocuments: json["legal_documents"] == null
          ? null
          : List<dynamic>.from(json["legal_documents"]!.map((x) => x)),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      version: json["__v"], // Map JSON "__v" to "version"
      countryName: json["country_name"],
      description: json["description"],
      gender: json["gender"],
      vendorImage: json["vendor_image"],
      vendorIdId: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "geo_location": geoLocation?.toJson(),
    "_id": id,
    "categoryId": categoryId,
    "country_code": countryCode,
    "mobile_no": mobileNo,
    "password": password,
    "otp": otp,
    "company_name": companyName,
    "name": name,
    "email": email,
    "street_name": streetName,
    "city_name": cityName,
    "pincode": pincode,
    "vehicle_image": vehicleImage?.map((x) => x).toList(),
    "vendor_status": vendorStatus,
    "vendor_active_status": vendorActiveStatus,
    "wallet_ammount": walletAmount,
    "Commission": commission,
    "offering_price": offeringPrice,
    "legal_documents": legalDocuments?.map((x) => x).toList(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": version, // Map "version" back to "__v"
    "country_name": countryName,
    "description": description,
    "gender": gender,
    "vendor_image": vendorImage,
    "id": vendorIdId,
  };
}
class GeoLocation {
  GeoLocation({
    this.coordinates,
  });

  final List<dynamic>? coordinates; // Changed to nullable list

  factory GeoLocation.fromJson(Map<String, dynamic> json) {
    return GeoLocation(
      coordinates: json["coordinates"] == null
          ? null
          : List<dynamic>.from(json["coordinates"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "coordinates": coordinates?.map((x) => x).toList(),
  };
}