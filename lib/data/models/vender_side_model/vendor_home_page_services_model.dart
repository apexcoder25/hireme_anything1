class ServicesModel {
    ServicesModel({
        required this.success,
        required this.message,
        required this.data,
        required this.fromCache,
        required this.processingTime,
    });

    final bool? success;
    final String? message;
    final Data? data;
    final bool? fromCache;
    final String? processingTime;

    factory ServicesModel.fromJson(Map<String, dynamic> json){ 
        return ServicesModel(
            success: json["success"],
            message: json["message"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
            fromCache: json["fromCache"],
            processingTime: json["processingTime"],
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
        "fromCache": fromCache,
        "processingTime": processingTime,
    };

}

class Data {
    Data({
        required this.services,
        required this.totalServices,
        required this.serviceStats,
        required this.vendorId,
    });

    final List<Service> services;
    final int? totalServices;
    final ServiceStats? serviceStats;
    final String? vendorId;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => Service.fromJson(x))),
            totalServices: json["totalServices"],
            serviceStats: json["serviceStats"] == null ? null : ServiceStats.fromJson(json["serviceStats"]),
            vendorId: json["vendorId"],
        );
    }

    Map<String, dynamic> toJson() => {
        "services": services.map((x) => x?.toJson()).toList(),
        "totalServices": totalServices,
        "serviceStats": serviceStats?.toJson(),
        "vendorId": vendorId,
    };

}

class ServiceStats {
    ServiceStats({
        required this.passengerTransport,
    });

    final int? passengerTransport;

    factory ServiceStats.fromJson(Map<String, dynamic> json){ 
        return ServiceStats(
            passengerTransport: json["Passenger Transport"],
        );
    }

    Map<String, dynamic> toJson() => {
        "Passenger Transport": passengerTransport,
    };

}

class Service {
    Service({
        required this.id,
        required this.categoryId,
        required this.subcategoryId,
        required this.serviceServiceName,
        required this.fleetInfo,
        required this.navigableRoutes,
        required this.boatRates,
        required this.serviceImage,
        required this.serviceStatus,
        required this.serviceApproveStatus,
        required this.createdAt,
        required this.serviceType,
        required this.serviceName,
        required this.serviceName2,

        required this.serviceDetails,
        required this.equipmentSafety,
        required this.licensingInsurance,
        required this.marketing,
        required this.bookingAvailability,
        required this.serviceAreas,
        required this.availabilityPeriod,
        required this.specialPriceDays,
        required this.pricing,
        required this.coupons,
        required this.images,
        required this.pricingDetails,
        required this.areasCovered,
        required this.fleetDetails,
        required this.uploadedDocuments,
        required this.seatBeltsInAllVehicles,
        required this.miniBusRates,
        required this.occasionsCovered,
        required this.serviceFleetDetails,
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
        required this.bookingDateFrom,
        required this.bookingDateTo,
        required this.servicesProvided,
        required this.serviceBookingDateFrom,
        required this.serviceBookingDateTo,
        required this.serviceSpecialPriceDays,
        required this.offeringPrice,
        required this.operatingHours,
        required this.basePostcode,
        required this.bookingTypes,
        required this.fleetSize,
        required this.brandingLogoRemoval,
        required this.comfort,
        required this.events,
        required this.accessibility,
        required this.security,
        required this.driverDetails,
        required this.licensing,
        required this.documents,
        required this.serviceHighlights,
        required this.promotionalDescription,
        required this.cancellationPolicyType,
        required this.documentation,
        required this.otherOccasions,
    });

