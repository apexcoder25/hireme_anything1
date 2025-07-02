class BookingDetails {
  BookingDetails({
    required this.id,
    required this.userId,
    required this.vendorId,
    required this.serviceId,
    required this.invoiceNumber,
    required this.grandTotal,
    required this.paypalOrderId,
    required this.confirmationCode,
    required this.otp,
    required this.cancellationPolicyType,
    required this.bookingServiceStatus,
    required this.bookingDetailBookingStatus,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.bookingDetailRefundAmount,
    required this.bookingDetailPickupTime,
    required this.pickupLocation,
    required this.dropLocation,
    required this.distance,
    required this.dateOfTravel,
    required this.isReturnTrip,
    required this.tripType,
    required this.wheelchairAccessRequired,
    required this.occasionAndPurpose,
    required this.priceDetails,
    required this.termsConfirmed,
    required this.privacyConfirmed,
    required this.bookingDetailSpecialRequests,
    required this.orderNo,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isRated,
    required this.paymentCaptureId,
    required this.bookingDetailRefundTransaction,
    required this.pickupAddress,
    required this.dropoffAddress,
    required this.journeyDate,
    required this.pickupTime,
    required this.occasionPurpose,
    required this.additionalServices,
    required this.accessibilityServices,
    required this.status,
    required this.departureDate,
    required this.departureTime,
    required this.primaryDeparturePoint,
    required this.returnTrip,
    required this.returnPickupTime,
    required this.boatType,
    required this.otherBoatTypeDescription,
    required this.numberOfGuests,
    required this.typicalUse,
    required this.otherTypicalUse,
    required this.rentalDuration,
    required this.bookingDetailPickupAddress,
    required this.bookingDetailDropoffAddress,
    required this.bookingDetailJourneyDate,
    required this.bookingType,
    required this.occasions,
    required this.extras,
    required this.accessibility,
    required this.isChauffeurBooking,
    required this.refundAmount,
    required this.refundTransaction,
    required this.paymentId,
    required this.funeralVehicleTypes,
    required this.floralServiceRequired,
    required this.carriageType,
    required this.horseColourPreference,
    required this.numberOfPassengers,
    required this.extrasAndServices,
    required this.specialRequests,
    required this.bookingStatus,
  });

  final String? id;
  final String? userId;
  final VendorId? vendorId;
  final ServiceId? serviceId;
  final String? invoiceNumber;
  final double? grandTotal;
  final String? paypalOrderId;
  final String? confirmationCode;
  final int? otp;
  final String? cancellationPolicyType;
  final String? bookingServiceStatus;
  final String? bookingDetailBookingStatus;
  final String? paymentStatus;
  final String? paymentMethod;
  final double? bookingDetailRefundAmount;
  final String? bookingDetailPickupTime;
  final String? pickupLocation;
  final String? dropLocation;
  final double? distance;
  final DateTime? dateOfTravel;
  final bool? isReturnTrip;
  final String? tripType;
  final bool? wheelchairAccessRequired;
  final OccasionAndPurpose? occasionAndPurpose;
  final PriceDetails? priceDetails;
  final bool? termsConfirmed;
  final bool? privacyConfirmed;
  final String? bookingDetailSpecialRequests;
  final dynamic? orderNo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final bool? isRated;
  final String? paymentCaptureId;
  final String? bookingDetailRefundTransaction;
  final String? pickupAddress;
  final String? dropoffAddress;
  final DateTime? journeyDate;
  final String? pickupTime;
  final List<dynamic> occasionPurpose;
  final List<dynamic> additionalServices;
  final List<dynamic> accessibilityServices;
  final String? status;
  final DateTime? departureDate;
  final String? departureTime;
  final String? primaryDeparturePoint;
  final bool? returnTrip;
  final String? returnPickupTime;
  final String? boatType;
  final String? otherBoatTypeDescription;
  final int? numberOfGuests;
  final List<String> typicalUse;
  final String? otherTypicalUse;
  final String? rentalDuration;
  final String? bookingDetailPickupAddress;
  final String? bookingDetailDropoffAddress;
  final DateTime? bookingDetailJourneyDate;
  final String? bookingType;
  final String? occasions;
  final Extras? extras;
  final Map<String, bool> accessibility;
  final bool? isChauffeurBooking;
  final double? refundAmount;
  final String? refundTransaction;
  final String? paymentId;
  final String? funeralVehicleTypes;
  final bool? floralServiceRequired;
  final String? carriageType;
  final String? horseColourPreference;
  final int? numberOfPassengers;
  final ExtrasAndServices? extrasAndServices;
  final SpecialRequests? specialRequests;
  final String? bookingStatus;
factory BookingDetails.fromJson(Map<String, dynamic> json) {
    print("JSON Data: $json"); // Debug: Log the full JSON to identify the problematic field
    return BookingDetails(
      id: json["_id"],
      userId: json["userId"],
      vendorId: json["vendorId"] != null ? VendorId.fromJson(json["vendorId"]) : null,
      serviceId: json["serviceId"] != null ? ServiceId.fromJson(json["serviceId"]) : null,
      invoiceNumber: json["invoiceNumber"],
      grandTotal: (json["grand_total"] as num?)?.toDouble(),
      paypalOrderId: json["paypal_order_id"],
      confirmationCode: json["confirmation_code"],
      otp: json["otp"],
      cancellationPolicyType: json["cancellation_policy_type"],
      bookingServiceStatus: json["booking_service_status"],
      bookingDetailBookingStatus: json["booking_status"],
      paymentStatus: json["payment_status"],
      paymentMethod: json["payment_method"],
      bookingDetailRefundAmount: (json["refund_amount"] as num?)?.toDouble(),
      bookingDetailPickupTime: json["pickup_time"],
      pickupLocation: json["pickup_location"],
      dropLocation: json["drop_location"],
      distance: (json["distance"] as num?)?.toDouble(),
      dateOfTravel: DateTime.tryParse(json["dateOfTravel"] ?? ""),
      isReturnTrip: json["isReturnTrip"],
      tripType: json["tripType"],
      wheelchairAccessRequired: json["wheelchairAccessRequired"],
      occasionAndPurpose: json["occasionAndPurpose"] != null ? OccasionAndPurpose.fromJson(json["occasionAndPurpose"]) : null,
      priceDetails: json["price_details"] != null ? PriceDetails.fromJson(json["price_details"]) : null,
      termsConfirmed: json["terms_confirmed"],
      privacyConfirmed: json["privacy_confirmed"],
      bookingDetailSpecialRequests: json["special_requests"],
      orderNo: json["order_no"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      isRated: json["isRated"],
      paymentCaptureId: json["payment_capture_id"],
      bookingDetailRefundTransaction: json["refund_transaction"],
      pickupAddress: json["pickupAddress"],
      dropoffAddress: json["dropoffAddress"],
      journeyDate: DateTime.tryParse(json["journeyDate"] ?? ""),
      pickupTime: json["pickupTime"],
      occasionPurpose: json["occasionPurpose"] == null ? [] : List<dynamic>.from(json["occasionPurpose"]!.map((x) => x)),
      additionalServices: json["additionalServices"] == null ? [] : List<dynamic>.from(json["additionalServices"]!.map((x) => x)),
      accessibilityServices: json["accessibilityServices"] == null ? [] : List<dynamic>.from(json["accessibilityServices"]!.map((x) => x)),
      status: json["status"],
      departureDate: DateTime.tryParse(json["departure_date"] ?? ""),
      departureTime: json["departure_time"],
      primaryDeparturePoint: json["primary_departure_point"],
      returnTrip: json["return_trip"],
      returnPickupTime: json["return_pickup_time"],
      boatType: json["boatType"],
      otherBoatTypeDescription: json["otherBoatTypeDescription"],
      numberOfGuests: json["numberOfGuests"],
      typicalUse: json["typicalUse"] == null ? [] : List<String>.from(json["typicalUse"]!.map((x) => x)),
      otherTypicalUse: json["otherTypicalUse"],
      rentalDuration: json["rentalDuration"],
      bookingDetailPickupAddress: json["pickup_address"],
      bookingDetailDropoffAddress: json["dropoff_address"],
      bookingDetailJourneyDate: DateTime.tryParse(json["journey_date"] ?? ""),
      bookingType: json["booking_type"],
      occasions: json["occasions"],
      extras: json["extras"] != null ? Extras.fromJson(json["extras"]) : null,
      accessibility: json["accessibility"] != null ? Map.from(json["accessibility"]).map((k, v) => MapEntry<String, bool>(k, v)) : {},
      isChauffeurBooking: json["isChauffeurBooking"],
      refundAmount: (json["refundAmount"] as num?)?.toDouble(),
      refundTransaction: json["refundTransaction"],
      paymentId: json["paymentId"],
      funeralVehicleTypes: json["funeralVehicleTypes"],
      floralServiceRequired: json["floralServiceRequired"],
      carriageType: json["carriageType"],
      horseColourPreference: json["horseColourPreference"],
      numberOfPassengers: json["numberOfPassengers"],
      extrasAndServices: json["extrasAndServices"] != null ? ExtrasAndServices.fromJson(json["extrasAndServices"]) : null,
      specialRequests: json["specialRequests"] != null ? SpecialRequests.fromJson(json["specialRequests"]) : null,
      bookingStatus: json["bookingStatus"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "vendorId": vendorId?.toJson(),
    "serviceId": serviceId?.toJson(),
    "invoiceNumber": invoiceNumber,
    "grand_total": grandTotal,
    "paypal_order_id": paypalOrderId,
    "confirmation_code": confirmationCode,
    "otp": otp,
    "cancellation_policy_type": cancellationPolicyType,
    "booking_service_status": bookingServiceStatus,
    "booking_status": bookingDetailBookingStatus,
    "payment_status": paymentStatus,
    "payment_method": paymentMethod,
    "refund_amount": bookingDetailRefundAmount,
    "pickup_time": bookingDetailPickupTime,
    "pickup_location": pickupLocation,
    "drop_location": dropLocation,
    "distance": distance,
    "dateOfTravel": dateOfTravel?.toIso8601String(),
    "isReturnTrip": isReturnTrip,
    "tripType": tripType,
    "wheelchairAccessRequired": wheelchairAccessRequired,
    "occasionAndPurpose": occasionAndPurpose?.toJson(),
    "price_details": priceDetails?.toJson(),
    "terms_confirmed": termsConfirmed,
    "privacy_confirmed": privacyConfirmed,
    "special_requests": bookingDetailSpecialRequests,
    "order_no": orderNo,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "isRated": isRated,
    "payment_capture_id": paymentCaptureId,
    "refund_transaction": bookingDetailRefundTransaction,
    "pickupAddress": pickupAddress,
    "dropoffAddress": dropoffAddress,
    "journeyDate": journeyDate?.toIso8601String(),
    "pickupTime": pickupTime,
    "occasionPurpose": occasionPurpose.map((x) => x).toList(),
    "additionalServices": additionalServices.map((x) => x).toList(),
    "accessibilityServices": accessibilityServices.map((x) => x).toList(),
    "status": status,
    "departure_date": departureDate?.toIso8601String(),
    "departure_time": departureTime,
    "primary_departure_point": primaryDeparturePoint,
    "return_trip": returnTrip,
    "return_pickup_time": returnPickupTime,
    "boatType": boatType,
    "otherBoatTypeDescription": otherBoatTypeDescription,
    "numberOfGuests": numberOfGuests,
    "typicalUse": typicalUse.map((x) => x).toList(),
    "otherTypicalUse": otherTypicalUse,
    "rentalDuration": rentalDuration,
    "pickup_address": bookingDetailPickupAddress,
    "dropoff_address": bookingDetailDropoffAddress,
    "journey_date": bookingDetailJourneyDate?.toIso8601String(),
    "booking_type": bookingType,
    "occasions": occasions,
    "extras": extras?.toJson(),
    "accessibility": Map.from(accessibility).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "isChauffeurBooking": isChauffeurBooking,
    "refundAmount": refundAmount,
    "refundTransaction": refundTransaction,
    "paymentId": paymentId,
    "funeralVehicleTypes": funeralVehicleTypes,
    "floralServiceRequired": floralServiceRequired,
    "carriageType": carriageType,
    "horseColourPreference": horseColourPreference,
    "numberOfPassengers": numberOfPassengers,
    "extrasAndServices": extrasAndServices?.toJson(),
    "specialRequests": specialRequests?.toJson(),
    "bookingStatus": bookingStatus,
  };
}

class Extras {
    Extras({
        required this.weddingDecor,
        required this.partyLightingSystem,
        required this.champagnePackages,
        required this.photographyPackages,
    });

    final bool? weddingDecor;
    final bool? partyLightingSystem;
    final bool? champagnePackages;
    final bool? photographyPackages;

    factory Extras.fromJson(Map<String, dynamic> json){ 
        return Extras(
            weddingDecor: json["weddingDecor"],
            partyLightingSystem: json["partyLightingSystem"],
            champagnePackages: json["champagnePackages"],
            photographyPackages: json["photographyPackages"],
        );
    }

    Map<String, dynamic> toJson() => {
        "weddingDecor": weddingDecor,
        "partyLightingSystem": partyLightingSystem,
        "champagnePackages": champagnePackages,
        "photographyPackages": photographyPackages,
    };

}

class ExtrasAndServices {
    ExtrasAndServices({
        required this.lanternsLighting,
        required this.liveMusic,
        required this.redCarpetService,
        required this.groomsAttendant,
        required this.photographyPackage,
        required this.accessibilityAssistance,
        required this.floralDecor,
        required this.refreshmentService,
    });

    final bool? lanternsLighting;
    final bool? liveMusic;
    final bool? redCarpetService;
    final bool? groomsAttendant;
    final bool? photographyPackage;
    final bool? accessibilityAssistance;
    final bool? floralDecor;
    final bool? refreshmentService;

    factory ExtrasAndServices.fromJson(Map<String, dynamic> json){ 
        return ExtrasAndServices(
            lanternsLighting: json["lanternsLighting"],
            liveMusic: json["liveMusic"],
            redCarpetService: json["redCarpetService"],
            groomsAttendant: json["groomsAttendant"],
            photographyPackage: json["photographyPackage"],
            accessibilityAssistance: json["accessibilityAssistance"],
            floralDecor: json["floralDecor"],
            refreshmentService: json["refreshmentService"],
        );
    }

    Map<String, dynamic> toJson() => {
        "lanternsLighting": lanternsLighting,
        "liveMusic": liveMusic,
        "redCarpetService": redCarpetService,
        "groomsAttendant": groomsAttendant,
        "photographyPackage": photographyPackage,
        "accessibilityAssistance": accessibilityAssistance,
        "floralDecor": floralDecor,
        "refreshmentService": refreshmentService,
    };

}

class OccasionAndPurpose {
    OccasionAndPurpose({
        required this.schoolTrip,
        required this.corporateEvent,
        required this.weddingParty,
        required this.airportTransfer,
        required this.sportsTeam,
        required this.dayTour,
        required this.other,
        required this.otherSpecified,
        required this.wedding,
        required this.prom,
        required this.culturalCeremony,
        required this.filmShoot,
        required this.photoshoot,
    });

    final bool? schoolTrip;
    final bool? corporateEvent;
    final bool? weddingParty;
    final bool? airportTransfer;
    final bool? sportsTeam;
    final bool? dayTour;
    final bool? other;
    final String? otherSpecified;
    final bool? wedding;
    final bool? prom;
    final bool? culturalCeremony;
    final bool? filmShoot;
    final bool? photoshoot;

    factory OccasionAndPurpose.fromJson(Map<String, dynamic> json){ 
        return OccasionAndPurpose(
            schoolTrip: json["schoolTrip"],
            corporateEvent: json["corporateEvent"],
            weddingParty: json["weddingParty"],
            airportTransfer: json["airportTransfer"],
            sportsTeam: json["sportsTeam"],
            dayTour: json["dayTour"],
            other: json["other"],
            otherSpecified: json["otherSpecified"],
            wedding: json["wedding"],
            prom: json["prom"],
            culturalCeremony: json["culturalCeremony"],
            filmShoot: json["filmShoot"],
            photoshoot: json["photoshoot"],
        );
    }

    Map<String, dynamic> toJson() => {
        "schoolTrip": schoolTrip,
        "corporateEvent": corporateEvent,
        "weddingParty": weddingParty,
        "airportTransfer": airportTransfer,
        "sportsTeam": sportsTeam,
        "dayTour": dayTour,
        "other": other,
        "otherSpecified": otherSpecified,
        "wedding": wedding,
        "prom": prom,
        "culturalCeremony": culturalCeremony,
        "filmShoot": filmShoot,
        "photoshoot": photoshoot,
    };

}

class PriceDetails {
  PriceDetails({
    required this.basePrice,
    required this.totalPrice,
    required this.extrasPrice,
    required this.extraCharges,
    required this.discounts,
    required this.depositAmount,
  });

  final double? basePrice;
  final double? totalPrice;
  final double? extrasPrice; // Changed from int? to double?
  final double? extraCharges; // Changed from int? to double?
  final double? discounts; // Changed from int? to double?
  final double? depositAmount; // Changed from int? to double?

  factory PriceDetails.fromJson(Map<String, dynamic> json) {
    return PriceDetails(
      basePrice: (json["basePrice"] as num?)?.toDouble(),
      totalPrice: (json["totalPrice"] as num?)?.toDouble(),
      extrasPrice: (json["extrasPrice"] as num?)?.toDouble(),
      extraCharges: (json["extraCharges"] as num?)?.toDouble(),
      discounts: (json["discounts"] as num?)?.toDouble(),
      depositAmount: (json["depositAmount"] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    "basePrice": basePrice,
    "totalPrice": totalPrice,
    "extrasPrice": extrasPrice,
    "extraCharges": extraCharges,
    "discounts": discounts,
    "depositAmount": depositAmount,
  };
}

class ServiceId {
    ServiceId({
        required this.id,
        required this.categoryId,
        required this.subcategoryId,
        required this.vendorId,
        required this.serviceName,
        required this.occasionsCovered,
        required this.areasCovered,
        required this.available247,
        required this.bookingOptions,
        required this.serviceIdFleetDetails,
        required this.features,
        required this.featurePricing,
        required this.fullDayRate,
        required this.hourlyRate,
        required this.halfDayRate,
        required this.weddingPackageRate,
        required this.airportTransferRate,
        required this.fuelIncluded,
        required this.mileageCapLimit,
        required this.mileageCapExcessCharge,
        required this.images,
        required this.bookingDateFrom,
        required this.bookingDateTo,
        required this.specialPriceDays,
        required this.serviceStatus,
        required this.serviceApproveStatus,
        required this.coupons,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.documentation,
        required this.otherOccasions,
        required this.promoVideoLink,
        required this.promotionalDescription,
        required this.serviceHighlights,
        required this.serviceIdServiceName,
        required this.serviceType,
        required this.vehicleType,
        required this.baseLocationPostcode,
        required this.fleetInfo,
        required this.occasionsCatered,
        required this.pricingDetails,
        required this.serviceIdBookingDateFrom,
        required this.serviceIdBookingDateTo,
        required this.licensing,
        required this.serviceImage,
        required this.businessProfile,
        required this.cancellationPolicyType,
        required this.listingData,
        required this.serviceIdSpecialPriceDays,
        required this.servicesOffered,
        required this.operatingHours,
        required this.offeringPrice,
        required this.basePostcode,
        required this.radiusCovered,
        required this.bookingTypes,
        required this.availableMinibuses,
        required this.seatBeltsInAllVehicles,
        required this.foodDrinksAllowed,
        required this.driverInformation,
        required this.miniBusRates,
        required this.documents,
        required this.uniqueFeatures,
        required this.emergencyContactNumber,
        required this.funeralVehicleTypes,
        required this.accessibilityAndSpecialServices,
        required this.funeralPackageOptions,
        required this.bookingAvailabilityDateFrom,
        required this.bookingAvailabilityDateTo,
        required this.fleetDetails,
        required this.driverDetail,
        required this.serviceDetail,
        required this.licensingDetails,
        required this.insuranceDetails,
        required this.uploadedDocuments,
        required this.approvalStatus,
        required this.serviceDetails,
        required this.equipmentSafety,
        required this.licensingInsurance,
        required this.marketing,
        required this.bookingAvailability,
        required this.serviceAreas,
        required this.availabilityPeriod,
        required this.pricing,
    });

    final String? id;
    final String? categoryId;
    final String? subcategoryId;
    final String? vendorId;
    final String? serviceName;
    final List<String> occasionsCovered;
    final List<String> areasCovered;
    final bool? available247;
    final List<dynamic> bookingOptions;
    final List<FleetDetail> serviceIdFleetDetails;
    final Features? features;
    final FeaturePricing? featurePricing;
   final double? fullDayRate;
  final double? hourlyRate;
  final double? halfDayRate;
  final double? weddingPackageRate;
  final double? airportTransferRate;
  final double? mileageCapLimit;
  final double? mileageCapExcessCharge;
  final double? offeringPrice;
    final bool? fuelIncluded;
  
    final List<String> images;
    final DateTime? bookingDateFrom;
    final DateTime? bookingDateTo;
    final List<SpecialPriceDay> specialPriceDays;
    final String? serviceStatus;
    final dynamic? serviceApproveStatus;
    final List<Coupon> coupons;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;
    final Documentation? documentation;
    final String? otherOccasions;
    final String? promoVideoLink;
    final String? promotionalDescription;
    final String? serviceHighlights;
    final String? serviceIdServiceName;
    final String? serviceType;
    final String? vehicleType;
    final String? baseLocationPostcode;
    final FleetInfo? fleetInfo;
    final OccasionsCatered? occasionsCatered;
    final PricingDetails? pricingDetails;
    final DateTime? serviceIdBookingDateFrom;
    final DateTime? serviceIdBookingDateTo;
    final Licensing? licensing;
    final List<String> serviceImage;
    final BusinessProfile? businessProfile;
    final String? cancellationPolicyType;
    final ListingData? listingData;
    final List<SpecialPriceDay> serviceIdSpecialPriceDays;
    final ServicesOffered? servicesOffered;
    final OperatingHours? operatingHours;
    
    final String? basePostcode;
    final int? radiusCovered;
    final BookingTypes? bookingTypes;
    final int? availableMinibuses;
    final bool? seatBeltsInAllVehicles;
    final String? foodDrinksAllowed;
    final DriverInformation? driverInformation;
    final MiniBusRates? miniBusRates;
    final ServiceIdDocuments? documents;
    
    final String? uniqueFeatures;
    final String? emergencyContactNumber;
    final List<String> funeralVehicleTypes;
    final List<AccessibilityAndSpecialService> accessibilityAndSpecialServices;
    final FuneralPackageOptions? funeralPackageOptions;
    final DateTime? bookingAvailabilityDateFrom;
    final DateTime? bookingAvailabilityDateTo;
    final FleetDetails? fleetDetails;
    final DriverDetail? driverDetail;
    final ServiceDetail? serviceDetail;
    final LicensingDetails? licensingDetails;
    final InsuranceDetails? insuranceDetails;
    final UploadedDocuments? uploadedDocuments;
    final String? approvalStatus;
    final ServiceDetails? serviceDetails;
    final EquipmentSafety? equipmentSafety;
    final LicensingInsurance? licensingInsurance;
    final Marketing? marketing;
    final BookingAvailability? bookingAvailability;
    final List<String> serviceAreas;
    final AvailabilityPeriod? availabilityPeriod;
    final Pricing? pricing;

    factory ServiceId.fromJson(Map<String, dynamic> json){ 
        return ServiceId(
            id: json["_id"],
            categoryId: json["categoryId"],
            subcategoryId: json["subcategoryId"],
            vendorId: json["vendorId"],
            fullDayRate: (json["fullDayRate"] as num?)?.toDouble(),
      hourlyRate: (json["hourlyRate"] as num?)?.toDouble(),
      halfDayRate: (json["halfDayRate"] as num?)?.toDouble(),
      weddingPackageRate: (json["weddingPackageRate"] as num?)?.toDouble(),
      airportTransferRate: (json["airportTransferRate"] as num?)?.toDouble(),
      mileageCapLimit: (json["mileageCapLimit"] as num?)?.toDouble(),
      mileageCapExcessCharge: (json["mileageCapExcessCharge"] as num?)?.toDouble(),
      offeringPrice: (json["offering_price"] as num?)?.toDouble(),
            serviceName: json["serviceName"],
            occasionsCovered: json["occasionsCovered"] == null ? [] : List<String>.from(json["occasionsCovered"]!.map((x) => x)),
            areasCovered: json["areasCovered"] == null ? [] : List<String>.from(json["areasCovered"]!.map((x) => x)),
            available247: json["available_24_7"],
            bookingOptions: json["bookingOptions"] == null ? [] : List<dynamic>.from(json["bookingOptions"]!.map((x) => x)),
            serviceIdFleetDetails: json["fleet_details"] == null ? [] : List<FleetDetail>.from(json["fleet_details"]!.map((x) => FleetDetail.fromJson(x))),
            features: json["features"] == null ? null : Features.fromJson(json["features"]),
            featurePricing: json["featurePricing"] == null ? null : FeaturePricing.fromJson(json["featurePricing"]),
          
            fuelIncluded: json["fuelIncluded"],
         
            images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
            
            bookingDateFrom: DateTime.tryParse(json["bookingDateFrom"] ?? ""),
            bookingDateTo: DateTime.tryParse(json["bookingDateTo"] ?? ""),
            specialPriceDays: json["specialPriceDays"] == null ? [] : List<SpecialPriceDay>.from(json["specialPriceDays"]!.map((x) => SpecialPriceDay.fromJson(x))),
            serviceStatus: json["service_status"],
            serviceApproveStatus: json["service_approve_status"],
            coupons: json["coupons"] == null ? [] : List<Coupon>.from(json["coupons"]!.map((x) => Coupon.fromJson(x))),
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
            documentation: json["documentation"] == null ? null : Documentation.fromJson(json["documentation"]),
            otherOccasions: json["otherOccasions"],
            promoVideoLink: json["promoVideoLink"],
            promotionalDescription: json["promotionalDescription"],
            serviceHighlights: json["serviceHighlights"],
            serviceIdServiceName: json["service_name"],
            serviceType: json["serviceType"],
            vehicleType: json["vehicleType"],
            baseLocationPostcode: json["baseLocationPostcode"],
            fleetInfo: json["fleetInfo"] == null ? null : FleetInfo.fromJson(json["fleetInfo"]),
            occasionsCatered: json["occasionsCatered"] == null ? null : OccasionsCatered.fromJson(json["occasionsCatered"]),
            pricingDetails: json["pricingDetails"] == null ? null : PricingDetails.fromJson(json["pricingDetails"]),
            serviceIdBookingDateFrom: DateTime.tryParse(json["booking_date_from"] ?? ""),
            serviceIdBookingDateTo: DateTime.tryParse(json["booking_date_to"] ?? ""),
            licensing: json["licensing"] == null ? null : Licensing.fromJson(json["licensing"]),
            serviceImage: json["service_image"] == null ? [] : List<String>.from(json["service_image"]!.map((x) => x)),
            businessProfile: json["businessProfile"] == null ? null : BusinessProfile.fromJson(json["businessProfile"]),
            cancellationPolicyType: json["cancellation_policy_type"],
            listingData: json["listing_data"] == null ? null : ListingData.fromJson(json["listing_data"]),
            serviceIdSpecialPriceDays: json["special_price_days"] == null ? [] : List<SpecialPriceDay>.from(json["special_price_days"]!.map((x) => SpecialPriceDay.fromJson(x))),
            servicesOffered: json["servicesOffered"] == null ? null : ServicesOffered.fromJson(json["servicesOffered"]),
            operatingHours: json["operatingHours"] == null ? null : OperatingHours.fromJson(json["operatingHours"]),
          
            basePostcode: json["basePostcode"],
            radiusCovered: json["radiusCovered"],
            bookingTypes: json["bookingTypes"] == null ? null : BookingTypes.fromJson(json["bookingTypes"]),
            availableMinibuses: json["availableMinibuses"],
            seatBeltsInAllVehicles: json["seatBeltsInAllVehicles"],
            foodDrinksAllowed: json["foodDrinksAllowed"],
            driverInformation: json["driverInformation"] == null ? null : DriverInformation.fromJson(json["driverInformation"]),
            miniBusRates: json["miniBusRates"] == null ? null : MiniBusRates.fromJson(json["miniBusRates"]),
            documents: json["documents"] == null ? null : ServiceIdDocuments.fromJson(json["documents"]),
            uniqueFeatures: json["uniqueFeatures"],
            emergencyContactNumber: json["emergencyContactNumber"],
            funeralVehicleTypes: json["funeralVehicleTypes"] == null ? [] : List<String>.from(json["funeralVehicleTypes"]!.map((x) => x)),
            accessibilityAndSpecialServices: json["accessibilityAndSpecialServices"] == null ? [] : List<AccessibilityAndSpecialService>.from(json["accessibilityAndSpecialServices"]!.map((x) => AccessibilityAndSpecialService.fromJson(x))),
            funeralPackageOptions: json["funeralPackageOptions"] == null ? null : FuneralPackageOptions.fromJson(json["funeralPackageOptions"]),
            bookingAvailabilityDateFrom: DateTime.tryParse(json["booking_availability_date_from"] ?? ""),
            bookingAvailabilityDateTo: DateTime.tryParse(json["booking_availability_date_to"] ?? ""),
            fleetDetails: json["fleetDetails"] == null ? null : FleetDetails.fromJson(json["fleetDetails"]),
            driverDetail: json["driver_detail"] == null ? null : DriverDetail.fromJson(json["driver_detail"]),
            serviceDetail: json["service_detail"] == null ? null : ServiceDetail.fromJson(json["service_detail"]),
            licensingDetails: json["licensingDetails"] == null ? null : LicensingDetails.fromJson(json["licensingDetails"]),
            insuranceDetails: json["insuranceDetails"] == null ? null : InsuranceDetails.fromJson(json["insuranceDetails"]),
            uploadedDocuments: json["uploaded_Documents"] == null ? null : UploadedDocuments.fromJson(json["uploaded_Documents"]),
            approvalStatus: json["approvalStatus"],
            serviceDetails: json["serviceDetails"] == null ? null : ServiceDetails.fromJson(json["serviceDetails"]),
            equipmentSafety: json["equipmentSafety"] == null ? null : EquipmentSafety.fromJson(json["equipmentSafety"]),
            licensingInsurance: json["licensingInsurance"] == null ? null : LicensingInsurance.fromJson(json["licensingInsurance"]),
            marketing: json["marketing"] == null ? null : Marketing.fromJson(json["marketing"]),
            bookingAvailability: json["bookingAvailability"] == null ? null : BookingAvailability.fromJson(json["bookingAvailability"]),
            serviceAreas: json["serviceAreas"] == null ? [] : List<String>.from(json["serviceAreas"]!.map((x) => x)),
            availabilityPeriod: json["availabilityPeriod"] == null ? null : AvailabilityPeriod.fromJson(json["availabilityPeriod"]),
            pricing: json["pricing"] == null ? null : Pricing.fromJson(json["pricing"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "categoryId": categoryId,
        "subcategoryId": subcategoryId,
        "vendorId": vendorId,
        "serviceName": serviceName,
        "occasionsCovered": occasionsCovered.map((x) => x).toList(),
        "areasCovered": areasCovered.map((x) => x).toList(),
        "available_24_7": available247,
        "bookingOptions": bookingOptions.map((x) => x).toList(),
        "fleet_details": serviceIdFleetDetails.map((x) => x?.toJson()).toList(),
        "features": features?.toJson(),
        "featurePricing": featurePricing?.toJson(),
        "fullDayRate": fullDayRate,
        "hourlyRate": hourlyRate,
        "halfDayRate": halfDayRate,
        "weddingPackageRate": weddingPackageRate,
        "airportTransferRate": airportTransferRate,
        "fuelIncluded": fuelIncluded,
        "mileageCapLimit": mileageCapLimit,
        "mileageCapExcessCharge": mileageCapExcessCharge,
        "images": images.map((x) => x).toList(),
        "bookingDateFrom": bookingDateFrom?.toIso8601String(),
        "bookingDateTo": bookingDateTo?.toIso8601String(),
        "specialPriceDays": specialPriceDays.map((x) => x?.toJson()).toList(),
        "service_status": serviceStatus,
        "service_approve_status": serviceApproveStatus,
        "coupons": coupons.map((x) => x?.toJson()).toList(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "documentation": documentation?.toJson(),
        "otherOccasions": otherOccasions,
        "promoVideoLink": promoVideoLink,
        "promotionalDescription": promotionalDescription,
        "serviceHighlights": serviceHighlights,
        "service_name": serviceIdServiceName,
        "serviceType": serviceType,
        "vehicleType": vehicleType,
        "baseLocationPostcode": baseLocationPostcode,
        "fleetInfo": fleetInfo?.toJson(),
        "occasionsCatered": occasionsCatered?.toJson(),
        "pricingDetails": pricingDetails?.toJson(),
        "booking_date_from": serviceIdBookingDateFrom?.toIso8601String(),
        "booking_date_to": serviceIdBookingDateTo?.toIso8601String(),
        "licensing": licensing?.toJson(),
        "service_image": serviceImage.map((x) => x).toList(),
        "businessProfile": businessProfile?.toJson(),
        "cancellation_policy_type": cancellationPolicyType,
        "listing_data": listingData?.toJson(),
        "special_price_days": serviceIdSpecialPriceDays.map((x) => x?.toJson()).toList(),
        "servicesOffered": servicesOffered?.toJson(),
        "operatingHours": operatingHours?.toJson(),
        "offering_price": offeringPrice,
        "basePostcode": basePostcode,
        "radiusCovered": radiusCovered,
        "bookingTypes": bookingTypes?.toJson(),
        "availableMinibuses": availableMinibuses,
        "seatBeltsInAllVehicles": seatBeltsInAllVehicles,
        "foodDrinksAllowed": foodDrinksAllowed,
        "driverInformation": driverInformation?.toJson(),
        "miniBusRates": miniBusRates?.toJson(),
        "documents": documents?.toJson(),
        "uniqueFeatures": uniqueFeatures,
        "emergencyContactNumber": emergencyContactNumber,
        "funeralVehicleTypes": funeralVehicleTypes.map((x) => x).toList(),
        "accessibilityAndSpecialServices": accessibilityAndSpecialServices.map((x) => x?.toJson()).toList(),
        "funeralPackageOptions": funeralPackageOptions?.toJson(),
        "booking_availability_date_from": bookingAvailabilityDateFrom?.toIso8601String(),
        "booking_availability_date_to": bookingAvailabilityDateTo?.toIso8601String(),
        "fleetDetails": fleetDetails?.toJson(),
        "driver_detail": driverDetail?.toJson(),
        "service_detail": serviceDetail?.toJson(),
        "licensingDetails": licensingDetails?.toJson(),
        "insuranceDetails": insuranceDetails?.toJson(),
        "uploaded_Documents": uploadedDocuments?.toJson(),
        "approvalStatus": approvalStatus,
        "serviceDetails": serviceDetails?.toJson(),
        "equipmentSafety": equipmentSafety?.toJson(),
        "licensingInsurance": licensingInsurance?.toJson(),
        "marketing": marketing?.toJson(),
        "bookingAvailability": bookingAvailability?.toJson(),
        "serviceAreas": serviceAreas.map((x) => x).toList(),
        "availabilityPeriod": availabilityPeriod?.toJson(),
        "pricing": pricing?.toJson(),
    };

}

class AccessibilityAndSpecialService {
    AccessibilityAndSpecialService({
        required this.serviceType,
        required this.additionalPrice,
        required this.id,
    });

    final String? serviceType;
    final int? additionalPrice;
    final String? id;

    factory AccessibilityAndSpecialService.fromJson(Map<String, dynamic> json){ 
        return AccessibilityAndSpecialService(
            serviceType: json["serviceType"],
            additionalPrice: json["additionalPrice"],
            id: json["_id"],
        );
    }

    Map<String, dynamic> toJson() => {
        "serviceType": serviceType,
        "additionalPrice": additionalPrice,
        "_id": id,
    };

}

class AvailabilityPeriod {
    AvailabilityPeriod({
        required this.from,
        required this.to,
    });

    final DateTime? from;
    final DateTime? to;

    factory AvailabilityPeriod.fromJson(Map<String, dynamic> json){ 
        return AvailabilityPeriod(
            from: DateTime.tryParse(json["from"] ?? ""),
            to: DateTime.tryParse(json["to"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "from": from?.toIso8601String(),
        "to": to?.toIso8601String(),
    };

}

class BookingAvailability {
    BookingAvailability({
        required this.availableFor,
        required this.leadTime,
        required this.bookingOptions,
    });

    final List<String> availableFor;
    final String? leadTime;
    final List<dynamic> bookingOptions;

    factory BookingAvailability.fromJson(Map<String, dynamic> json){ 
        return BookingAvailability(
            availableFor: json["availableFor"] == null ? [] : List<String>.from(json["availableFor"]!.map((x) => x)),
            leadTime: json["leadTime"],
            bookingOptions: json["bookingOptions"] == null ? [] : List<dynamic>.from(json["bookingOptions"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "availableFor": availableFor.map((x) => x).toList(),
        "leadTime": leadTime,
        "bookingOptions": bookingOptions.map((x) => x).toList(),
    };

}

class BookingTypes {
    BookingTypes({
        required this.oneWay,
        required this.bookingTypesReturn,
        required this.hourlyHire,
        required this.dailyLongTermHire,
        required this.contractualServices,
    });

    final bool? oneWay;
    final bool? bookingTypesReturn;
    final bool? hourlyHire;
    final bool? dailyLongTermHire;
    final bool? contractualServices;

    factory BookingTypes.fromJson(Map<String, dynamic> json){ 
        return BookingTypes(
            oneWay: json["oneWay"],
            bookingTypesReturn: json["return"],
            hourlyHire: json["hourlyHire"],
            dailyLongTermHire: json["dailyLongTermHire"],
            contractualServices: json["contractualServices"],
        );
    }

    Map<String, dynamic> toJson() => {
        "oneWay": oneWay,
        "return": bookingTypesReturn,
        "hourlyHire": hourlyHire,
        "dailyLongTermHire": dailyLongTermHire,
        "contractualServices": contractualServices,
    };

}

class BusinessProfile {
    BusinessProfile({
        required this.description,
        required this.businessHighlights,
        required this.promotionalDescription,
    });

    final String? description;
    final String? businessHighlights;
    final String? promotionalDescription;

    factory BusinessProfile.fromJson(Map<String, dynamic> json){ 
        return BusinessProfile(
            description: json["description"],
            businessHighlights: json["businessHighlights"],
            promotionalDescription: json["promotionalDescription"],
        );
    }

    Map<String, dynamic> toJson() => {
        "description": description,
        "businessHighlights": businessHighlights,
        "promotionalDescription": promotionalDescription,
    };

}

class Coupon {
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

    final String? couponCode;
    final String? discountType;
    final double? discountValue;
    final int? usageLimit;
    final int? currentUsageCount;
    final DateTime? expiryDate;
    final bool? isGlobal;
    final String? id;

    factory Coupon.fromJson(Map<String, dynamic> json){ 
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

class Documentation {
    Documentation({required this.json});
    final Map<String,dynamic> json;

    factory Documentation.fromJson(Map<String, dynamic> json){ 
        return Documentation(
        json: json
        );
    }

    Map<String, dynamic> toJson() => {
    };

}

class ServiceIdDocuments {
    ServiceIdDocuments({
        required this.operatorLicence,
        required this.driverLicences,
        required this.publicLiabilityInsurance,
        required this.vehicleInsuranceAndMoTs,
        required this.dbsCertificates,
    });

    final DbsCertificates? operatorLicence;
    final DbsCertificates? driverLicences;
    final DbsCertificates? publicLiabilityInsurance;
    final DbsCertificates? vehicleInsuranceAndMoTs;
    final DbsCertificates? dbsCertificates;

    factory ServiceIdDocuments.fromJson(Map<String, dynamic> json){ 
        return ServiceIdDocuments(
            operatorLicence: json["operatorLicence"] == null ? null : DbsCertificates.fromJson(json["operatorLicence"]),
            driverLicences: json["driverLicences"] == null ? null : DbsCertificates.fromJson(json["driverLicences"]),
            publicLiabilityInsurance: json["publicLiabilityInsurance"] == null ? null : DbsCertificates.fromJson(json["publicLiabilityInsurance"]),
            vehicleInsuranceAndMoTs: json["vehicleInsuranceAndMOTs"] == null ? null : DbsCertificates.fromJson(json["vehicleInsuranceAndMOTs"]),
            dbsCertificates: json["dbsCertificates"] == null ? null : DbsCertificates.fromJson(json["dbsCertificates"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "operatorLicence": operatorLicence?.toJson(),
        "driverLicences": driverLicences?.toJson(),
        "publicLiabilityInsurance": publicLiabilityInsurance?.toJson(),
        "vehicleInsuranceAndMOTs": vehicleInsuranceAndMoTs?.toJson(),
        "dbsCertificates": dbsCertificates?.toJson(),
    };

}

class DbsCertificates {
    DbsCertificates({
        required this.isAttached,
        required this.image,
    });

    final bool? isAttached;
    final String? image;

    factory DbsCertificates.fromJson(Map<String, dynamic> json){ 
        return DbsCertificates(
            isAttached: json["isAttached"],
            image: json["image"],
        );
    }

    Map<String, dynamic> toJson() => {
        "isAttached": isAttached,
        "image": image,
    };

}

class DriverDetail {
    DriverDetail({
        required this.driversUniformed,
        required this.driversDbsChecked,
    });

    final bool? driversUniformed;
    final bool? driversDbsChecked;

    factory DriverDetail.fromJson(Map<String, dynamic> json){ 
        return DriverDetail(
            driversUniformed: json["driversUniformed"],
            driversDbsChecked: json["driversDBSChecked"],
        );
    }

    Map<String, dynamic> toJson() => {
        "driversUniformed": driversUniformed,
        "driversDBSChecked": driversDbsChecked,
    };

}

class DriverInformation {
    DriverInformation({
        required this.fullyLicensedAndInsured,
        required this.dbsChecked,
        required this.dressCode,
    });

    final bool? fullyLicensedAndInsured;
    final bool? dbsChecked;
    final String? dressCode;

    factory DriverInformation.fromJson(Map<String, dynamic> json){ 
        return DriverInformation(
            fullyLicensedAndInsured: json["fullyLicensedAndInsured"],
            dbsChecked: json["dbsChecked"],
            dressCode: json["dressCode"],
        );
    }

    Map<String, dynamic> toJson() => {
        "fullyLicensedAndInsured": fullyLicensedAndInsured,
        "dbsChecked": dbsChecked,
        "dressCode": dressCode,
    };

}

class EquipmentSafety {
    EquipmentSafety({
        required this.safetyChecks,
        required this.isMaintained,
        required this.uniformType,
        required this.offersRouteInspection,
        required this.animalWelfareStandards,
    });

    final List<String> safetyChecks;
    final bool? isMaintained;
    final String? uniformType;
    final bool? offersRouteInspection;
    final List<String> animalWelfareStandards;

    factory EquipmentSafety.fromJson(Map<String, dynamic> json){ 
        return EquipmentSafety(
            safetyChecks: json["safetyChecks"] == null ? [] : List<String>.from(json["safetyChecks"]!.map((x) => x)),
            isMaintained: json["isMaintained"],
            uniformType: json["uniformType"],
            offersRouteInspection: json["offersRouteInspection"],
            animalWelfareStandards: json["animalWelfareStandards"] == null ? [] : List<String>.from(json["animalWelfareStandards"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "safetyChecks": safetyChecks.map((x) => x).toList(),
        "isMaintained": isMaintained,
        "uniformType": uniformType,
        "offersRouteInspection": offersRouteInspection,
        "animalWelfareStandards": animalWelfareStandards.map((x) => x).toList(),
    };

}

class FeaturePricing {
    FeaturePricing({
        required this.eventsAndCustomization,
        required this.accessibilityServices,
    });

    final Documentation? eventsAndCustomization;
    final Documentation? accessibilityServices;

    factory FeaturePricing.fromJson(Map<String, dynamic> json){ 
        return FeaturePricing(
            eventsAndCustomization: json["eventsAndCustomization"] == null ? null : Documentation.fromJson(json["eventsAndCustomization"]),
            accessibilityServices: json["accessibilityServices"] == null ? null : Documentation.fromJson(json["accessibilityServices"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "eventsAndCustomization": eventsAndCustomization?.toJson(),
        "accessibilityServices": accessibilityServices?.toJson(),
    };

}

class Features {
    Features({
        required this.comfortAndLuxury,
        required this.eventsAndCustomization,
        required this.accessibilityServices,
        required this.safetyAndCompliance,
        required this.comfort,
        required this.events,
        required this.accessibility,
        required this.security,
    });

    final List<dynamic> comfortAndLuxury;
    final List<dynamic> eventsAndCustomization;
    final List<dynamic> accessibilityServices;
    final List<dynamic> safetyAndCompliance;
    final Comfort? comfort;
    final Events? events;
    final Accessibility? accessibility;
    final Security? security;

    factory Features.fromJson(Map<String, dynamic> json){ 
        return Features(
            comfortAndLuxury: json["comfortAndLuxury"] == null ? [] : List<dynamic>.from(json["comfortAndLuxury"]!.map((x) => x)),
            eventsAndCustomization: json["eventsAndCustomization"] == null ? [] : List<dynamic>.from(json["eventsAndCustomization"]!.map((x) => x)),
            accessibilityServices: json["accessibilityServices"] == null ? [] : List<dynamic>.from(json["accessibilityServices"]!.map((x) => x)),
            safetyAndCompliance: json["safetyAndCompliance"] == null ? [] : List<dynamic>.from(json["safetyAndCompliance"]!.map((x) => x)),
            comfort: json["comfort"] == null ? null : Comfort.fromJson(json["comfort"]),
            events: json["events"] == null ? null : Events.fromJson(json["events"]),
            accessibility: json["accessibility"] == null ? null : Accessibility.fromJson(json["accessibility"]),
            security: json["security"] == null ? null : Security.fromJson(json["security"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "comfortAndLuxury": comfortAndLuxury.map((x) => x).toList(),
        "eventsAndCustomization": eventsAndCustomization.map((x) => x).toList(),
        "accessibilityServices": accessibilityServices.map((x) => x).toList(),
        "safetyAndCompliance": safetyAndCompliance.map((x) => x).toList(),
        "comfort": comfort?.toJson(),
        "events": events?.toJson(),
        "accessibility": accessibility?.toJson(),
        "security": security?.toJson(),
    };

}

class Accessibility {
    Accessibility({
        required this.wheelchairAccessVehicle,
        required this.petFriendlyService,
        required this.childCarSeats,
        required this.disabledAccessRamp,
        required this.seniorFriendlyAssistance,
        required this.strollerBuggyStorage,
        required this.wheelchairAccessPrice,
        required this.petFriendlyPrice,
    });

    final bool? wheelchairAccessVehicle;
    final bool? petFriendlyService;
    final bool? childCarSeats;
    final bool? disabledAccessRamp;
    final bool? seniorFriendlyAssistance;
    final bool? strollerBuggyStorage;
    final int? wheelchairAccessPrice;
    final int? petFriendlyPrice;

    factory Accessibility.fromJson(Map<String, dynamic> json){ 
        return Accessibility(
            wheelchairAccessVehicle: json["wheelchairAccessVehicle"],
            petFriendlyService: json["petFriendlyService"],
            childCarSeats: json["childCarSeats"],
            disabledAccessRamp: json["disabledAccessRamp"],
            seniorFriendlyAssistance: json["seniorFriendlyAssistance"],
            strollerBuggyStorage: json["strollerBuggyStorage"],
            wheelchairAccessPrice: json["wheelchairAccessPrice"],
            petFriendlyPrice: json["petFriendlyPrice"],
        );
    }

    Map<String, dynamic> toJson() => {
        "wheelchairAccessVehicle": wheelchairAccessVehicle,
        "petFriendlyService": petFriendlyService,
        "childCarSeats": childCarSeats,
        "disabledAccessRamp": disabledAccessRamp,
        "seniorFriendlyAssistance": seniorFriendlyAssistance,
        "strollerBuggyStorage": strollerBuggyStorage,
        "wheelchairAccessPrice": wheelchairAccessPrice,
        "petFriendlyPrice": petFriendlyPrice,
    };

}

class Comfort {
    Comfort({
        required this.complimentaryDrinks,
        required this.leatherInterior,
        required this.wifiAccess,
        required this.airConditioning,
        required this.inCarEntertainment,
        required this.bluetoothUsb,
        required this.redCarpetService,
        required this.onboardRestroom,
        required this.chauffeurInUniform,
    });

    final ComplimentaryDrinks? complimentaryDrinks;
    final bool? leatherInterior;
    final bool? wifiAccess;
    final bool? airConditioning;
    final bool? inCarEntertainment;
    final bool? bluetoothUsb;
    final bool? redCarpetService;
    final bool? onboardRestroom;
    final bool? chauffeurInUniform;

    factory Comfort.fromJson(Map<String, dynamic> json){ 
        return Comfort(
            complimentaryDrinks: json["complimentaryDrinks"] == null ? null : ComplimentaryDrinks.fromJson(json["complimentaryDrinks"]),
            leatherInterior: json["leatherInterior"],
            wifiAccess: json["wifiAccess"],
            airConditioning: json["airConditioning"],
            inCarEntertainment: json["inCarEntertainment"],
            bluetoothUsb: json["bluetoothUsb"],
            redCarpetService: json["redCarpetService"],
            onboardRestroom: json["onboardRestroom"],
            chauffeurInUniform: json["chauffeurInUniform"],
        );
    }

    Map<String, dynamic> toJson() => {
        "complimentaryDrinks": complimentaryDrinks?.toJson(),
        "leatherInterior": leatherInterior,
        "wifiAccess": wifiAccess,
        "airConditioning": airConditioning,
        "inCarEntertainment": inCarEntertainment,
        "bluetoothUsb": bluetoothUsb,
        "redCarpetService": redCarpetService,
        "onboardRestroom": onboardRestroom,
        "chauffeurInUniform": chauffeurInUniform,
    };

}

class ComplimentaryDrinks {
    ComplimentaryDrinks({
        required this.available,
        required this.details,
    });

    final bool? available;
    final String? details;

    factory ComplimentaryDrinks.fromJson(Map<String, dynamic> json){ 
        return ComplimentaryDrinks(
            available: json["available"],
            details: json["details"],
        );
    }

    Map<String, dynamic> toJson() => {
        "available": available,
        "details": details,
    };

}

class Events {
    Events({
        required this.weddingDecor,
        required this.partyLightingSystem,
        required this.champagnePackages,
        required this.photographyPackages,
        required this.weddingDecorPrice,
        required this.partyLightingPrice,
        required this.champagnePackagePrice,
        required this.photographyPackagePrice,
    });

    final bool? weddingDecor;
    final bool? partyLightingSystem;
    final bool? champagnePackages;
    final bool? photographyPackages;
    final int? weddingDecorPrice;
    final int? partyLightingPrice;
    final int? champagnePackagePrice;
    final int? photographyPackagePrice;

    factory Events.fromJson(Map<String, dynamic> json){ 
        return Events(
            weddingDecor: json["weddingDecor"],
            partyLightingSystem: json["partyLightingSystem"],
            champagnePackages: json["champagnePackages"],
            photographyPackages: json["photographyPackages"],
            weddingDecorPrice: json["weddingDecorPrice"],
            partyLightingPrice: json["partyLightingPrice"],
            champagnePackagePrice: json["champagnePackagePrice"],
            photographyPackagePrice: json["photographyPackagePrice"],
        );
    }

    Map<String, dynamic> toJson() => {
        "weddingDecor": weddingDecor,
        "partyLightingSystem": partyLightingSystem,
        "champagnePackages": champagnePackages,
        "photographyPackages": photographyPackages,
        "weddingDecorPrice": weddingDecorPrice,
        "partyLightingPrice": partyLightingPrice,
        "champagnePackagePrice": champagnePackagePrice,
        "photographyPackagePrice": photographyPackagePrice,
    };

}

class Security {
    Security({
        required this.vehicleTrackingGps,
        required this.cctvFitted,
        required this.publicLiabilityInsurance,
        required this.safetyCertifiedDrivers,
    });

    final bool? vehicleTrackingGps;
    final bool? cctvFitted;
    final bool? publicLiabilityInsurance;
    final bool? safetyCertifiedDrivers;

    factory Security.fromJson(Map<String, dynamic> json){ 
        return Security(
            vehicleTrackingGps: json["vehicleTrackingGps"],
            cctvFitted: json["cctvFitted"],
            publicLiabilityInsurance: json["publicLiabilityInsurance"],
            safetyCertifiedDrivers: json["safetyCertifiedDrivers"],
        );
    }

    Map<String, dynamic> toJson() => {
        "vehicleTrackingGps": vehicleTrackingGps,
        "cctvFitted": cctvFitted,
        "publicLiabilityInsurance": publicLiabilityInsurance,
        "safetyCertifiedDrivers": safetyCertifiedDrivers,
    };

}

class FleetDetails {
    FleetDetails({
        required this.vehicleType,
        required this.makeModel,
        required this.color,
        required this.capacity,
        required this.year,
        required this.notes,
    });

    final String? vehicleType;
    final String? makeModel;
    final String? color;
    final int? capacity;
    final int? year;
    final String? notes;

    factory FleetDetails.fromJson(Map<String, dynamic> json){ 
        return FleetDetails(
            vehicleType: json["vehicleType"],
            makeModel: json["makeModel"],
            color: json["color"],
            capacity: json["capacity"],
            year: json["year"],
            notes: json["notes"],
        );
    }

    Map<String, dynamic> toJson() => {
        "vehicleType": vehicleType,
        "makeModel": makeModel,
        "color": color,
        "capacity": capacity,
        "year": year,
        "notes": notes,
    };

}

class FleetInfo {
    FleetInfo({
        required this.makeAndModel,
        required this.year,
        required this.colour,
        required this.seats,
        required this.bootSpace,
        required this.chauffeurName,
        required this.capacity,
        required this.wheelchairAccessible,
        required this.airConditioning,
        required this.luggageSpace,
        required this.notes,
    });

    final String? makeAndModel;
    final int? year;
    final String? colour;
    final int? seats;
    final String? bootSpace;
    final String? chauffeurName;
    final int? capacity;
    final bool? wheelchairAccessible;
    final bool? airConditioning;
    final bool? luggageSpace;
    final String? notes;

    factory FleetInfo.fromJson(Map<String, dynamic> json){ 
        return FleetInfo(
            makeAndModel: json["makeAndModel"],
            year: json["year"],
            colour: json["colour"],
            seats: json["seats"],
            bootSpace: json["bootSpace"],
            chauffeurName: json["chauffeurName"],
            capacity: json["capacity"],
            wheelchairAccessible: json["wheelchairAccessible"],
            airConditioning: json["airConditioning"],
            luggageSpace: json["luggageSpace"],
            notes: json["notes"],
        );
    }

    Map<String, dynamic> toJson() => {
        "makeAndModel": makeAndModel,
        "year": year,
        "colour": colour,
        "seats": seats,
        "bootSpace": bootSpace,
        "chauffeurName": chauffeurName,
        "capacity": capacity,
        "wheelchairAccessible": wheelchairAccessible,
        "airConditioning": airConditioning,
        "luggageSpace": luggageSpace,
        "notes": notes,
    };

}

class FuneralPackageOptions {
    FuneralPackageOptions({
        required this.standard,
        required this.vipExecutive,
    });

    final int? standard;
    final int? vipExecutive;

    factory FuneralPackageOptions.fromJson(Map<String, dynamic> json){ 
        return FuneralPackageOptions(
            standard: json["standard"],
            vipExecutive: json["vipExecutive"],
        );
    }

    Map<String, dynamic> toJson() => {
        "standard": standard,
        "vipExecutive": vipExecutive,
    };

}

class InsuranceDetails {
    InsuranceDetails({
        required this.publicLiabilityInsuranceProvider,
        required this.policyNumber,
        required this.policyExpiryDate,
    });

    final String? publicLiabilityInsuranceProvider;
    final String? policyNumber;
    final DateTime? policyExpiryDate;

    factory InsuranceDetails.fromJson(Map<String, dynamic> json){ 
        return InsuranceDetails(
            publicLiabilityInsuranceProvider: json["publicLiabilityInsuranceProvider"],
            policyNumber: json["policyNumber"],
            policyExpiryDate: DateTime.tryParse(json["policyExpiryDate"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "publicLiabilityInsuranceProvider": publicLiabilityInsuranceProvider,
        "policyNumber": policyNumber,
        "policyExpiryDate": policyExpiryDate?.toIso8601String(),
    };

}

class Licensing {
    Licensing({
        required this.documents,
        required this.privateHireOperatorLicenceNumber,
        required this.licensingAuthority,
        required this.publicLiabilityInsuranceProvider,
        required this.policyNumber,
        required this.expiryDate,
    });

    final LicensingDocuments? documents;
    final String? privateHireOperatorLicenceNumber;
    final String? licensingAuthority;
    final String? publicLiabilityInsuranceProvider;
    final String? policyNumber;
    final DateTime? expiryDate;

    factory Licensing.fromJson(Map<String, dynamic> json){ 
        return Licensing(
            documents: json["documents"] == null ? null : LicensingDocuments.fromJson(json["documents"]),
            privateHireOperatorLicenceNumber: json["privateHireOperatorLicenceNumber"],
            licensingAuthority: json["licensingAuthority"],
            publicLiabilityInsuranceProvider: json["publicLiabilityInsuranceProvider"],
            policyNumber: json["policyNumber"],
            expiryDate: DateTime.tryParse(json["expiryDate"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "documents": documents?.toJson(),
        "privateHireOperatorLicenceNumber": privateHireOperatorLicenceNumber,
        "licensingAuthority": licensingAuthority,
        "publicLiabilityInsuranceProvider": publicLiabilityInsuranceProvider,
        "policyNumber": policyNumber,
        "expiryDate": expiryDate != null
            ? "${expiryDate!.year.toString().padLeft(4, '0')}-${expiryDate!.month.toString().padLeft(2, '0')}-${expiryDate!.day.toString().padLeft(2, '0')}"
            : null,
    };

}

class LicensingDocuments {
    LicensingDocuments({
        required this.operatorLicence,
        required this.vehicleInsurance,
        required this.publicLiabilityInsurance,
        required this.v5CLogbook,
        required this.chauffeurDrivingLicence,
    });

    final ChauffeurDrivingLicence? operatorLicence;
    final ChauffeurDrivingLicence? vehicleInsurance;
    final ChauffeurDrivingLicence? publicLiabilityInsurance;
    final ChauffeurDrivingLicence? v5CLogbook;
    final ChauffeurDrivingLicence? chauffeurDrivingLicence;

    factory LicensingDocuments.fromJson(Map<String, dynamic> json){ 
        return LicensingDocuments(
            operatorLicence: json["operatorLicence"] == null ? null : ChauffeurDrivingLicence.fromJson(json["operatorLicence"]),
            vehicleInsurance: json["vehicleInsurance"] == null ? null : ChauffeurDrivingLicence.fromJson(json["vehicleInsurance"]),
            publicLiabilityInsurance: json["publicLiabilityInsurance"] == null ? null : ChauffeurDrivingLicence.fromJson(json["publicLiabilityInsurance"]),
            v5CLogbook: json["v5cLogbook"] == null ? null : ChauffeurDrivingLicence.fromJson(json["v5cLogbook"]),
            chauffeurDrivingLicence: json["chauffeurDrivingLicence"] == null ? null : ChauffeurDrivingLicence.fromJson(json["chauffeurDrivingLicence"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "operatorLicence": operatorLicence?.toJson(),
        "vehicleInsurance": vehicleInsurance?.toJson(),
        "publicLiabilityInsurance": publicLiabilityInsurance?.toJson(),
        "v5cLogbook": v5CLogbook?.toJson(),
        "chauffeurDrivingLicence": chauffeurDrivingLicence?.toJson(),
    };

}

class ChauffeurDrivingLicence {
    ChauffeurDrivingLicence({
        required this.isAttached,
    });

    final bool? isAttached;

    factory ChauffeurDrivingLicence.fromJson(Map<String, dynamic> json){ 
        return ChauffeurDrivingLicence(
            isAttached: json["isAttached"],
        );
    }

    Map<String, dynamic> toJson() => {
        "isAttached": isAttached,
    };

}

class LicensingDetails {
    LicensingDetails({
        required this.operatorLicenceNumber,
        required this.licensingAuthority,
    });

    final String? operatorLicenceNumber;
    final String? licensingAuthority;

    factory LicensingDetails.fromJson(Map<String, dynamic> json){ 
        return LicensingDetails(
            operatorLicenceNumber: json["operatorLicenceNumber"],
            licensingAuthority: json["licensingAuthority"],
        );
    }

    Map<String, dynamic> toJson() => {
        "operatorLicenceNumber": operatorLicenceNumber,
        "licensingAuthority": licensingAuthority,
    };

}

class LicensingInsurance {
    LicensingInsurance({
        required this.hasPublicLiabilityInsurance,
        required this.insuranceProviderName,
        required this.policyNumber,
        required this.policyExpiryDate,
        required this.hasAnimalLicense,
        required this.issuingAuthority,
    });

    final bool? hasPublicLiabilityInsurance;
    final String? insuranceProviderName;
    final String? policyNumber;
    final DateTime? policyExpiryDate;
    final bool? hasAnimalLicense;
    final String? issuingAuthority;

    factory LicensingInsurance.fromJson(Map<String, dynamic> json){ 
        return LicensingInsurance(
            hasPublicLiabilityInsurance: json["hasPublicLiabilityInsurance"],
            insuranceProviderName: json["insuranceProviderName"],
            policyNumber: json["policyNumber"],
            policyExpiryDate: DateTime.tryParse(json["policyExpiryDate"] ?? ""),
            hasAnimalLicense: json["hasAnimalLicense"],
            issuingAuthority: json["issuingAuthority"],
        );
    }

    Map<String, dynamic> toJson() => {
        "hasPublicLiabilityInsurance": hasPublicLiabilityInsurance,
        "insuranceProviderName": insuranceProviderName,
        "policyNumber": policyNumber,
        "policyExpiryDate": policyExpiryDate?.toIso8601String(),
        "hasAnimalLicense": hasAnimalLicense,
        "issuingAuthority": issuingAuthority,
    };

}

class ListingData {
    ListingData({
        required this.summary,
        required this.title,
        required this.description,
        required this.price,
        required this.priceFormatted,
        required this.location,
        required this.image,
        required this.status,
        required this.category,
        required this.subCategory,
        required this.features,
        required this.areasCovered,
    });

    final Summary? summary;
    final String? title;
    final String? description;
    final int? price;
    final String? priceFormatted;
    final String? location;
    final String? image;
    final String? status;
    final String? category;
    final String? subCategory;
    final List<String> features;
    final List<String> areasCovered;

    factory ListingData.fromJson(Map<String, dynamic> json){ 
        return ListingData(
            summary: json["summary"] == null ? null : Summary.fromJson(json["summary"]),
            title: json["title"],
            description: json["description"],
            price: json["price"],
            priceFormatted: json["price_formatted"],
            location: json["location"],
            image: json["image"],
            status: json["status"],
            category: json["category"],
            subCategory: json["sub_category"],
            features: json["features"] == null ? [] : List<String>.from(json["features"]!.map((x) => x)),
            areasCovered: json["areasCovered"] == null ? [] : List<String>.from(json["areasCovered"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "summary": summary?.toJson(),
        "title": title,
        "description": description,
        "price": price,
        "price_formatted": priceFormatted,
        "location": location,
        "image": image,
        "status": status,
        "category": category,
        "sub_category": subCategory,
        "features": features.map((x) => x).toList(),
        "areasCovered": areasCovered.map((x) => x).toList(),
    };

}

class Summary {
    Summary({
        required this.dayRate,
        required this.hourlyRate,
        required this.vehicle,
        required this.availability,
    });

    final int? dayRate;
    final int? hourlyRate;
    final String? vehicle;
    final String? availability;

    factory Summary.fromJson(Map<String, dynamic> json){ 
        return Summary(
            dayRate: json["day_rate"],
            hourlyRate: json["hourly_rate"],
            vehicle: json["vehicle"],
            availability: json["availability"],
        );
    }

    Map<String, dynamic> toJson() => {
        "day_rate": dayRate,
        "hourly_rate": hourlyRate,
        "vehicle": vehicle,
        "availability": availability,
    };

}

class Marketing {
    Marketing({
        required this.description,
        required this.serviceHighlights,
    });

    final String? description;
    final List<dynamic> serviceHighlights;

    factory Marketing.fromJson(Map<String, dynamic> json){ 
        return Marketing(
            description: json["description"],
            serviceHighlights: json["serviceHighlights"] == null ? [] : List<dynamic>.from(json["serviceHighlights"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "description": description,
        "serviceHighlights": serviceHighlights.map((x) => x).toList(),
    };

}
class MiniBusRates {
  MiniBusRates({
    required this.hourlyRate,
    required this.halfDayRate,
    required this.fullDayRate,
    required this.mileageAllowance,
    required this.additionalMileageFee,
  });

  final double? hourlyRate; // Changed from int? to double?
  final double? halfDayRate; // Changed from int? to double?
  final double? fullDayRate; // Changed from int? to double?
  final double? mileageAllowance; // Changed from int? to double?
  final double? additionalMileageFee; // Changed from int? to double?

  factory MiniBusRates.fromJson(Map<String, dynamic> json) {
    return MiniBusRates(
      hourlyRate: (json["hourlyRate"] as num?)?.toDouble(),
      halfDayRate: (json["halfDayRate"] as num?)?.toDouble(),
      fullDayRate: (json["fullDayRate"] as num?)?.toDouble(),
      mileageAllowance: (json["mileageAllowance"] as num?)?.toDouble(),
      additionalMileageFee: (json["additionalMileageFee"] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    "hourlyRate": hourlyRate,
    "halfDayRate": halfDayRate,
    "fullDayRate": fullDayRate,
    "mileageAllowance": mileageAllowance,
    "additionalMileageFee": additionalMileageFee,
  };
}
class OccasionsCatered {
    OccasionsCatered({
        required this.weddings,
        required this.corporateTravel,
        required this.vipRedCarpet,
        required this.filmTvHire,
        required this.airportTransfers,
        required this.proms,
    });

    final bool? weddings;
    final bool? corporateTravel;
    final bool? vipRedCarpet;
    final bool? filmTvHire;
    final bool? airportTransfers;
    final bool? proms;

    factory OccasionsCatered.fromJson(Map<String, dynamic> json){ 
        return OccasionsCatered(
            weddings: json["weddings"],
            corporateTravel: json["corporateTravel"],
            vipRedCarpet: json["vipRedCarpet"],
            filmTvHire: json["filmTVHire"],
            airportTransfers: json["airportTransfers"],
            proms: json["proms"],
        );
    }

    Map<String, dynamic> toJson() => {
        "weddings": weddings,
        "corporateTravel": corporateTravel,
        "vipRedCarpet": vipRedCarpet,
        "filmTVHire": filmTvHire,
        "airportTransfers": airportTransfers,
        "proms": proms,
    };

}

class OperatingHours {
    OperatingHours({
        required this.available24X7,
        required this.specificHours,
    });

    final bool? available24X7;
    final String? specificHours;

    factory OperatingHours.fromJson(Map<String, dynamic> json){ 
        return OperatingHours(
            available24X7: json["available24x7"],
            specificHours: json["specificHours"],
        );
    }

    Map<String, dynamic> toJson() => {
        "available24x7": available24X7,
        "specificHours": specificHours,
    };

}

class Pricing {
    Pricing({
        required this.hourlyRate,
        required this.halfDayRate,
        required this.fullDayRate,
        required this.ceremonyPackageRate,
    });

    final int? hourlyRate;
    final int? halfDayRate;
    final int? fullDayRate;
    final int? ceremonyPackageRate;

    factory Pricing.fromJson(Map<String, dynamic> json){ 
        return Pricing(
            hourlyRate: json["hourlyRate"],
            halfDayRate: json["halfDayRate"],
            fullDayRate: json["fullDayRate"],
            ceremonyPackageRate: json["ceremonyPackageRate"],
        );
    }

    Map<String, dynamic> toJson() => {
        "hourlyRate": hourlyRate,
        "halfDayRate": halfDayRate,
        "fullDayRate": fullDayRate,
        "ceremonyPackageRate": ceremonyPackageRate,
    };

}

class PricingDetails {
    PricingDetails({
        required this.dayRate,
        required this.mileageLimit,
        required this.extraMileageCharge,
        required this.chauffeurIncluded,
        required this.hourlyRate,
        required this.halfDayRate,
        required this.weddingPackage,
        required this.airportTransfer,
        required this.fuelChargesIncluded,
        required this.waitTimeFeePerHour,
        required this.decoratingFloralServiceFee,
    });

    final int? dayRate;
    final int? mileageLimit;
    final int? extraMileageCharge;
    final bool? chauffeurIncluded;
    final int? hourlyRate;
    final int? halfDayRate;
    final int? weddingPackage;
    final int? airportTransfer;
    final bool? fuelChargesIncluded;
    final int? waitTimeFeePerHour;
    final int? decoratingFloralServiceFee;

    factory PricingDetails.fromJson(Map<String, dynamic> json){ 
        return PricingDetails(
            dayRate: json["dayRate"],
            mileageLimit: json["mileageLimit"],
            extraMileageCharge: json["extraMileageCharge"],
            chauffeurIncluded: json["chauffeurIncluded"],
            hourlyRate: json["hourlyRate"],
            halfDayRate: json["halfDayRate"],
            weddingPackage: json["weddingPackage"],
            airportTransfer: json["airportTransfer"],
            fuelChargesIncluded: json["fuelChargesIncluded"],
            waitTimeFeePerHour: json["waitTimeFeePerHour"],
            decoratingFloralServiceFee: json["decoratingFloralServiceFee"],
        );
    }

    Map<String, dynamic> toJson() => {
        "dayRate": dayRate,
        "mileageLimit": mileageLimit,
        "extraMileageCharge": extraMileageCharge,
        "chauffeurIncluded": chauffeurIncluded,
        "hourlyRate": hourlyRate,
        "halfDayRate": halfDayRate,
        "weddingPackage": weddingPackage,
        "airportTransfer": airportTransfer,
        "fuelChargesIncluded": fuelChargesIncluded,
        "waitTimeFeePerHour": waitTimeFeePerHour,
        "decoratingFloralServiceFee": decoratingFloralServiceFee,
    };

}

class ServiceDetail {
    ServiceDetail({
        required this.worksWithFuneralDirectors,
        required this.supportsAllFuneralTypes,
        required this.funeralServiceType,
        required this.additionalSupportServices,
    });

    final bool? worksWithFuneralDirectors;
    final bool? supportsAllFuneralTypes;
    final String? funeralServiceType;
    final List<String> additionalSupportServices;

    factory ServiceDetail.fromJson(Map<String, dynamic> json){ 
        return ServiceDetail(
            worksWithFuneralDirectors: json["worksWithFuneralDirectors"],
            supportsAllFuneralTypes: json["supportsAllFuneralTypes"],
            funeralServiceType: json["funeralServiceType"],
            additionalSupportServices: json["additionalSupportServices"] == null ? [] : List<String>.from(json["additionalSupportServices"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "worksWithFuneralDirectors": worksWithFuneralDirectors,
        "supportsAllFuneralTypes": supportsAllFuneralTypes,
        "funeralServiceType": funeralServiceType,
        "additionalSupportServices": additionalSupportServices.map((x) => x).toList(),
    };

}

class ServiceDetails {
    ServiceDetails({
        required this.occasionsCatered,
        required this.carriageTypes,
        required this.horseTypes,
        required this.numberOfCarriages,
        required this.fleetSize,
        required this.basePostcode,
    });

    final List<String> occasionsCatered;
    final List<String> carriageTypes;
    final List<String> horseTypes;
    final int? numberOfCarriages;
    final int? fleetSize;
    final String? basePostcode;

    factory ServiceDetails.fromJson(Map<String, dynamic> json){ 
        return ServiceDetails(
            occasionsCatered: json["occasionsCatered"] == null ? [] : List<String>.from(json["occasionsCatered"]!.map((x) => x)),
            carriageTypes: json["carriageTypes"] == null ? [] : List<String>.from(json["carriageTypes"]!.map((x) => x)),
            horseTypes: json["horseTypes"] == null ? [] : List<String>.from(json["horseTypes"]!.map((x) => x)),
            numberOfCarriages: json["numberOfCarriages"],
            fleetSize: json["fleetSize"],
            basePostcode: json["basePostcode"],
        );
    }

    Map<String, dynamic> toJson() => {
        "occasionsCatered": occasionsCatered.map((x) => x).toList(),
        "carriageTypes": carriageTypes.map((x) => x).toList(),
        "horseTypes": horseTypes.map((x) => x).toList(),
        "numberOfCarriages": numberOfCarriages,
        "fleetSize": fleetSize,
        "basePostcode": basePostcode,
    };

}

class FleetDetail {
    FleetDetail({
        required this.vehicleId,
        required this.makeModel,
        required this.type,
        required this.year,
        required this.color,
        required this.capacity,
        required this.vehicleDescription,
        required this.bootSpace,
        required this.keyFeatures,
        required this.id,
    });

    final String? vehicleId;
    final String? makeModel;
    final String? type;
    final int? year;
    final String? color;
    final int? capacity;
    final String? vehicleDescription;
    final String? bootSpace;
    final String? keyFeatures;
    final String? id;

    factory FleetDetail.fromJson(Map<String, dynamic> json){ 
        return FleetDetail(
            vehicleId: json["vehicleId"],
            makeModel: json["make_Model"],
            type: json["type"],
            year: json["year"],
            color: json["color"],
            capacity: json["capacity"],
            vehicleDescription: json["vehicleDescription"],
            bootSpace: json["bootSpace"],
            keyFeatures: json["key_Features"],
            id: json["_id"],
        );
    }

    Map<String, dynamic> toJson() => {
        "vehicleId": vehicleId,
        "make_Model": makeModel,
        "type": type,
        "year": year,
        "color": color,
        "capacity": capacity,
        "vehicleDescription": vehicleDescription,
        "bootSpace": bootSpace,
        "key_Features": keyFeatures,
        "_id": id,
    };

}

class SpecialPriceDay {
    SpecialPriceDay({
        required this.date,
        required this.price,
        required this.id,
    });

    final DateTime? date;
    final double? price;
    final String? id;

    factory SpecialPriceDay.fromJson(Map<String, dynamic> json){ 
        return SpecialPriceDay(
            date: DateTime.tryParse(json["date"] ?? ""),
            price: json["price"],
            id: json["_id"],
        );
    }

    Map<String, dynamic> toJson() => {
        "date": date != null
            ? "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}"
            : null,
        "price": price,
        "_id": id,
    };

}

class ServicesOffered {
    ServicesOffered({
        required this.localGroupTransport,
        required this.airportTransfers,
        required this.schoolTrips,
        required this.corporateTransport,
        required this.eventWeddingShuttles,
        required this.dayTours,
        required this.contractHire,
        required this.accessibleMinibusHire,
        required this.other,
        required this.otherSpecified,
    });

    final bool? localGroupTransport;
    final bool? airportTransfers;
    final bool? schoolTrips;
    final bool? corporateTransport;
    final bool? eventWeddingShuttles;
    final bool? dayTours;
    final bool? contractHire;
    final bool? accessibleMinibusHire;
    final bool? other;
    final String? otherSpecified;

    factory ServicesOffered.fromJson(Map<String, dynamic> json){ 
        return ServicesOffered(
            localGroupTransport: json["localGroupTransport"],
            airportTransfers: json["airportTransfers"],
            schoolTrips: json["schoolTrips"],
            corporateTransport: json["corporateTransport"],
            eventWeddingShuttles: json["eventWeddingShuttles"],
            dayTours: json["dayTours"],
            contractHire: json["contractHire"],
            accessibleMinibusHire: json["accessibleMinibusHire"],
            other: json["other"],
            otherSpecified: json["otherSpecified"],
        );
    }

    Map<String, dynamic> toJson() => {
        "localGroupTransport": localGroupTransport,
        "airportTransfers": airportTransfers,
        "schoolTrips": schoolTrips,
        "corporateTransport": corporateTransport,
        "eventWeddingShuttles": eventWeddingShuttles,
        "dayTours": dayTours,
        "contractHire": contractHire,
        "accessibleMinibusHire": accessibleMinibusHire,
        "other": other,
        "otherSpecified": otherSpecified,
    };

}

class UploadedDocuments {
    UploadedDocuments({
        required this.operatorLicence,
        required this.insuranceCertificate,
        required this.driverLicencesAndDbs,
        required this.vehicleMoTs,
        required this.fleetPhotos,
    });

    final String? operatorLicence;
    final String? insuranceCertificate;
    final String? driverLicencesAndDbs;
    final String? vehicleMoTs;
    final List<String> fleetPhotos;

    factory UploadedDocuments.fromJson(Map<String, dynamic> json){ 
        return UploadedDocuments(
            operatorLicence: json["operatorLicence"],
            insuranceCertificate: json["insuranceCertificate"],
            driverLicencesAndDbs: json["driverLicencesAndDBS"],
            vehicleMoTs: json["vehicleMOTs"],
            fleetPhotos: json["fleetPhotos"] == null ? [] : List<String>.from(json["fleetPhotos"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "operatorLicence": operatorLicence,
        "insuranceCertificate": insuranceCertificate,
        "driverLicencesAndDBS": driverLicencesAndDbs,
        "vehicleMOTs": vehicleMoTs,
        "fleetPhotos": fleetPhotos.map((x) => x).toList(),
    };

}

class SpecialRequests {
    SpecialRequests({
        required this.vintageCostumeHire,
        required this.personalizedSignage,
        required this.animalWelfarePreferences,
        required this.other,
        required this.otherSpecified,
        required this.details,
        required this.scenicRoute,
    });

    final bool? vintageCostumeHire;
    final bool? personalizedSignage;
    final bool? animalWelfarePreferences;
    final bool? other;
    final String? otherSpecified;
    final String? details;
    final bool? scenicRoute;

    factory SpecialRequests.fromJson(Map<String, dynamic> json){ 
        return SpecialRequests(
            vintageCostumeHire: json["vintageCostumeHire"],
            personalizedSignage: json["personalizedSignage"],
            animalWelfarePreferences: json["animalWelfarePreferences"],
            other: json["other"],
            otherSpecified: json["otherSpecified"],
            details: json["details"],
            scenicRoute: json["scenicRoute"],
        );
    }

    Map<String, dynamic> toJson() => {
        "vintageCostumeHire": vintageCostumeHire,
        "personalizedSignage": personalizedSignage,
        "animalWelfarePreferences": animalWelfarePreferences,
        "other": other,
        "otherSpecified": otherSpecified,
        "details": details,
        "scenicRoute": scenicRoute,
    };

}

class VendorId {
    VendorId({
        required this.id,
        required this.categoryId,
        required this.countryCode,
        required this.mobileNo,
        required this.password,
        required this.otp,
        required this.companyName,
        required this.name,
        required this.email,
        required this.streetName,
        required this.cityName,
        required this.pincode,
        required this.vehicleImage,
        required this.vendorStatus,
        required this.vendorActiveStatus,
        required this.walletAmmount,
        required this.geoLocation,
        required this.commission,
        required this.offeringPrice,
        required this.legalDocuments,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.countryName,
        required this.description,
        required this.gender,
        required this.vendorImage,
        required this.country,
    });

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
    final List<dynamic> vehicleImage;
    final String? vendorStatus;
    final String? vendorActiveStatus;
    final int? walletAmmount;
    final GeoLocation? geoLocation;
    final int? commission;
    final double? offeringPrice;
    final List<dynamic> legalDocuments;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;
    final String? countryName;
    final String? description;
    final String? gender;
    final String? vendorImage;
    final String? country;

    factory VendorId.fromJson(Map<String, dynamic> json){ 
        return VendorId(
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
            offeringPrice: (json["offering_price"] as num?)?.toDouble(),
            pincode: json["pincode"],
            vehicleImage: json["vehicle_image"] == null ? [] : List<dynamic>.from(json["vehicle_image"]!.map((x) => x)),
            vendorStatus: json["vendor_status"],
            vendorActiveStatus: json["vendor_active_status"],
            walletAmmount: json["wallet_ammount"],
            geoLocation: json["geo_location"] == null ? null : GeoLocation.fromJson(json["geo_location"]),
            commission: json["Commission"],
            
            legalDocuments: json["legal_documents"] == null ? [] : List<dynamic>.from(json["legal_documents"]!.map((x) => x)),
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
            countryName: json["country_name"],
            description: json["description"],
            gender: json["gender"],
            vendorImage: json["vendor_image"],
            country: json["country"],
        );
    }

    Map<String, dynamic> toJson() => {
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
        "vehicle_image": vehicleImage.map((x) => x).toList(),
        "vendor_status": vendorStatus,
        "vendor_active_status": vendorActiveStatus,
        "wallet_ammount": walletAmmount,
        "geo_location": geoLocation?.toJson(),
        "Commission": commission,
        "offering_price": offeringPrice,
        "legal_documents": legalDocuments.map((x) => x).toList(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "country_name": countryName,
        "description": description,
        "gender": gender,
        "vendor_image": vendorImage,
        "country": country,
    };

}

class GeoLocation {
    GeoLocation({
        required this.coordinates,
    });

    final List<dynamic> coordinates;

    factory GeoLocation.fromJson(Map<String, dynamic> json){ 
        return GeoLocation(
            coordinates: json["coordinates"] == null ? [] : List<dynamic>.from(json["coordinates"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "coordinates": coordinates.map((x) => x).toList(),
    };

}
