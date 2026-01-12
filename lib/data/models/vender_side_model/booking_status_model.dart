// File: lib/data/models/vender_side_model/booking_status_vendor_model.dart



class BookingStatusVendorModel {
  BookingStatusVendorModel({
    required this.bookings,
  });

  final List<Booking> bookings;

  factory BookingStatusVendorModel.fromJson(Map<String, dynamic> json) {
    return BookingStatusVendorModel(
      bookings: json["bookings"] == null
          ? []
          : List<Booking>.from(
              json["bookings"]!.map((x) => Booking.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "bookings": List<dynamic>.from(bookings.map((x) => x.toJson())),
      };
}

class Booking {
  Booking({
    this.id,
    this.userId,
    this.serviceId,
    this.listingId,
    this.confirmationCode,
    this.eventDetails,
    this.bookingStatus,
    this.paymentStatus,
    this.orderNo,
    this.cancellationPolicyType,
    this.totalAmount,
    this.createdAt,
    this.vendorId,
    this.eventDate,
    this.eventTime,
    this.eventDuration,
    this.numberOfChildren,
    this.eventType,
    this.deliveryAddress,
    this.city,
    this.postcode,
    this.setupLocation,
    this.groundSurface,
    this.powerAvailable,
    this.setupNotes,
    this.insuranceAccepted,
    this.supervisionConfirmed,
    this.safetyRulesAccepted,
    this.specialRequirements,
    this.deliveryInstructions,
    this.termsAccepted,
    this.pricingBreakdown,
    this.operatorResponse,
    this.paymentInfo,
    this.paypalOrderId,
    this.paypalTransactionId,
    this.otpVerified,
    this.isAcceptedByVendor,
    this.customerEmail,
    this.review,
    this.dispute,
    required this.communications,
    this.updatedAt,
    this.bookingReference,
    this.v,
    this.invoiceNumber,
    this.grandTotal,
    this.bookingServiceStatus,
    this.paymentCaptureId,
    this.paymentMethod,
    this.departureDate,
    this.primaryDeparturePoint,
    this.dropLocation,
    this.returnTrip,
    this.returnPickupTime,
    this.priceDetails,
    this.specialRequests,
    this.pickupAddress,
    this.dropoffAddress,
    this.journeyDate,
    this.pickupTime,
    this.bookingType,
    this.paymentDetails,
    this.commissionPrice,
    this.refundAmount,
    this.pickupLocation,
    this.distance,
    this.routeOptimized,
    this.dateOfTravel,
    this.isReturnTrip,
    this.tripType,
    this.wheelchairAccessRequired,
    this.occasionAndPurpose,
    this.termsConfirmed,
    this.privacyConfirmed,
    this.isRated,
    this.normalCommission,
    this.finalCommission,
    this.commissionWaived,
    this.commissionRate,
    this.partnerVoucherCode,
    this.voucherDiscount,
    required this.stops,
    this.departureTime,
  });

  final String? id;
  final UserId? userId;
  final dynamic serviceId; // Can be ServiceId map or ListingId object
  final ListingId? listingId;
  final String? confirmationCode;
  final EventDetails? eventDetails;

  final String? bookingStatus;           // e.g. "confirmed", "completed", "cancelled"
  final String? paymentStatus;
  final dynamic orderNo;                 // String or int
  final String? cancellationPolicyType;
  final double? totalAmount;
  final DateTime? createdAt;
  final String? vendorId;

  final DateTime? eventDate;
  final String? eventTime;
  final int? eventDuration;
  final int? numberOfChildren;
  final String? eventType;
  final String? deliveryAddress;
  final String? city;
  final String? postcode;
  final String? setupLocation;
  final String? groundSurface;
  final bool? powerAvailable;
  final String? setupNotes;
  final bool? insuranceAccepted;
  final bool? supervisionConfirmed;
  final bool? safetyRulesAccepted;
  final String? specialRequirements;
  final String? deliveryInstructions;
  final bool? termsAccepted;
  final PricingBreakdown? pricingBreakdown;

  final OperatorResponse? operatorResponse;
  final PaymentInfo? paymentInfo;
  final String? paypalOrderId;
  final String? paypalTransactionId;
  final bool? otpVerified;
  final bool? isAcceptedByVendor;
  final String? customerEmail;
  final Review? review;
  final Dispute? dispute;
  final List<dynamic> communications;
  final DateTime? updatedAt;
  final String? bookingReference;
  final int? v;

  final String? invoiceNumber;
  final double? grandTotal;
  final String? bookingServiceStatus;    // Legacy status field
  final String? paymentCaptureId;
  final String? paymentMethod;

  final DateTime? departureDate;
  final String? primaryDeparturePoint;
  final String? dropLocation;
  final bool? returnTrip;
  final String? returnPickupTime;
  final PriceDetails? priceDetails;
  final String? specialRequests;

  final String? pickupAddress;
  final String? dropoffAddress;
  final DateTime? journeyDate;
  final String? pickupTime;
  final String? bookingType;
  final PaymentDetails? paymentDetails;

  final double? commissionPrice;
  final int? refundAmount;
  final String? pickupLocation;
  final int? distance;
  final bool? routeOptimized;
  final DateTime? dateOfTravel;
  final bool? isReturnTrip;
  final String? tripType;
  final bool? wheelchairAccessRequired;
  final OccasionAndPurpose? occasionAndPurpose;

  final bool? termsConfirmed;
  final bool? privacyConfirmed;
  final bool? isRated;
  final int? normalCommission;
  final int? finalCommission;
  final int? commissionWaived;
  final int? commissionRate;
  final dynamic partnerVoucherCode;
  final int? voucherDiscount;
  final List<dynamic> stops;
  final String? departureTime;

  // === SMART GETTERS FOR UI ===
String get displayStatus {
  final raw = (bookingStatus ?? bookingServiceStatus ?? '').toLowerCase();
  if (raw == 'cancelled') return 'cancelled';
  if (raw == 'completed') return 'completed';
  return 'pending'; // Treat confirmed, Pending, etc. as pending
}

  String get displayServiceName {
    if (serviceId is Map<String, dynamic>) {
      final map = serviceId as Map<String, dynamic>;
      return map['listingTitle'] ?? map['venueName'] ?? 'Unknown Service';
    }
    if (listingId != null) {
      return listingId!.listingTitle ?? 'Unknown Service';
    }
    return 'Unknown Service';
  }

  String get displayCategory {
    if (serviceId is Map<String, dynamic>) {
      final map = serviceId as Map<String, dynamic>;
      final cat = map['categoryId'];
      if (cat is Map) return cat['category_name'] ?? '';
    }
    if (listingId?.categoryId != null) {
      return listingId!.categoryId!.categoryName ?? '';
    }
    return '';
  }

  DateTime? get displayDate {
    return eventDate ?? dateOfTravel ?? journeyDate ?? departureDate ?? createdAt;
  }

  String get displaySpecialRequest {
    final req = specialRequests ?? specialRequirements ?? '';
    return req.isEmpty ? 'N/A' : req;
  }

  double get displayAmount {
    return grandTotal ?? totalAmount ?? 0.0;
  }

  String get displayOrderNo {
    return orderNo?.toString() ?? 'N/A';
  }

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json["_id"],
      userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
      serviceId: json["serviceId"] ?? json["listingId"],
      listingId: json["listingId"] == null ? null : ListingId.fromJson(json["listingId"]),
      confirmationCode: json["confirmation_code"],
      eventDetails: json["eventDetails"] == null ? null : EventDetails.fromJson(json["eventDetails"]),
      bookingStatus: json["booking_status"],
      paymentStatus: json["payment_status"],
      orderNo: json["order_no"] ?? json["orderNo"],
      cancellationPolicyType: json["cancellation_policy_type"],
      totalAmount: _toDouble(json["totalAmount"]),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      vendorId: json["vendorId"],
      eventDate: DateTime.tryParse(json["eventDetails"]?["eventDate"] ?? json["eventDate"] ?? ""),
      eventTime: json["eventTime"] ?? json["eventDetails"]?["startTime"],
      eventDuration: json["eventDuration"],
      numberOfChildren: json["numberOfChildren"],
      eventType: json["eventType"] ?? json["eventDetails"]?["eventType"],
      deliveryAddress: json["deliveryAddress"],
      city: json["city"],
      postcode: json["postcode"],
      setupLocation: json["setupLocation"],
      groundSurface: json["groundSurface"],
      powerAvailable: json["powerAvailable"],
      setupNotes: json["setupNotes"],
      insuranceAccepted: json["insuranceAccepted"],
      supervisionConfirmed: json["supervisionConfirmed"],
      safetyRulesAccepted: json["safetyRulesAccepted"],
      specialRequirements: json["specialRequirements"] ?? json["eventDetails"]?["specialRequirements"],
      deliveryInstructions: json["deliveryInstructions"],
      termsAccepted: json["termsAccepted"],
      pricingBreakdown: json["pricingBreakdown"] == null ? null : PricingBreakdown.fromJson(json["pricingBreakdown"]),
      operatorResponse: json["operatorResponse"] == null ? null : OperatorResponse.fromJson(json["operatorResponse"]),
      paymentInfo: json["paymentInfo"] == null ? null : PaymentInfo.fromJson(json["paymentInfo"]),
      paypalOrderId: json["paypal_order_id"],
      paypalTransactionId: json["paypal_transaction_id"],
      otpVerified: json["otpVerified"],
      isAcceptedByVendor: json["isAcceptedByVendor"],
      customerEmail: json["customerEmail"],
      review: json["review"] == null ? null : Review.fromJson(json["review"]),
      dispute: json["dispute"] == null ? null : Dispute.fromJson(json["dispute"]),
      communications: json["communications"] == null ? [] : List<dynamic>.from(json["communications"]!.map((x) => x)),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      bookingReference: json["bookingReference"],
      v: json["__v"],
      invoiceNumber: json["invoiceNumber"],
      grandTotal: _toDouble(json["grand_total"]),
      bookingServiceStatus: json["booking_service_status"],
      paymentCaptureId: json["payment_capture_id"],
      paymentMethod: json["payment_method"],
      departureDate: DateTime.tryParse(json["departure_date"] ?? ""),
      primaryDeparturePoint: json["primary_departure_point"],
      dropLocation: json["drop_location"],
      returnTrip: json["return_trip"],
      returnPickupTime: json["return_pickup_time"],
      priceDetails: json["price_details"] == null ? null : PriceDetails.fromJson(json["price_details"]),
      specialRequests: json["special_requests"],
      pickupAddress: json["pickup_address"],
      dropoffAddress: json["dropoff_address"],
      journeyDate: DateTime.tryParse(json["journey_date"] ?? ""),
      pickupTime: json["pickup_time"],
      bookingType: json["booking_type"],
      paymentDetails: json["payment_details"] == null ? null : PaymentDetails.fromJson(json["payment_details"]),
      commissionPrice: _toDouble(json["commission_price"]),
      refundAmount: json["refund_amount"],
      pickupLocation: json["pickup_location"],
      distance: json["distance"],
      routeOptimized: json["routeOptimized"],
      dateOfTravel: DateTime.tryParse(json["dateOfTravel"] ?? ""),
      isReturnTrip: json["isReturnTrip"],
      tripType: json["tripType"],
      wheelchairAccessRequired: json["wheelchairAccessRequired"],
      occasionAndPurpose: json["occasionAndPurpose"] == null ? null : OccasionAndPurpose.fromJson(json["occasionAndPurpose"]),
      termsConfirmed: json["terms_confirmed"],
      privacyConfirmed: json["privacy_confirmed"],
      isRated: json["isRated"],
      normalCommission: json["normalCommission"],
      finalCommission: json["finalCommission"],
      commissionWaived: json["commissionWaived"],
      commissionRate: json["commissionRate"],
      partnerVoucherCode: json["partnerVoucherCode"],
      voucherDiscount: json["voucherDiscount"],
      stops: json["stops"] == null ? [] : List<dynamic>.from(json["stops"]!.map((x) => x)),
      departureTime: json["departure_time"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId?.toJson(),
        "serviceId": serviceId is Map ? serviceId : null,
        "listingId": listingId?.toJson(),
        "confirmation_code": confirmationCode,
        "eventDetails": eventDetails?.toJson(),
        "booking_status": bookingStatus,
        "payment_status": paymentStatus,
        "order_no": orderNo,
        "cancellation_policy_type": cancellationPolicyType,
        "totalAmount": totalAmount,
        "createdAt": createdAt?.toIso8601String(),
        "vendorId": vendorId,
        "eventDate": eventDate?.toIso8601String(),
        "eventTime": eventTime,
        "eventDuration": eventDuration,
        "numberOfChildren": numberOfChildren,
        "eventType": eventType,
        "deliveryAddress": deliveryAddress,
        "city": city,
        "postcode": postcode,
        "setupLocation": setupLocation,
        "groundSurface": groundSurface,
        "powerAvailable": powerAvailable,
        "setupNotes": setupNotes,
        "insuranceAccepted": insuranceAccepted,
        "supervisionConfirmed": supervisionConfirmed,
        "safetyRulesAccepted": safetyRulesAccepted,
        "specialRequirements": specialRequirements,
        "deliveryInstructions": deliveryInstructions,
        "termsAccepted": termsAccepted,
        "pricingBreakdown": pricingBreakdown?.toJson(),
        "operatorResponse": operatorResponse?.toJson(),
        "paymentInfo": paymentInfo?.toJson(),
        "paypal_order_id": paypalOrderId,
        "paypal_transaction_id": paypalTransactionId,
        "otpVerified": otpVerified,
        "isAcceptedByVendor": isAcceptedByVendor,
        "customerEmail": customerEmail,
        "review": review?.toJson(),
        "dispute": dispute?.toJson(),
        "communications": List<dynamic>.from(communications.map((x) => x)),
        "updatedAt": updatedAt?.toIso8601String(),
        "bookingReference": bookingReference,
        "__v": v,
        "invoiceNumber": invoiceNumber,
        "grand_total": grandTotal,
        "booking_service_status": bookingServiceStatus,
        "payment_capture_id": paymentCaptureId,
        "payment_method": paymentMethod,
        "departure_date": departureDate?.toIso8601String(),
        "primary_departure_point": primaryDeparturePoint,
        "drop_location": dropLocation,
        "return_trip": returnTrip,
        "return_pickup_time": returnPickupTime,
        "price_details": priceDetails?.toJson(),
        "special_requests": specialRequests,
        "pickup_address": pickupAddress,
        "dropoff_address": dropoffAddress,
        "journey_date": journeyDate?.toIso8601String(),
        "pickup_time": pickupTime,
        "booking_type": bookingType,
        "payment_details": paymentDetails?.toJson(),
        "commission_price": commissionPrice,
        "refund_amount": refundAmount,
        "pickup_location": pickupLocation,
        "distance": distance,
        "routeOptimized": routeOptimized,
        "dateOfTravel": dateOfTravel?.toIso8601String(),
        "isReturnTrip": isReturnTrip,
        "tripType": tripType,
        "wheelchairAccessRequired": wheelchairAccessRequired,
        "occasionAndPurpose": occasionAndPurpose?.toJson(),
        "terms_confirmed": termsConfirmed,
        "privacy_confirmed": privacyConfirmed,
        "isRated": isRated,
        "normalCommission": normalCommission,
        "finalCommission": finalCommission,
        "commissionWaived": commissionWaived,
        "commissionRate": commissionRate,
        "partnerVoucherCode": partnerVoucherCode,
        "voucherDiscount": voucherDiscount,
        "stops": List<dynamic>.from(stops.map((x) => x)),
        "departure_time": departureTime,
      };
}

// Helper function for safe double conversion
double? _toDouble(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

// All sub-models below (unchanged from your original, but included fully)

class UserId {
  UserId({
    this.id,
    this.countryCode,
    this.mobileNo,
    this.firstName,
    this.lastName,
    this.email,
  });

  final String? id;
  final String? countryCode;
  final String? mobileNo;
  final String? firstName;
  final String? lastName;
  final String? email;

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"],
        countryCode: json["country_code"],
        mobileNo: json["mobile_no"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "country_code": countryCode,
        "mobile_no": mobileNo,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
      };
}

class ListingId {
  ListingId({
    this.id,
    this.vendorId,
    this.categoryId,
    this.listingTitle,
    this.serviceImage,
    this.businessInfo,
    this.equipmentSelection,
  });

  final String? id;
  final VendorId? vendorId;
  final CategoryId? categoryId;
  final String? listingTitle;
  final List<String>? serviceImage;
  final BusinessInfo? businessInfo;
  final EquipmentSelection? equipmentSelection;

  factory ListingId.fromJson(Map<String, dynamic> json) => ListingId(
        id: json["_id"],
        vendorId: json["vendorId"] == null ? null : VendorId.fromJson(json["vendorId"]),
        categoryId: json["categoryId"] == null ? null : CategoryId.fromJson(json["categoryId"]),
        listingTitle: json["listingTitle"],
        serviceImage: json["service_image"] == null ? null : List<String>.from(json["service_image"]!.map((x) => x)),
        businessInfo: json["businessInfo"] == null ? null : BusinessInfo.fromJson(json["businessInfo"]),
        equipmentSelection: json["equipmentSelection"] == null ? null : EquipmentSelection.fromJson(json["equipmentSelection"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "vendorId": vendorId?.toJson(),
        "categoryId": categoryId?.toJson(),
        "listingTitle": listingTitle,
        "service_image": serviceImage == null ? null : List<dynamic>.from(serviceImage!.map((x) => x)),
        "businessInfo": businessInfo?.toJson(),
        "equipmentSelection": equipmentSelection?.toJson(),
      };
}

class VendorId {
  VendorId({
    this.id,
    this.name,
    this.companyName,
  });

  final String? id;
  final String? name;
  final String? companyName;

  factory VendorId.fromJson(Map<String, dynamic> json) => VendorId(
        id: json["_id"],
        name: json["name"],
        companyName: json["company_name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "company_name": companyName,
      };
}

class CategoryId {
  CategoryId({
    this.id,
    this.categoryName,
  });

  final String? id;
  final String? categoryName;

  factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
        id: json["_id"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "category_name": categoryName,
      };
}

class BusinessInfo {
  BusinessInfo({
    this.businessName,
    this.baseLocationPostcode,
    this.serviceRadius,
    this.yearsInOperation,
    this.contactPerson,
    this.coordinates,
  });

  final String? businessName;
  final String? baseLocationPostcode;
  final int? serviceRadius;
  final int? yearsInOperation;
  final ContactPerson? contactPerson;
  final Coordinates? coordinates;

  factory BusinessInfo.fromJson(Map<String, dynamic> json) => BusinessInfo(
        businessName: json["businessName"],
        baseLocationPostcode: json["baseLocationPostcode"],
        serviceRadius: json["serviceRadius"],
        yearsInOperation: json["yearsInOperation"],
        contactPerson: json["contactPerson"] == null ? null : ContactPerson.fromJson(json["contactPerson"]),
        coordinates: json["coordinates"] == null ? null : Coordinates.fromJson(json["coordinates"]),
      );

  Map<String, dynamic> toJson() => {
        "businessName": businessName,
        "baseLocationPostcode": baseLocationPostcode,
        "serviceRadius": serviceRadius,
        "yearsInOperation": yearsInOperation,
        "contactPerson": contactPerson?.toJson(),
        "coordinates": coordinates?.toJson(),
      };
}

class ContactPerson {
  ContactPerson({
    this.name,
    this.email,
    this.phone,
  });

  final String? name;
  final String? email;
  final String? phone;

  factory ContactPerson.fromJson(Map<String, dynamic> json) => ContactPerson(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
      };
}

class Coordinates {
  Coordinates({
    this.type,
    this.coordinates,
  });

  final String? type;
  final List<int>? coordinates;

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        type: json["type"],
        coordinates: json["coordinates"] == null ? null : List<int>.from(json["coordinates"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates == null ? null : List<dynamic>.from(coordinates!.map((x) => x)),
      };
}

class EquipmentSelection {
  EquipmentSelection({
    this.inflatableType,
    this.name,
    this.description,
    this.ageGroup,
    this.capacity,
    this.minAge,
    this.maxAge,
    this.theme,
  });

  final String? inflatableType;
  final String? name;
  final String? description;
  final String? ageGroup;
  final Capacity? capacity;
  final int? minAge;
  final int? maxAge;
  final String? theme;

  factory EquipmentSelection.fromJson(Map<String, dynamic> json) => EquipmentSelection(
        inflatableType: json["inflatableType"],
        name: json["name"],
        description: json["description"],
        ageGroup: json["ageGroup"],
        capacity: json["capacity"] == null ? null : Capacity.fromJson(json["capacity"]),
        minAge: json["minAge"],
        maxAge: json["maxAge"],
        theme: json["theme"],
      );

  Map<String, dynamic> toJson() => {
        "inflatableType": inflatableType,
        "name": name,
        "description": description,
        "ageGroup": ageGroup,
        "capacity": capacity?.toJson(),
        "minAge": minAge,
        "maxAge": maxAge,
        "theme": theme,
      };
}

class Capacity {
  Capacity({
    this.maximum,
    this.recommended,
  });

  final int? maximum;
  final int? recommended;

  factory Capacity.fromJson(Map<String, dynamic> json) => Capacity(
        maximum: json["maximum"],
        recommended: json["recommended"],
      );

  Map<String, dynamic> toJson() => {
        "maximum": maximum,
        "recommended": recommended,
      };
}

class EventDetails {
  EventDetails({
    this.eventDate,
    this.startTime,
    this.endTime,
    this.guestCount,
    this.eventType,
    this.specialRequirements,
  });

  final DateTime? eventDate;
  final String? startTime;
  final String? endTime;
  final int? guestCount;
  final String? eventType;
  final String? specialRequirements;

  factory EventDetails.fromJson(Map<String, dynamic> json) => EventDetails(
        eventDate: DateTime.tryParse(json["eventDate"] ?? ""),
        startTime: json["startTime"],
        endTime: json["endTime"],
        guestCount: json["guestCount"],
        eventType: json["eventType"],
        specialRequirements: json["specialRequirements"],
      );

  Map<String, dynamic> toJson() => {
        "eventDate": eventDate?.toIso8601String(),
        "startTime": startTime,
        "endTime": endTime,
        "guestCount": guestCount,
        "eventType": eventType,
        "specialRequirements": specialRequirements,
      };
}

class PricingBreakdown {
  PricingBreakdown({
    this.basePrice,
    this.weekendSurcharge,
    this.deliveryFee,
    this.setupFee,
    this.cleaningFee,
    this.subtotal,
    this.totalAmount,
  });

  final int? basePrice;
  final int? weekendSurcharge;
  final int? deliveryFee;
  final int? setupFee;
  final int? cleaningFee;
  final int? subtotal;
  final int? totalAmount;

  factory PricingBreakdown.fromJson(Map<String, dynamic> json) => PricingBreakdown(
        basePrice: json["basePrice"],
        weekendSurcharge: json["weekendSurcharge"],
        deliveryFee: json["deliveryFee"],
        setupFee: json["setupFee"],
        cleaningFee: json["cleaningFee"],
        subtotal: json["subtotal"],
        totalAmount: json["totalAmount"],
      );

  Map<String, dynamic> toJson() => {
        "basePrice": basePrice,
        "weekendSurcharge": weekendSurcharge,
        "deliveryFee": deliveryFee,
        "setupFee": setupFee,
        "cleaningFee": cleaningFee,
        "subtotal": subtotal,
        "totalAmount": totalAmount,
      };
}

class OperatorResponse {
  OperatorResponse({
    this.status,
  });

  final String? status;

  factory OperatorResponse.fromJson(Map<String, dynamic> json) => OperatorResponse(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}

class PaymentInfo {
  PaymentInfo({
    this.finalPaymentTransaction,
    this.depositTransaction,
    required this.refundTransactions,
  });

  final FinalPaymentTransaction? finalPaymentTransaction;
  final DepositTransaction? depositTransaction;
  final List<dynamic> refundTransactions;

  factory PaymentInfo.fromJson(Map<String, dynamic> json) => PaymentInfo(
        finalPaymentTransaction: json["finalPaymentTransaction"] == null ? null : FinalPaymentTransaction.fromJson(json["finalPaymentTransaction"]),
        depositTransaction: json["depositTransaction"] == null ? null : DepositTransaction.fromJson(json["depositTransaction"]),
        refundTransactions: json["refundTransactions"] == null ? [] : List<dynamic>.from(json["refundTransactions"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "finalPaymentTransaction": finalPaymentTransaction?.toJson(),
        "depositTransaction": depositTransaction?.toJson(),
        "refundTransactions": List<dynamic>.from(refundTransactions.map((x) => x)),
      };
}

class FinalPaymentTransaction {
  FinalPaymentTransaction({
    this.transactionId,
    this.paymentMethod,
    this.paidAt,
    this.amount,
    this.paypalOrderId,
    this.paypalCaptureId,
  });

  final String? transactionId;
  final String? paymentMethod;
  final DateTime? paidAt;
  final int? amount;
  final String? paypalOrderId;
  final String? paypalCaptureId;

  factory FinalPaymentTransaction.fromJson(Map<String, dynamic> json) => FinalPaymentTransaction(
        transactionId: json["transactionId"],
        paymentMethod: json["paymentMethod"],
        paidAt: DateTime.tryParse(json["paidAt"] ?? ""),
        amount: json["amount"],
        paypalOrderId: json["paypalOrderId"],
        paypalCaptureId: json["paypalCaptureId"],
      );

  Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
        "paymentMethod": paymentMethod,
        "paidAt": paidAt?.toIso8601String(),
        "amount": amount,
        "paypalOrderId": paypalOrderId,
        "paypalCaptureId": paypalCaptureId,
      };
}

class DepositTransaction {
  DepositTransaction({
    this.paymentMethod,
  });

  final String? paymentMethod;

  factory DepositTransaction.fromJson(Map<String, dynamic> json) => DepositTransaction(
        paymentMethod: json["paymentMethod"],
      );

  Map<String, dynamic> toJson() => {
        "paymentMethod": paymentMethod,
      };
}

class PriceDetails {
  PriceDetails({
    this.basePrice,
    this.totalPrice,
    this.extrasPrice,
    this.tripDays,
    this.mileageOverage,
    required this.accessibilityBreakdown,
    required this.eventsBreakdown,
  });

  final double? basePrice;
  final double? totalPrice;
  final int? extrasPrice;
  final int? tripDays;
  final MileageOverage? mileageOverage;
  final List<dynamic> accessibilityBreakdown;
  final List<dynamic> eventsBreakdown;

  factory PriceDetails.fromJson(Map<String, dynamic> json) => PriceDetails(
        basePrice: _toDouble(json["basePrice"]),
        totalPrice: _toDouble(json["totalPrice"]),
        extrasPrice: json["extrasPrice"],
        tripDays: json["tripDays"],
        mileageOverage: json["mileageOverage"] == null ? null : MileageOverage.fromJson(json["mileageOverage"]),
        accessibilityBreakdown: json["accessibilityBreakdown"] == null ? [] : List<dynamic>.from(json["accessibilityBreakdown"]!.map((x) => x)),
        eventsBreakdown: json["eventsBreakdown"] == null ? [] : List<dynamic>.from(json["eventsBreakdown"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "basePrice": basePrice,
        "totalPrice": totalPrice,
        "extrasPrice": extrasPrice,
        "tripDays": tripDays,
        "mileageOverage": mileageOverage?.toJson(),
        "accessibilityBreakdown": List<dynamic>.from(accessibilityBreakdown.map((x) => x)),
        "eventsBreakdown": List<dynamic>.from(eventsBreakdown.map((x) => x)),
      };
}

class MileageOverage {
  MileageOverage({
    this.extraMiles,
    this.ratePerMile,
    this.totalOverageCharge,
  });

  final int? extraMiles;
  final int? ratePerMile;
  final int? totalOverageCharge;

  factory MileageOverage.fromJson(Map<String, dynamic> json) => MileageOverage(
        extraMiles: json["extraMiles"],
        ratePerMile: json["ratePerMile"],
        totalOverageCharge: json["totalOverageCharge"],
      );

  Map<String, dynamic> toJson() => {
        "extraMiles": extraMiles,
        "ratePerMile": ratePerMile,
        "totalOverageCharge": totalOverageCharge,
      };
}

class Review {
  Review({
    this.submitted,
  });

  final bool? submitted;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        submitted: json["submitted"],
      );

  Map<String, dynamic> toJson() => {
        "submitted": submitted,
      };
}

class Dispute {
  Dispute({
    this.isDisputed,
  });

  final bool? isDisputed;

  factory Dispute.fromJson(Map<String, dynamic> json) => Dispute(
        isDisputed: json["isDisputed"],
      );

  Map<String, dynamic> toJson() => {
        "isDisputed": isDisputed,
      };
}

class PaymentDetails {
  PaymentDetails({
    this.paymentId,
    this.paymentMethod,
    this.paymentDate,
    this.transactionId,
  });

  final String? paymentId;
  final String? paymentMethod;
  final DateTime? paymentDate;
  final String? transactionId;

  factory PaymentDetails.fromJson(Map<String, dynamic> json) => PaymentDetails(
        paymentId: json["paymentId"],
        paymentMethod: json["paymentMethod"],
        paymentDate: DateTime.tryParse(json["paymentDate"] ?? ""),
        transactionId: json["transactionId"],
      );

  Map<String, dynamic> toJson() => {
        "paymentId": paymentId,
        "paymentMethod": paymentMethod,
        "paymentDate": paymentDate?.toIso8601String(),
        "transactionId": transactionId,
      };
}

class OccasionAndPurpose {
  OccasionAndPurpose({
    this.schoolTrip,
    this.corporateEvent,
    this.weddingParty,
    this.airportTransfer,
    this.sportsTeam,
    this.dayTour,
    this.other,
  });

  final bool? schoolTrip;
  final bool? corporateEvent;
  final bool? weddingParty;
  final bool? airportTransfer;
  final bool? sportsTeam;
  final bool? dayTour;
  final bool? other;

  factory OccasionAndPurpose.fromJson(Map<String, dynamic> json) => OccasionAndPurpose(
        schoolTrip: json["schoolTrip"],
        corporateEvent: json["corporateEvent"],
        weddingParty: json["weddingParty"],
        airportTransfer: json["airportTransfer"],
        sportsTeam: json["sportsTeam"],
        dayTour: json["dayTour"],
        other: json["other"],
      );

  Map<String, dynamic> toJson() => {
        "schoolTrip": schoolTrip,
        "corporateEvent": corporateEvent,
        "weddingParty": weddingParty,
        "airportTransfer": airportTransfer,
        "sportsTeam": sportsTeam,
        "dayTour": dayTour,
        "other": other,
      };
}