    final String? id;
    final CategoryId? categoryId;
    final SubcategoryId? subcategoryId;
    final String? serviceServiceName;
    final FleetInfo? fleetInfo;
    final List<String> navigableRoutes;
    final BoatRates? boatRates;
    final List<String> serviceImage;
    final String? serviceStatus;
    final dynamic? serviceApproveStatus;
    final DateTime? createdAt;
    final String? serviceType;
    final String? serviceName;
     final String? serviceName2;
    final ServiceDetails? serviceDetails;
    final EquipmentSafety? equipmentSafety;
    final LicensingInsurance? licensingInsurance;
    final Marketing? marketing;
    final BookingAvailability? bookingAvailability;
    final List<String> serviceAreas;
    final AvailabilityPeriod? availabilityPeriod;
    final List<dynamic> specialPriceDays;
    final Pricing? pricing;
    final List<Coupon> coupons;
    final List<String> images;
    final PricingDetails? pricingDetails;
    final List<String> areasCovered;
    final FleetDetails? fleetDetails;
    final UploadedDocuments? uploadedDocuments;
    final bool? seatBeltsInAllVehicles;
    final MiniBusRates? miniBusRates;
    final List<String> occasionsCovered;
    final List<FleetDetail> serviceFleetDetails;
    final Features? features;
    final FeaturePricing? featurePricing;
    final int? fullDayRate;
    final int? hourlyRate;
    final int? halfDayRate;
    final int? weddingPackageRate;
    final int? airportTransferRate;
    final bool? fuelIncluded;
    final int? mileageCapLimit;
    final int? mileageCapExcessCharge;
    final DateTime? bookingDateFrom;
    final DateTime? bookingDateTo;
    final ServicesProvided? servicesProvided;
    final String? serviceBookingDateFrom;
    final String? serviceBookingDateTo;
    final List<dynamic> serviceSpecialPriceDays;
    final int? offeringPrice;
    final OperatingHours? operatingHours;
    final String? basePostcode;
    final BookingTypes? bookingTypes;
    final int? fleetSize;
    final String? brandingLogoRemoval;
    final Comfort? comfort;
    final Events? events;
    final Accessibility? accessibility;
    final Security? security;
    final DriverDetails? driverDetails;
    final Licensing? licensing;
    final Documents? documents;
    final String? serviceHighlights;
    final String? promotionalDescription;
    final String? cancellationPolicyType;
    final Documentation? documentation;
    final String? otherOccasions;
factory Service.fromJson(Map<String, dynamic> json) {
  return Service(
    id: json["_id"],
    categoryId: json["categoryId"] == null ? null : CategoryId.fromJson(json["categoryId"]),
    subcategoryId: json["subcategoryId"] == null ? null : SubcategoryId.fromJson(json["subcategoryId"]),
    serviceServiceName: json["service_name"],
    fleetInfo: json["fleetInfo"] == null ? null : FleetInfo.fromJson(json["fleetInfo"]),
    navigableRoutes: json["navigableRoutes"] == null ? [] : List<String>.from(json["navigableRoutes"]!.map((x) => x)),
    boatRates: json["boatRates"] == null ? null : BoatRates.fromJson(json["boatRates"]),
    serviceImage: json["service_image"] == null ? [] : List<String>.from(json["service_image"]!.map((x) => x)),
    serviceStatus: json["service_status"],
    serviceApproveStatus: json["service_approve_status"],
    createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
    serviceType: json["serviceType"],
    serviceName: json["serviceName"],
    serviceName2: json["service_name"],
    serviceDetails: json["serviceDetails"] == null ? null : ServiceDetails.fromJson(json["serviceDetails"]),
    equipmentSafety: json["equipmentSafety"] == null ? null : EquipmentSafety.fromJson(json["equipmentSafety"]),
    licensingInsurance: json["licensingInsurance"] == null ? null : LicensingInsurance.fromJson(json["licensingInsurance"]),
    marketing: json["marketing"] == null ? null : Marketing.fromJson(json["marketing"]),
    bookingAvailability: json["bookingAvailability"] == null ? null : BookingAvailability.fromJson(json["bookingAvailability"]),
    serviceAreas: json["serviceAreas"] == null ? [] : List<String>.from(json["serviceAreas"]!.map((x) => x)),
    availabilityPeriod: json["availabilityPeriod"] == null ? null : AvailabilityPeriod.fromJson(json["availabilityPeriod"]),
    specialPriceDays: json["specialPriceDays"] == null ? [] : List<dynamic>.from(json["specialPriceDays"]!.map((x) => x)),
    pricing: json["pricing"] == null ? null : Pricing.fromJson(json["pricing"]),
    coupons: json["coupons"] == null ? [] : List<Coupon>.from(json["coupons"]!.map((x) => Coupon.fromJson(x))),
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    pricingDetails: json["pricingDetails"] == null ? null : PricingDetails.fromJson(json["pricingDetails"]),
    areasCovered: json["areasCovered"] == null ? [] : List<String>.from(json["areasCovered"]!.map((x) => x)),
    fleetDetails: json["fleetDetails"] == null ? null : FleetDetails.fromJson(json["fleetDetails"]),
    uploadedDocuments: json["uploaded_Documents"] == null ? null : UploadedDocuments.fromJson(json["uploaded_Documents"]),
    seatBeltsInAllVehicles: json["seatBeltsInAllVehicles"],
    miniBusRates: json["miniBusRates"] == null ? null : MiniBusRates.fromJson(json["miniBusRates"]),
    occasionsCovered: json["occasionsCovered"] == null ? [] : List<String>.from(json["occasionsCovered"]!.map((x) => x)),
    serviceFleetDetails: json["fleet_details"] == null ? [] : List<FleetDetail>.from(json["fleet_details"]!.map((x) => FleetDetail.fromJson(x))),
    features: json["features"] == null ? null : Features.fromJson(json["features"]),
    featurePricing: json["featurePricing"] == null ? null : FeaturePricing.fromJson(json["featurePricing"]),
    fullDayRate: json["fullDayRate"],
    hourlyRate: (json["hourlyRate"] is int)
    ? json["hourlyRate"]
    : (json["hourlyRate"] is double)
        ? (json["hourlyRate"] as double).toInt()
        : null,

    halfDayRate: json["halfDayRate"],
    weddingPackageRate: json["weddingPackageRate"],
    airportTransferRate: json["airportTransferRate"],
    fuelIncluded: json["fuelIncluded"],
    mileageCapLimit: json["mileageCapLimit"],
    mileageCapExcessCharge: json["mileageCapExcessCharge"],
    bookingDateFrom: DateTime.tryParse(json["bookingDateFrom"] ?? ""),
    bookingDateTo: DateTime.tryParse(json["bookingDateTo"] ?? ""),
    servicesProvided: json["servicesProvided"] == null ? null : ServicesProvided.fromJson(json["servicesProvided"]),
    serviceBookingDateFrom: json["booking_date_from"],
    serviceBookingDateTo: json["booking_date_to"],
    serviceSpecialPriceDays: json["special_price_days"] == null ? [] : List<dynamic>.from(json["special_price_days"]!.map((x) => x)),
    offeringPrice: json["offering_price"],
    operatingHours: json["operatingHours"] == null ? null : OperatingHours.fromJson(json["operatingHours"]),
    basePostcode: json["basePostcode"],
    bookingTypes: json["bookingTypes"] == null ? null : BookingTypes.fromJson(json["bookingTypes"]),
    fleetSize: json["fleetSize"],
    brandingLogoRemoval: json["brandingLogoRemoval"],
    comfort: json["comfort"] == null ? null : Comfort.fromJson(json["comfort"]),
    events: json["events"] == null ? null : Events.fromJson(json["events"]),
    accessibility: json["accessibility"] == null ? null : Accessibility.fromJson(json["accessibility"]),
    security: json["security"] == null ? null : Security.fromJson(json["security"]),
    driverDetails: json["driverDetails"] == null ? null : DriverDetails.fromJson(json["driverDetails"]),
    licensing: json["licensing"] == null ? null : Licensing.fromJson(json["licensing"]),
    documents: json["documents"] is Map<String, dynamic> ? Documents.fromJson(json["documents"]) : null,
    serviceHighlights: json["serviceHighlights"],
    promotionalDescription: json["promotionalDescription"],
    cancellationPolicyType: json["cancellation_policy_type"],
    documentation: json["documentation"] == null ? null : Documentation.fromJson(json["documentation"]),
    otherOccasions: json["otherOccasions"],
  );
}
    Map<String, dynamic> toJson() => {
        "_id": id,
        "categoryId": categoryId?.toJson(),
        "subcategoryId": subcategoryId?.toJson(),
        "service_name": serviceServiceName,
        "fleetInfo": fleetInfo?.toJson(),
        "navigableRoutes": navigableRoutes.map((x) => x).toList(),
        "boatRates": boatRates?.toJson(),
        "service_image": serviceImage.map((x) => x).toList(),
        "service_status": serviceStatus,
        "service_approve_status": serviceApproveStatus,
        "createdAt": createdAt?.toIso8601String(),
        "serviceType": serviceType,
        "serviceName": serviceName,
        "serviceName2":serviceName2,
        "serviceDetails": serviceDetails?.toJson(),
        "equipmentSafety": equipmentSafety?.toJson(),
        "licensingInsurance": licensingInsurance?.toJson(),
        "marketing": marketing?.toJson(),
        "bookingAvailability": bookingAvailability?.toJson(),
        "serviceAreas": serviceAreas.map((x) => x).toList(),
        "availabilityPeriod": availabilityPeriod?.toJson(),
        "specialPriceDays": specialPriceDays.map((x) => x).toList(),
        "pricing": pricing?.toJson(),
        "coupons": coupons.map((x) => x?.toJson()).toList(),
        "images": images.map((x) => x).toList(),
        "pricingDetails": pricingDetails?.toJson(),
        "areasCovered": areasCovered.map((x) => x).toList(),
        "fleetDetails": fleetDetails?.toJson(),
        "uploaded_Documents": uploadedDocuments?.toJson(),
        "seatBeltsInAllVehicles": seatBeltsInAllVehicles,
        "miniBusRates": miniBusRates?.toJson(),
        "occasionsCovered": occasionsCovered.map((x) => x).toList(),
        "fleet_details": serviceFleetDetails.map((x) => x?.toJson()).toList(),
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
        "bookingDateFrom": bookingDateFrom?.toIso8601String(),
        "bookingDateTo": bookingDateTo?.toIso8601String(),
        "servicesProvided": servicesProvided?.toJson(),
        "booking_date_from": serviceBookingDateFrom,
        "booking_date_to": serviceBookingDateTo,
        "special_price_days": serviceSpecialPriceDays.map((x) => x).toList(),
        "offering_price": offeringPrice,
        "operatingHours": operatingHours?.toJson(),
        "basePostcode": basePostcode,
        "bookingTypes": bookingTypes?.toJson(),
        "fleetSize": fleetSize,
        "brandingLogoRemoval": brandingLogoRemoval,
        "comfort": comfort?.toJson(),
        "events": events?.toJson(),
        "accessibility": accessibility?.toJson(),
        "security": security?.toJson(),
        "driverDetails": driverDetails?.toJson(),
        "licensing": licensing?.toJson(),
        "documents": documents?.toJson(),
        "serviceHighlights": serviceHighlights,
        "promotionalDescription": promotionalDescription,
        "cancellation_policy_type": cancellationPolicyType,
        "documentation": documentation?.toJson(),
        "otherOccasions": otherOccasions,
    };

}

class Accessibility {
    Accessibility({
        required this.wheelchairAccessVehicle,
        required this.wheelchairAccessPrice,
        required this.childCarSeats,
        required this.childCarSeatsPrice,
        required this.petFriendlyService,
        required this.petFriendlyPrice,
        required this.disabledAccessRamp,
        required this.disabledAccessRampPrice,
        required this.seniorFriendlyAssistance,
        required this.seniorAssistancePrice,
        required this.strollerBuggyStorage,
        required this.strollerStoragePrice,
    });

    final bool? wheelchairAccessVehicle;
    final int? wheelchairAccessPrice;
    final bool? childCarSeats;
    final int? childCarSeatsPrice;
    final bool? petFriendlyService;
    final int? petFriendlyPrice;
    final bool? disabledAccessRamp;
    final int? disabledAccessRampPrice;
    final bool? seniorFriendlyAssistance;
    final int? seniorAssistancePrice;
    final bool? strollerBuggyStorage;
    final int? strollerStoragePrice;

    factory Accessibility.fromJson(Map<String, dynamic> json){ 
        return Accessibility(
            wheelchairAccessVehicle: json["wheelchairAccessVehicle"],
            wheelchairAccessPrice: json["wheelchairAccessPrice"],
            childCarSeats: json["childCarSeats"],
            childCarSeatsPrice: json["childCarSeatsPrice"],
            petFriendlyService: json["petFriendlyService"],
            petFriendlyPrice: json["petFriendlyPrice"],
            disabledAccessRamp: json["disabledAccessRamp"],
            disabledAccessRampPrice: json["disabledAccessRampPrice"],
            seniorFriendlyAssistance: json["seniorFriendlyAssistance"],
            seniorAssistancePrice: json["seniorAssistancePrice"],
            strollerBuggyStorage: json["strollerBuggyStorage"],
            strollerStoragePrice: json["strollerStoragePrice"],
        );
    }

    Map<String, dynamic> toJson() => {
        "wheelchairAccessVehicle": wheelchairAccessVehicle,
        "wheelchairAccessPrice": wheelchairAccessPrice,
        "childCarSeats": childCarSeats,
        "childCarSeatsPrice": childCarSeatsPrice,
        "petFriendlyService": petFriendlyService,
        "petFriendlyPrice": petFriendlyPrice,
        "disabledAccessRamp": disabledAccessRamp,
        "disabledAccessRampPrice": disabledAccessRampPrice,
        "seniorFriendlyAssistance": seniorFriendlyAssistance,
        "seniorAssistancePrice": seniorAssistancePrice,
        "strollerBuggyStorage": strollerBuggyStorage,
        "strollerStoragePrice": strollerStoragePrice,
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

class BoatRates {
    BoatRates({
        required this.hourlyRate,
        required this.halfDayRate,
        required this.fullDayRate,
        required this.overnightCharterRate,
        required this.packageDealsDescription,
    });

    final int? hourlyRate;
    final int? halfDayRate;
    final int? fullDayRate;
    final int? overnightCharterRate;
    final String? packageDealsDescription;

    factory BoatRates.fromJson(Map<String, dynamic> json){ 
        return BoatRates(
            hourlyRate: json["hourlyRate"],
            halfDayRate: json["halfDayRate"],
            fullDayRate: json["fullDayRate"],
            overnightCharterRate: json["overnightCharterRate"],
            packageDealsDescription: json["packageDealsDescription"],
        );
    }

    Map<String, dynamic> toJson() => {
        "hourlyRate": hourlyRate,
        "halfDayRate": halfDayRate,
        "fullDayRate": fullDayRate,
        "overnightCharterRate": overnightCharterRate,
        "packageDealsDescription": packageDealsDescription,
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

class CategoryId {
    CategoryId({
        required this.id,
        required this.categoryName,
    });

    final String? id;
    final String? categoryName;

    factory CategoryId.fromJson(Map<String, dynamic> json){ 
        return CategoryId(
            id: json["_id"],
            categoryName: json["category_name"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "category_name": categoryName,
    };

}

class Comfort {
    Comfort({
        required this.leatherInterior,
        required this.wifiAccess,
        required this.airConditioning,
        required this.complimentaryDrinks,
        required this.inCarEntertainment,
        required this.bluetoothUsb,
        required this.redCarpetService,
        required this.onboardRestroom,
    });

    final bool? leatherInterior;
    final bool? wifiAccess;
    final bool? airConditioning;
    final ComplimentaryDrinks? complimentaryDrinks;
    final bool? inCarEntertainment;
    final bool? bluetoothUsb;
    final bool? redCarpetService;
    final bool? onboardRestroom;

    factory Comfort.fromJson(Map<String, dynamic> json){ 
        return Comfort(
            leatherInterior: json["leatherInterior"],
            wifiAccess: json["wifiAccess"],
            airConditioning: json["airConditioning"],
            complimentaryDrinks: json["complimentaryDrinks"] == null ? null : ComplimentaryDrinks.fromJson(json["complimentaryDrinks"]),
            inCarEntertainment: json["inCarEntertainment"],
            bluetoothUsb: json["bluetoothUsb"],
            redCarpetService: json["redCarpetService"],
            onboardRestroom: json["onboardRestroom"],
        );
    }

    Map<String, dynamic> toJson() => {
        "leatherInterior": leatherInterior,
        "wifiAccess": wifiAccess,
        "airConditioning": airConditioning,
        "complimentaryDrinks": complimentaryDrinks?.toJson(),
        "inCarEntertainment": inCarEntertainment,
        "bluetoothUsb": bluetoothUsb,
        "redCarpetService": redCarpetService,
        "onboardRestroom": onboardRestroom,
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
    final int? discountValue;
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

class Documents {
  Documents({
    required this.psvOperatorLicence,
    required this.publicLiabilityInsurance,
    required this.driverLicencesAndDbs,
    required this.vehicleMotAndInsurance,
    required this.animalLicense,
    required this.riskAssessment,
  });

  final DriverLicencesAndDbs? psvOperatorLicence;
  final DriverLicencesAndDbs? publicLiabilityInsurance;
  final DriverLicencesAndDbs? driverLicencesAndDbs;
  final DriverLicencesAndDbs? vehicleMotAndInsurance;
  final DriverLicencesAndDbs? animalLicense;
  final DriverLicencesAndDbs? riskAssessment;

  static DriverLicencesAndDbs? _parseDoc(dynamic value) {
    if (value is Map<String, dynamic>) {
      return DriverLicencesAndDbs.fromJson(value);
    } else if (value is String) {
      return DriverLicencesAndDbs.fromUrl(value);
    }
    return null;
  }

  factory Documents.fromJson(Map<String, dynamic> json) {
    return Documents(
      psvOperatorLicence: _parseDoc(json["psvOperatorLicence"]),
      publicLiabilityInsurance: _parseDoc(json["publicLiabilityInsurance"]),
      driverLicencesAndDbs: _parseDoc(json["driverLicencesAndDBS"]),
      vehicleMotAndInsurance: _parseDoc(json["vehicleMOTAndInsurance"]),
      animalLicense: _parseDoc(json["animalLicense"]),
      riskAssessment: _parseDoc(json["riskAssessment"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "psvOperatorLicence": psvOperatorLicence?.toJson(),
        "publicLiabilityInsurance": publicLiabilityInsurance?.toJson(),
        "driverLicencesAndDBS": driverLicencesAndDbs?.toJson(),
        "vehicleMOTAndInsurance": vehicleMotAndInsurance?.toJson(),
        "animalLicense": animalLicense?.toJson(),
        "riskAssessment": riskAssessment?.toJson(),
      };
}

class DriverLicencesAndDbs {
  DriverLicencesAndDbs({
    this.isAttached,
    required this.image,
  });

  final bool? isAttached;
  final String? image;

  factory DriverLicencesAndDbs.fromJson(Map<String, dynamic> json) {
    return DriverLicencesAndDbs(
      isAttached: json["isAttached"],
      image: json["image"],
    );
  }

  factory DriverLicencesAndDbs.fromUrl(String url) {
    return DriverLicencesAndDbs(
      isAttached: true,
      image: url,
    );
  }

  Map<String, dynamic> toJson() => {
        "isAttached": isAttached,
        "image": image,
      };
}



class DriverDetails {
    DriverDetails({
        required this.fullyLicensed,
        required this.dbsChecked,
        required this.wearUniforms,
        required this.languagesSpoken,
    });

    final bool? fullyLicensed;
    final bool? dbsChecked;
    final bool? wearUniforms;
    final String? languagesSpoken;

    factory DriverDetails.fromJson(Map<String, dynamic> json){ 
        return DriverDetails(
            fullyLicensed: json["fullyLicensed"],
            dbsChecked: json["dbsChecked"],
            wearUniforms: json["wearUniforms"],
            languagesSpoken: json["languagesSpoken"],
        );
    }

    Map<String, dynamic> toJson() => {
        "fullyLicensed": fullyLicensed,
        "dbsChecked": dbsChecked,
        "wearUniforms": wearUniforms,
        "languagesSpoken": languagesSpoken,
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

class Events {
    Events({
        required this.weddingDecor,
        required this.weddingDecorPrice,
        required this.partyLightingSystem,
        required this.partyLightingPrice,
        required this.champagnePackages,
        required this.champagnePackagePrice,
        required this.photographyPackages,
        required this.photographyPackagePrice,
    });

    final bool? weddingDecor;
    final int? weddingDecorPrice;
    final bool? partyLightingSystem;
    final int? partyLightingPrice;
    final bool? champagnePackages;
    final int? champagnePackagePrice;
    final bool? photographyPackages;
    final int? photographyPackagePrice;

    factory Events.fromJson(Map<String, dynamic> json){ 
        return Events(
            weddingDecor: json["weddingDecor"],
            weddingDecorPrice: json["weddingDecorPrice"],
            partyLightingSystem: json["partyLightingSystem"],
            partyLightingPrice: json["partyLightingPrice"],
            champagnePackages: json["champagnePackages"],
            champagnePackagePrice: json["champagnePackagePrice"],
            photographyPackages: json["photographyPackages"],
            photographyPackagePrice: json["photographyPackagePrice"],
        );
    }

    Map<String, dynamic> toJson() => {
        "weddingDecor": weddingDecor,
        "weddingDecorPrice": weddingDecorPrice,
        "partyLightingSystem": partyLightingSystem,
        "partyLightingPrice": partyLightingPrice,
        "champagnePackages": champagnePackages,
        "champagnePackagePrice": champagnePackagePrice,
        "photographyPackages": photographyPackages,
        "photographyPackagePrice": photographyPackagePrice,
    };

}

class FeaturePricing {
    FeaturePricing({
        required this.eventsAndCustomization,
        required this.accessibilityServices,
    });

    final EventsAndCustomization? eventsAndCustomization;
    final AccessibilityServices? accessibilityServices;

    factory FeaturePricing.fromJson(Map<String, dynamic> json){ 
        return FeaturePricing(
            eventsAndCustomization: json["eventsAndCustomization"] == null ? null : EventsAndCustomization.fromJson(json["eventsAndCustomization"]),
            accessibilityServices: json["accessibilityServices"] == null ? null : AccessibilityServices.fromJson(json["accessibilityServices"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "eventsAndCustomization": eventsAndCustomization?.toJson(),
        "accessibilityServices": accessibilityServices?.toJson(),
    };

}

class AccessibilityServices {
    AccessibilityServices({
        required this.wheelchairAccess,
        required this.childCarSeats,
        required this.luggageRackRoofBox,
        required this.petFriendlyService,
    });

    final int? wheelchairAccess;
    final int? childCarSeats;
    final int? luggageRackRoofBox;
    final int? petFriendlyService;

    factory AccessibilityServices.fromJson(Map<String, dynamic> json){ 
        return AccessibilityServices(
            wheelchairAccess: json["WheelchairAccess"],
            childCarSeats: json["ChildCarSeats"],
            luggageRackRoofBox: json["LuggageRack/RoofBox"],
            petFriendlyService: json["Pet-FriendlyService"],
        );
    }

    Map<String, dynamic> toJson() => {
        "WheelchairAccess": wheelchairAccess,
        "ChildCarSeats": childCarSeats,
        "LuggageRack/RoofBox": luggageRackRoofBox,
        "Pet-FriendlyService": petFriendlyService,
    };

}

class EventsAndCustomization {
    EventsAndCustomization({
        required this.redCarpetService,
        required this.champagnePackages,
        required this.floralDcor,
        required this.themedInteriors,
        required this.partyPackages,
    });

    final int? redCarpetService;
    final int? champagnePackages;
    final int? floralDcor;
    final int? themedInteriors;
    final int? partyPackages;

    factory EventsAndCustomization.fromJson(Map<String, dynamic> json){ 
        return EventsAndCustomization(
            redCarpetService: json["RedCarpetService"],
            champagnePackages: json["ChampagnePackages"],
            floralDcor: json["FloralDécor"],
            themedInteriors: json["ThemedInteriors"],
            partyPackages: json["PartyPackages"],
        );
    }

    Map<String, dynamic> toJson() => {
        "RedCarpetService": redCarpetService,
        "ChampagnePackages": champagnePackages,
        "FloralDécor": floralDcor,
        "ThemedInteriors": themedInteriors,
        "PartyPackages": partyPackages,
    };

}

class Features {
    Features({
        required this.comfortAndLuxury,
        required this.eventsAndCustomization,
        required this.accessibilityServices,
        required this.safetyAndCompliance,
    });

    final List<String> comfortAndLuxury;
    final List<String> eventsAndCustomization;
    final List<String> accessibilityServices;
    final List<String> safetyAndCompliance;

    factory Features.fromJson(Map<String, dynamic> json){ 
        return Features(
            comfortAndLuxury: json["comfortAndLuxury"] == null ? [] : List<String>.from(json["comfortAndLuxury"]!.map((x) => x)),
            eventsAndCustomization: json["eventsAndCustomization"] == null ? [] : List<String>.from(json["eventsAndCustomization"]!.map((x) => x)),
            accessibilityServices: json["accessibilityServices"] == null ? [] : List<String>.from(json["accessibilityServices"]!.map((x) => x)),
            safetyAndCompliance: json["safetyAndCompliance"] == null ? [] : List<String>.from(json["safetyAndCompliance"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "comfortAndLuxury": comfortAndLuxury.map((x) => x).toList(),
        "eventsAndCustomization": eventsAndCustomization.map((x) => x).toList(),
        "accessibilityServices": accessibilityServices.map((x) => x).toList(),
        "safetyAndCompliance": safetyAndCompliance.map((x) => x).toList(),
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
        required this.boatName,
        required this.type,
        required this.capacity,
        required this.onboardFeatures,
        required this.year,
        required this.notes,
        required this.makeAndModel,
        required this.wheelchairAccessible,
        required this.airConditioning,
        required this.luggageSpace,
        required this.onboardFacilities,
    });

    final String? boatName;
    final String? type;
    final int? capacity;
    final String? onboardFeatures;
    final int? year;
    final String? notes;
    final String? makeAndModel;
    final bool? wheelchairAccessible;
    final bool? airConditioning;
    final bool? luggageSpace;
    final String? onboardFacilities;

    factory FleetInfo.fromJson(Map<String, dynamic> json){ 
        return FleetInfo(
            boatName: json["boatName"],
            type: json["type"],
            capacity: json["capacity"],
            onboardFeatures: json["onboardFeatures"],
            year: json["year"],
            notes: json["notes"],
            makeAndModel: json["makeAndModel"],
            wheelchairAccessible: json["wheelchairAccessible"],
            airConditioning: json["airConditioning"],
            luggageSpace: json["luggageSpace"],
            onboardFacilities: json["onboardFacilities"],
        );
    }

    Map<String, dynamic> toJson() => {
        "boatName": boatName,
        "type": type,
        "capacity": capacity,
        "onboardFeatures": onboardFeatures,
        "year": year,
        "notes": notes,
        "makeAndModel": makeAndModel,
        "wheelchairAccessible": wheelchairAccessible,
        "airConditioning": airConditioning,
        "luggageSpace": luggageSpace,
        "onboardFacilities": onboardFacilities,
    };

}

class Licensing {
    Licensing({
        required this.psvOperatorLicenceNumber,
        required this.licensingAuthority,
        required this.publicLiabilityInsuranceProvider,
        required this.policyNumber,
        required this.expiryDate,
    });

    final String? psvOperatorLicenceNumber;
    final String? licensingAuthority;
    final String? publicLiabilityInsuranceProvider;
    final String? policyNumber;
    final DateTime? expiryDate;

    factory Licensing.fromJson(Map<String, dynamic> json){ 
        return Licensing(
            psvOperatorLicenceNumber: json["psvOperatorLicenceNumber"],
            licensingAuthority: json["licensingAuthority"],
            publicLiabilityInsuranceProvider: json["publicLiabilityInsuranceProvider"],
            policyNumber: json["policyNumber"],
            expiryDate: DateTime.tryParse(json["expiryDate"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "psvOperatorLicenceNumber": psvOperatorLicenceNumber,
        "licensingAuthority": licensingAuthority,
        "publicLiabilityInsuranceProvider": publicLiabilityInsuranceProvider,
        "policyNumber": policyNumber,
        "expiryDate": expiryDate?.toIso8601String(),
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

    final int? hourlyRate;
    final int? halfDayRate;
    final int? fullDayRate;
    final int? mileageAllowance;
    final int? additionalMileageFee;

    factory MiniBusRates.fromJson(Map<String, dynamic> json){ 
        return MiniBusRates(
            hourlyRate: json["hourlyRate"],
            halfDayRate: json["halfDayRate"],
            fullDayRate: json["fullDayRate"],
            mileageAllowance: json["mileageAllowance"],
            additionalMileageFee: json["additionalMileageFee"],
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

class OperatingHours {
    OperatingHours({
        required this.available24X7,
        required this.specificTimes,
    });

    final bool? available24X7;
    final String? specificTimes;

    factory OperatingHours.fromJson(Map<String, dynamic> json){ 
        return OperatingHours(
            available24X7: json["available24x7"],
            specificTimes: json["specificTimes"],
        );
    }

    Map<String, dynamic> toJson() => {
        "available24x7": available24X7,
        "specificTimes": specificTimes,
    };

}

class Pricing {
    Pricing({
        required this.hourlyRate,
        required this.halfDayRate,
        required this.fullDayRate,
        required this.ceremonyPackageRate,
        required this.perMileCharge,
    });

    final int? hourlyRate;
    final int? halfDayRate;
    final int? fullDayRate;
    final int? ceremonyPackageRate;
    final double? perMileCharge;


    factory Pricing.fromJson(Map<String, dynamic> json){ 
        return Pricing(
            hourlyRate: json["hourlyRate"],
            halfDayRate: json["halfDayRate"],
            fullDayRate: json["fullDayRate"],
            ceremonyPackageRate: json["ceremonyPackageRate"],
            perMileCharge: (json["perMileCharge"] as num?)?.toDouble(),

        );
    }

    Map<String, dynamic> toJson() => {
        "hourlyRate": hourlyRate,
        "halfDayRate": halfDayRate,
        "fullDayRate": fullDayRate,
        "ceremonyPackageRate": ceremonyPackageRate,
        "perMileCharge":perMileCharge
    };

}

class PricingDetails {
    PricingDetails({
        required this.dayRate,
        required this.halfDayRate,
        required this.hourlyRate,
        required this.fuelChargesIncluded,
        required this.extraMileageCharge,
        required this.waitTimeFeePerHour,
        required this.decoratingFloralServiceFee,
        required this.mileageLimit,
        required this.fullDayRate,
        required this.multiDayRate,
        required this.depositRequired,
        required this.depositAmount,
        required this.mileageAllowance,
        required this.additionalMileageFee,
    });

    final int? dayRate;
    final int? halfDayRate;
    final int? hourlyRate;
    final bool? fuelChargesIncluded;
    final int? extraMileageCharge;
    final int? waitTimeFeePerHour;
    final int? decoratingFloralServiceFee;
    final int? mileageLimit;
    final int? fullDayRate;
    final int? multiDayRate;
    final bool? depositRequired;
    final int? depositAmount;
    final int? mileageAllowance;
    final int? additionalMileageFee;

    factory PricingDetails.fromJson(Map<String, dynamic> json){ 
        return PricingDetails(
            dayRate: json["dayRate"],
            halfDayRate: json["halfDayRate"],
            hourlyRate: json["hourlyRate"],
            fuelChargesIncluded: json["fuelChargesIncluded"],
            extraMileageCharge: json["extraMileageCharge"],
            waitTimeFeePerHour: json["waitTimeFeePerHour"],
            decoratingFloralServiceFee: json["decoratingFloralServiceFee"],
            mileageLimit: json["mileageLimit"],
            fullDayRate: json["fullDayRate"],
            multiDayRate: json["multiDayRate"],
            depositRequired: json["depositRequired"],
            depositAmount: json["depositAmount"],
            mileageAllowance: json["mileageAllowance"],
            additionalMileageFee: json["additionalMileageFee"],
        );
    }

    Map<String, dynamic> toJson() => {
        "dayRate": dayRate,
        "halfDayRate": halfDayRate,
        "hourlyRate": hourlyRate,
        "fuelChargesIncluded": fuelChargesIncluded,
        "extraMileageCharge": extraMileageCharge,
        "waitTimeFeePerHour": waitTimeFeePerHour,
        "decoratingFloralServiceFee": decoratingFloralServiceFee,
        "mileageLimit": mileageLimit,
        "fullDayRate": fullDayRate,
        "multiDayRate": multiDayRate,
        "depositRequired": depositRequired,
        "depositAmount": depositAmount,
        "mileageAllowance": mileageAllowance,
        "additionalMileageFee": additionalMileageFee,
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

class ServiceDetails {
    ServiceDetails({
        required this.occasionsCatered,
        required this.carriageTypes,
        required this.horseTypes,
        required this.numberOfCarriages,
        required this.fleetSize,
        required this.basePostcode,
        required this.mileage,
        required this.otherOccasion,
        required  this.otherHorseType,
        required this.otherCarriageType,
    });

    final List<String> occasionsCatered;
    final List<String> carriageTypes;
    final List<String> horseTypes;
    final int? numberOfCarriages;
    final int? fleetSize;
    final String? basePostcode;
    final int? mileage;
    final String? otherOccasion;
    final String? otherHorseType;
    final String? otherCarriageType;

    factory ServiceDetails.fromJson(Map<String, dynamic> json){ 
        return ServiceDetails(
            occasionsCatered: json["occasionsCatered"] == null ? [] : List<String>.from(json["occasionsCatered"]!.map((x) => x)),
            carriageTypes: json["carriageTypes"] == null ? [] : List<String>.from(json["carriageTypes"]!.map((x) => x)),
            horseTypes: json["horseTypes"] == null ? [] : List<String>.from(json["horseTypes"]!.map((x) => x)),
            numberOfCarriages: json["numberOfCarriages"],
            fleetSize: json["fleetSize"],
            basePostcode: json["basePostcode"],
            mileage: json["mileage"],
            otherOccasion: json["otherOccasion"],
            otherCarriageType: json["otherCarriageType"],
            otherHorseType: json["otherHorseType"],
        );
    }

    Map<String, dynamic> toJson() => {
        "occasionsCatered": occasionsCatered.map((x) => x).toList(),
        "carriageTypes": carriageTypes.map((x) => x).toList(),
        "horseTypes": horseTypes.map((x) => x).toList(),
        "numberOfCarriages": numberOfCarriages,
        "fleetSize": fleetSize,
        "basePostcode": basePostcode,
        "mileage": mileage,
        "otherOccasion":otherOccasion,
        "otherCarriageType":otherCarriageType,
        "otherHorseType":otherHorseType

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

class ServicesProvided {
    ServicesProvided({
        required this.schoolTrips,
        required this.corporateTransport,
        required this.privateGroupTours,
        required this.airportTransfers,
        required this.longDistanceTravel,
        required this.weddingOrEventTransport,
        required this.shuttleServices,
        required this.accessibleCoachHire,
        required this.other,
        required this.otherSpecified,
    });

    final bool? schoolTrips;
    final bool? corporateTransport;
    final bool? privateGroupTours;
    final bool? airportTransfers;
    final bool? longDistanceTravel;
    final bool? weddingOrEventTransport;
    final bool? shuttleServices;
    final bool? accessibleCoachHire;
    final bool? other;
    final String? otherSpecified;

    factory ServicesProvided.fromJson(Map<String, dynamic> json){ 
        return ServicesProvided(
            schoolTrips: json["schoolTrips"],
            corporateTransport: json["corporateTransport"],
            privateGroupTours: json["privateGroupTours"],
            airportTransfers: json["airportTransfers"],
            longDistanceTravel: json["longDistanceTravel"],
            weddingOrEventTransport: json["weddingOrEventTransport"],
            shuttleServices: json["shuttleServices"],
            accessibleCoachHire: json["accessibleCoachHire"],
            other: json["other"],
            otherSpecified: json["otherSpecified"],
        );
    }

    Map<String, dynamic> toJson() => {
        "schoolTrips": schoolTrips,
        "corporateTransport": corporateTransport,
        "privateGroupTours": privateGroupTours,
        "airportTransfers": airportTransfers,
        "longDistanceTravel": longDistanceTravel,
        "weddingOrEventTransport": weddingOrEventTransport,
        "shuttleServices": shuttleServices,
        "accessibleCoachHire": accessibleCoachHire,
        "other": other,
        "otherSpecified": otherSpecified,
    };

}

class SubcategoryId {
    SubcategoryId({
        required this.id,
        required this.subcategoryName,
    });

    final String? id;
    final String? subcategoryName;

    factory SubcategoryId.fromJson(Map<String, dynamic> json){ 
        return SubcategoryId(
            id: json["_id"],
            subcategoryName: json["subcategory_name"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "subcategory_name": subcategoryName,
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
