// To parse this JSON data, do
//
//     final servicesModel = servicesModelFromJson(jsonString);

import 'dart:convert';

ServicesModel servicesModelFromJson(String str) => ServicesModel.fromJson(json.decode(str));

String servicesModelToJson(ServicesModel data) => json.encode(data.toJson());

// Helpers to safely parse numeric JSON values (server may send ints or doubles)
int _toInt(dynamic v) {
    if (v == null) return 0;
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse(v.toString()) ?? 0;
}

int? _toNullableInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse(v.toString());
}

double _toDouble(dynamic v) {
    if (v == null) return 0.0;
    if (v is double) return v;
    if (v is int) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0.0;
}

double? _toNullableDouble(dynamic v) {
    if (v == null) return null;
    if (v is double) return v;
    if (v is int) return v.toDouble();
    return double.tryParse(v.toString());
}

class ServicesModel {
    bool success;
    String message;
    Data data;
    bool fromCache;
    String processingTime;

    ServicesModel({
        required this.success,
        required this.message,
        required this.data,
        required this.fromCache,
        required this.processingTime,
    });

    factory ServicesModel.fromJson(Map<String, dynamic> json) => ServicesModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        fromCache: json["fromCache"],
        processingTime: json["processingTime"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
        "fromCache": fromCache,
        "processingTime": processingTime,
    };
}

class Data {
    List<Service> services;
    int totalServices;
    ServiceStats serviceStats;
    String vendorId;

    Data({
        required this.services,
        required this.totalServices,
        required this.serviceStats,
        required this.vendorId,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        services: json["services"] != null 
            ? List<Service>.from(json["services"].map((x) => Service.fromJson(x)))
            : <Service>[],
        totalServices: _toInt(json["totalServices"]),
        serviceStats: json["serviceStats"] != null 
            ? ServiceStats.fromJson(json["serviceStats"])
            : ServiceStats(passengerTransport: 0),
        vendorId: json["vendorId"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
        "totalServices": totalServices,
        "serviceStats": serviceStats.toJson(),
        "vendorId": vendorId,
    };
}

class ServiceStats {
    int passengerTransport;

    ServiceStats({
        required this.passengerTransport,
    });

    factory ServiceStats.fromJson(Map<String, dynamic> json) => ServiceStats(
        passengerTransport: _toInt(json["Passenger Transport"]),
    );

    Map<String, dynamic> toJson() => {
        "Passenger Transport": passengerTransport,
    };
}

class Service {
    String id;
    CategoryId categoryId;
    SubcategoryId subcategoryId;
    String? serviceName;
    String listingTitle;
    String? basePostcode;
    int? locationRadius;
    PricingDetails? pricingDetails;
    List<dynamic>? accessibilityAndSpecialServices;
    FuneralPackageOptions? funeralPackageOptions;
    DateTime? bookingAvailabilityDateFrom;
    DateTime? bookingAvailabilityDateTo;
    List<SpecialPriceDay>? specialPriceDays;
    List<String>? areasCovered;
    FleetDetails? fleetDetails;
    ServiceDetail? serviceDetail;
    UploadedDocuments? uploadedDocuments;
    List<String>? serviceImages;
    BusinessProfile? businessProfile;
    String? approvalStatus;
    String serviceStatus;
    dynamic serviceApproveStatus;
    CancellationPolicyType? cancellationPolicyType;
    List<Coupon>? coupons;
    DateTime createdAt;
    DateTime? updatedAt;
    String serviceType;
    int? numberOfLimousines;
    FleetInfo? fleetInfo;
    List<String>? fleetFeatures;
    String? baseLocationPostcode;
    String? bookingDateFrom;
    String? bookingDateTo;
    List<String>? serviceImage;
    CarriageDetails? carriageDetails;
    Marketing? marketing;
    Pricing? pricing;
    EquipmentSafety? equipmentSafety;
    int? offeringPrice;
    ServiceComfort? comfort;
    Events? events;
    Accessibility? accessibility;
    Security? security;
    ServiceDocuments? documents;
    Features? features;
    Licensing? licensing;
    Photos? photos;
    String? boatType;
    String? makeAndModel;
    DateTime? firstRegistered;
    LuggageCapacity? luggageCapacity;
    int? seats;
    String? hireType;
    String? departurePoint;
    String? postcode;
    List<String>? serviceCoverage;
    int? mileageRadius;
    BoatRates? boatRates;
    MiniBusRates? miniBusRates;

    Service({
        required this.id,
        required this.categoryId,
        required this.subcategoryId,
        this.serviceName,
        required this.listingTitle,
        this.basePostcode,
        this.locationRadius,
        this.pricingDetails,
        this.accessibilityAndSpecialServices,
        this.funeralPackageOptions,
        this.bookingAvailabilityDateFrom,
        this.bookingAvailabilityDateTo,
        this.specialPriceDays,
        this.areasCovered,
        this.fleetDetails,
        this.serviceDetail,
        this.uploadedDocuments,
        this.serviceImages,
        this.businessProfile,
        this.approvalStatus,
        required this.serviceStatus,
        required this.serviceApproveStatus,
        this.cancellationPolicyType,
        this.coupons,
        required this.createdAt,
        this.updatedAt,
        required this.serviceType,
        this.numberOfLimousines,
        this.fleetInfo,
        this.fleetFeatures,
        this.baseLocationPostcode,
        this.bookingDateFrom,
        this.bookingDateTo,
        this.serviceImage,
        this.carriageDetails,
        this.marketing,
        this.pricing,
        this.equipmentSafety,
        this.offeringPrice,
        this.comfort,
        this.events,
        this.accessibility,
        this.security,
        this.documents,
        this.features,
        this.licensing,
        this.photos,
        this.boatType,
        this.makeAndModel,
        this.firstRegistered,
        this.luggageCapacity,
        this.seats,
        this.hireType,
        this.departurePoint,
        this.postcode,
        this.serviceCoverage,
        this.mileageRadius,
        this.boatRates,
        this.miniBusRates,
    });

    factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["_id"],
        categoryId: CategoryId.fromJson(json["categoryId"]),
        subcategoryId: SubcategoryId.fromJson(json["subcategoryId"]),
        serviceName: json["service_name"],
        listingTitle: json["listingTitle"],
        basePostcode: json["basePostcode"],
        locationRadius: _toInt(json["locationRadius"]),
        pricingDetails: json["pricingDetails"] == null ? null : PricingDetails.fromJson(json["pricingDetails"]),
        accessibilityAndSpecialServices: json["accessibilityAndSpecialServices"] == null ? [] : List<dynamic>.from(json["accessibilityAndSpecialServices"].map((x) => x)),
        funeralPackageOptions: json["funeralPackageOptions"] == null ? null : FuneralPackageOptions.fromJson(json["funeralPackageOptions"]),
        bookingAvailabilityDateFrom: json["booking_availability_date_from"] == null ? null : DateTime.parse(json["booking_availability_date_from"]),
        bookingAvailabilityDateTo: json["booking_availability_date_to"] == null ? null : DateTime.parse(json["booking_availability_date_to"]),
        specialPriceDays: json["special_price_days"] == null ? [] : List<SpecialPriceDay>.from(json["special_price_days"].map((x) => SpecialPriceDay.fromJson(x))),
        areasCovered: json["areasCovered"] == null ? [] : List<String>.from(json["areasCovered"].map((x) => x)),
        fleetDetails: json["fleetDetails"] == null ? null : FleetDetails.fromJson(json["fleetDetails"]),
        serviceDetail: json["service_detail"] == null ? null : ServiceDetail.fromJson(json["service_detail"]),
        uploadedDocuments: json["uploaded_Documents"] == null ? null : UploadedDocuments.fromJson(json["uploaded_Documents"]),
        serviceImages: json["serviceImages"] == null ? [] : List<String>.from(json["serviceImages"].map((x) => x)),
        businessProfile: json["businessProfile"] == null ? null : BusinessProfile.fromJson(json["businessProfile"]),
        approvalStatus: json["approvalStatus"],
        serviceStatus: json["service_status"],
        serviceApproveStatus: json["service_approve_status"],
        cancellationPolicyType: cancellationPolicyTypeValues.map[json["cancellation_policy_type"]] ?? CancellationPolicyType.FLEXIBLE,
        coupons: json["coupons"] == null ? [] : List<Coupon>.from(json["coupons"].map((x) => Coupon.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        serviceType: json["service_type"],
        numberOfLimousines: _toInt(json["numberOfLimousines"]),
        fleetInfo: json["fleetInfo"] == null ? null : FleetInfo.fromJson(json["fleetInfo"]),
        fleetFeatures: json["fleetFeatures"] == null ? [] : List<String>.from(json["fleetFeatures"].map((x) => x)),
        baseLocationPostcode: json["baseLocationPostcode"],
        bookingDateFrom: json["booking_date_from"],
        bookingDateTo: json["booking_date_to"],
        serviceImage: json["service_image"] == null ? [] : List<String>.from(json["service_image"].map((x) => x)),
        carriageDetails: json["carriageDetails"] == null ? null : CarriageDetails.fromJson(json["carriageDetails"]),
        marketing: json["marketing"] == null ? null : Marketing.fromJson(json["marketing"]),
        pricing: json["pricing"] == null ? null : Pricing.fromJson(json["pricing"]),
        equipmentSafety: json["equipmentSafety"] == null ? null : EquipmentSafety.fromJson(json["equipmentSafety"]),
        offeringPrice: _toInt(json["offering_price"]),
        comfort: json["comfort"] == null ? null : ServiceComfort.fromJson(json["comfort"]),
        events: json["events"] == null ? null : Events.fromJson(json["events"]),
        accessibility: json["accessibility"] == null ? null : Accessibility.fromJson(json["accessibility"]),
        security: json["security"] == null ? null : Security.fromJson(json["security"]),
        documents: json["documents"] == null ? null : ServiceDocuments.fromJson(json["documents"]),
        features: json["features"] == null ? null : Features.fromJson(json["features"]),
        licensing: json["licensing"] == null ? null : Licensing.fromJson(json["licensing"]),
        photos: json["photos"] == null ? null : Photos.fromJson(json["photos"]),
        boatType: json["boatType"],
        makeAndModel: json["makeAndModel"],
        firstRegistered: json["firstRegistered"] == null ? null : DateTime.parse(json["firstRegistered"]),
        luggageCapacity: json["luggageCapacity"] == null ? null : (json["luggageCapacity"] is Map ? LuggageCapacity.fromJson(json["luggageCapacity"]) : null),
        seats: _toInt(json["seats"]),
        hireType: json["hireType"],
        departurePoint: json["departurePoint"],
        postcode: json["postcode"],
        serviceCoverage: json["serviceCoverage"] == null ? [] : List<String>.from(json["serviceCoverage"].map((x) => x)),
        mileageRadius: _toInt(json["mileageRadius"]),
        boatRates: json["boatRates"] == null ? null : BoatRates.fromJson(json["boatRates"]),
        miniBusRates: json["miniBusRates"] == null ? null : MiniBusRates.fromJson(json["miniBusRates"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "categoryId": categoryId.toJson(),
        "subcategoryId": subcategoryId.toJson(),
        "service_name": serviceName,
        "listingTitle": listingTitle,
        "basePostcode": basePostcode,
        "locationRadius": locationRadius,
        "pricingDetails": pricingDetails?.toJson(),
        "accessibilityAndSpecialServices": accessibilityAndSpecialServices == null ? [] : List<dynamic>.from(accessibilityAndSpecialServices!.map((x) => x)),
        "funeralPackageOptions": funeralPackageOptions?.toJson(),
        "booking_availability_date_from": bookingAvailabilityDateFrom?.toIso8601String(),
        "booking_availability_date_to": bookingAvailabilityDateTo?.toIso8601String(),
        "special_price_days": specialPriceDays == null ? [] : List<dynamic>.from(specialPriceDays!.map((x) => x.toJson())),
        "areasCovered": areasCovered == null ? [] : List<dynamic>.from(areasCovered!.map((x) => x)),
        "fleetDetails": fleetDetails?.toJson(),
        "service_detail": serviceDetail?.toJson(),
        "uploaded_Documents": uploadedDocuments?.toJson(),
        "serviceImages": serviceImages == null ? [] : List<dynamic>.from(serviceImages!.map((x) => x)),
        "businessProfile": businessProfile?.toJson(),
        "approvalStatus": approvalStatus,
        "service_status": serviceStatus,
        "service_approve_status": serviceApproveStatus,
        "cancellation_policy_type": cancellationPolicyTypeValues.reverse[cancellationPolicyType],
        "coupons": coupons == null ? [] : List<dynamic>.from(coupons!.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "service_type": serviceType,
        "numberOfLimousines": numberOfLimousines,
        "fleetInfo": fleetInfo?.toJson(),
        "fleetFeatures": fleetFeatures == null ? [] : List<dynamic>.from(fleetFeatures!.map((x) => x)),
        "baseLocationPostcode": baseLocationPostcode,
        "booking_date_from": bookingDateFrom,
        "booking_date_to": bookingDateTo,
        "service_image": serviceImage == null ? [] : List<dynamic>.from(serviceImage!.map((x) => x)),
        "carriageDetails": carriageDetails?.toJson(),
        "marketing": marketing?.toJson(),
        "pricing": pricing?.toJson(),
        "equipmentSafety": equipmentSafety?.toJson(),
        "offering_price": offeringPrice,
        "comfort": comfort?.toJson(),
        "events": events?.toJson(),
        "accessibility": accessibility?.toJson(),
        "security": security?.toJson(),
        "documents": documents?.toJson(),
        "features": features?.toJson(),
        "licensing": licensing?.toJson(),
        "photos": photos?.toJson(),
        "boatType": boatType,
        "makeAndModel": makeAndModel,
        "firstRegistered": firstRegistered?.toIso8601String(),
        "luggageCapacity": luggageCapacity,
        "seats": seats,
        "hireType": hireType,
        "departurePoint": departurePoint,
        "postcode": postcode,
        "serviceCoverage": serviceCoverage == null ? [] : List<dynamic>.from(serviceCoverage!.map((x) => x)),
        "mileageRadius": mileageRadius,
        "boatRates": boatRates?.toJson(),
        "miniBusRates": miniBusRates?.toJson(),
    };
}

class Accessibility {
    bool wheelchairAccessVehicle;
    int? wheelchairAccessPrice;
    bool childCarSeats;
    int? childCarSeatsPrice;
    bool petFriendlyService;
    int? petFriendlyPrice;
    bool disabledAccessRamp;
    int? disabledAccessRampPrice;
    bool seniorFriendlyAssistance;
    int? seniorAssistancePrice;
    bool strollerBuggyStorage;
    int? strollerStoragePrice;

    Accessibility({
        required this.wheelchairAccessVehicle,
        this.wheelchairAccessPrice,
        required this.childCarSeats,
        this.childCarSeatsPrice,
        required this.petFriendlyService,
        this.petFriendlyPrice,
        required this.disabledAccessRamp,
        this.disabledAccessRampPrice,
        required this.seniorFriendlyAssistance,
        this.seniorAssistancePrice,
        required this.strollerBuggyStorage,
        this.strollerStoragePrice,
    });

    factory Accessibility.fromJson(Map<String, dynamic> json) => Accessibility(
        wheelchairAccessVehicle: json["wheelchairAccessVehicle"],
        wheelchairAccessPrice: _toInt(json["wheelchairAccessPrice"]),
        childCarSeats: json["childCarSeats"],
        childCarSeatsPrice: _toInt(json["childCarSeatsPrice"]),
        petFriendlyService: json["petFriendlyService"],
        petFriendlyPrice: _toInt(json["petFriendlyPrice"]),
        disabledAccessRamp: json["disabledAccessRamp"],
        disabledAccessRampPrice: _toInt(json["disabledAccessRampPrice"]),
        seniorFriendlyAssistance: json["seniorFriendlyAssistance"],
        seniorAssistancePrice: _toInt(json["seniorAssistancePrice"]),
        strollerBuggyStorage: json["strollerBuggyStorage"],
        strollerStoragePrice: _toInt(json["strollerStoragePrice"]),
    );

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

class BoatRates {
    double? fullDayRate;
    double? halfDayRate;
    double? threeHourRate;
    double? hourlyRate;
    double? perMileRate;
    double? tenHourDayHire;
    double? halfDayHire;

    BoatRates({
        this.fullDayRate,
        this.halfDayRate,
        this.threeHourRate,
        this.hourlyRate,
        this.perMileRate,
        this.tenHourDayHire,
        this.halfDayHire,
    });

    factory BoatRates.fromJson(Map<String, dynamic> json) => BoatRates(
        fullDayRate: _toNullableDouble(json["fullDayRate"]),
        halfDayRate: _toNullableDouble(json["halfDayRate"]),
        threeHourRate: _toNullableDouble(json["threeHourRate"]),
        hourlyRate: _toNullableDouble(json["hourlyRate"]),
        perMileRate: _toNullableDouble(json["perMileRate"]),
        tenHourDayHire: _toNullableDouble(json["tenHourDayHire"]),
        halfDayHire: _toNullableDouble(json["halfDayHire"]),
    );

    Map<String, dynamic> toJson() => {
        "fullDayRate": fullDayRate,
        "halfDayRate": halfDayRate,
        "threeHourRate": threeHourRate,
        if (hourlyRate != null) "hourlyRate": hourlyRate,
        if (perMileRate != null) "perMileRate": perMileRate,
        if (tenHourDayHire != null) "tenHourDayHire": tenHourDayHire,
        if (halfDayHire != null) "halfDayHire": halfDayHire,
    };
}

class LuggageCapacity {
    int largeSuitcases;
    int mediumSuitcases;
    int smallSuitcases;

    LuggageCapacity({
        required this.largeSuitcases,
        required this.mediumSuitcases,
        required this.smallSuitcases,
    });

    factory LuggageCapacity.fromJson(Map<String, dynamic> json) => LuggageCapacity(
        largeSuitcases: _toInt(json["largeSuitcases"]),
        mediumSuitcases: _toInt(json["mediumSuitcases"]),
        smallSuitcases: _toInt(json["smallSuitcases"]),
    );

    Map<String, dynamic> toJson() => {
        "largeSuitcases": largeSuitcases,
        "mediumSuitcases": mediumSuitcases,
        "smallSuitcases": smallSuitcases,
    };
}

class BusinessProfile {
    String businessHighlights;
    String promotionalDescription;

    BusinessProfile({
        required this.businessHighlights,
        required this.promotionalDescription,
    });

    factory BusinessProfile.fromJson(Map<String, dynamic> json) => BusinessProfile(
        businessHighlights: json["businessHighlights"],
        promotionalDescription: json["promotionalDescription"],
    );

    Map<String, dynamic> toJson() => {
        "businessHighlights": businessHighlights,
        "promotionalDescription": promotionalDescription,
    };
}

enum CancellationPolicyType {
    FLEXIBLE
}

final cancellationPolicyTypeValues = EnumValues({
    "FLEXIBLE": CancellationPolicyType.FLEXIBLE
});

class CarriageDetails {
    String carriageType;
    int numberOfCarriages;
    int horseCount;
    List<String> horseBreeds;
    String otherHorseBreed;
    List<String> horseColors;
    String otherHorseColor;
    int seats;
    List<String> decorationOptions;
    String otherDecoration;

    CarriageDetails({
        required this.carriageType,
        required this.numberOfCarriages,
        required this.horseCount,
        required this.horseBreeds,
        required this.otherHorseBreed,
        required this.horseColors,
        required this.otherHorseColor,
        required this.seats,
        required this.decorationOptions,
        required this.otherDecoration,
    });

    factory CarriageDetails.fromJson(Map<String, dynamic> json) => CarriageDetails(
        carriageType: json["carriageType"],
        numberOfCarriages: json["numberOfCarriages"],
        horseCount: json["horseCount"],
        horseBreeds: List<String>.from(json["horseBreeds"].map((x) => x)),
        otherHorseBreed: json["otherHorseBreed"],
        horseColors: List<String>.from(json["horseColors"].map((x) => x)),
        otherHorseColor: json["otherHorseColor"],
        seats: json["seats"],
        decorationOptions: List<String>.from(json["decorationOptions"].map((x) => x)),
        otherDecoration: json["otherDecoration"],
    );

    Map<String, dynamic> toJson() => {
        "carriageType": carriageType,
        "numberOfCarriages": numberOfCarriages,
        "horseCount": horseCount,
        "horseBreeds": List<dynamic>.from(horseBreeds.map((x) => x)),
        "otherHorseBreed": otherHorseBreed,
        "horseColors": List<dynamic>.from(horseColors.map((x) => x)),
        "otherHorseColor": otherHorseColor,
        "seats": seats,
        "decorationOptions": List<dynamic>.from(decorationOptions.map((x) => x)),
        "otherDecoration": otherDecoration,
    };
}

class CategoryId {
    Id id;
    CategoryName categoryName;

    CategoryId({
        required this.id,
        required this.categoryName,
    });

    factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
        id: idValues.map[json["_id"]]!,
        categoryName: categoryNameValues.map[json["category_name"]]!,
    );

    Map<String, dynamic> toJson() => {
        "_id": idValues.reverse[id],
        "category_name": categoryNameValues.reverse[categoryName],
    };
}

enum CategoryName {
    PASSENGER_TRANSPORT
}

final categoryNameValues = EnumValues({
    "Passenger Transport": CategoryName.PASSENGER_TRANSPORT
});

enum Id {
    THE_676_AC544234968_D45_B494992
}

final idValues = EnumValues({
    "676ac544234968d45b494992": Id.THE_676_AC544234968_D45_B494992
});

class ServiceComfort {
    PurpleComplimentaryDrinks complimentaryDrinks;
    bool leatherInterior;
    bool wifiAccess;
    bool airConditioning;
    bool inCarEntertainment;
    bool bluetoothUsb;
    bool redCarpetService;
    bool onboardRestroom;

    ServiceComfort({
        required this.complimentaryDrinks,
        required this.leatherInterior,
        required this.wifiAccess,
        required this.airConditioning,
        required this.inCarEntertainment,
        required this.bluetoothUsb,
        required this.redCarpetService,
        required this.onboardRestroom,
    });

    factory ServiceComfort.fromJson(Map<String, dynamic> json) => ServiceComfort(
        complimentaryDrinks: PurpleComplimentaryDrinks.fromJson(json["complimentaryDrinks"]),
        leatherInterior: json["leatherInterior"],
        wifiAccess: json["wifiAccess"],
        airConditioning: json["airConditioning"],
        inCarEntertainment: json["inCarEntertainment"],
        bluetoothUsb: json["bluetoothUsb"],
        redCarpetService: json["redCarpetService"],
        onboardRestroom: json["onboardRestroom"],
    );

    Map<String, dynamic> toJson() => {
        "complimentaryDrinks": complimentaryDrinks.toJson(),
        "leatherInterior": leatherInterior,
        "wifiAccess": wifiAccess,
        "airConditioning": airConditioning,
        "inCarEntertainment": inCarEntertainment,
        "bluetoothUsb": bluetoothUsb,
        "redCarpetService": redCarpetService,
        "onboardRestroom": onboardRestroom,
    };
}

class PurpleComplimentaryDrinks {
    bool available;
    String details;

    PurpleComplimentaryDrinks({
        required this.available,
        required this.details,
    });

    factory PurpleComplimentaryDrinks.fromJson(Map<String, dynamic> json) => PurpleComplimentaryDrinks(
        available: json["available"],
        details: json["details"],
    );

    Map<String, dynamic> toJson() => {
        "available": available,
        "details": details,
    };
}

class Coupon {
    String couponCode;
    DiscountType discountType;
    int discountValue;
    int usageLimit;
    int currentUsageCount;
    DateTime expiryDate;
    bool isGlobal;
    String id;
    int? minimumDays;
    int? minimumVehicles;
    String? description;

    Coupon({
        required this.couponCode,
        required this.discountType,
        required this.discountValue,
        required this.usageLimit,
        required this.currentUsageCount,
        required this.expiryDate,
        required this.isGlobal,
        required this.id,
        this.minimumDays,
        this.minimumVehicles,
        this.description,
    });

    factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        couponCode: json["coupon_code"],
        discountType: discountTypeValues.map[json["discount_type"]]!,
        discountValue: json["discount_value"],
        usageLimit: json["usage_limit"],
        currentUsageCount: json["current_usage_count"],
        expiryDate: DateTime.parse(json["expiry_date"]),
        isGlobal: json["is_global"],
        id: json["_id"],
        minimumDays: json["minimum_days"],
        minimumVehicles: json["minimum_vehicles"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "coupon_code": couponCode,
        "discount_type": discountTypeValues.reverse[discountType],
        "discount_value": discountValue,
        "usage_limit": usageLimit,
        "current_usage_count": currentUsageCount,
        "expiry_date": expiryDate.toIso8601String(),
        "is_global": isGlobal,
        "_id": id,
        "minimum_days": minimumDays,
        "minimum_vehicles": minimumVehicles,
        "description": description,
    };
}

enum DiscountType {
    PERCENTAGE
}

final discountTypeValues = EnumValues({
    "PERCENTAGE": DiscountType.PERCENTAGE
});

class ServiceDocuments {
    DriverLicencesAndDbs publicLiabilityInsurance;
    DriverLicencesAndDbs driverLicencesAndDbs;
    DriverLicencesAndDbs vehicleMotAndInsurance;
    PsvOperatorLicence psvOperatorLicence;

    ServiceDocuments({
        required this.publicLiabilityInsurance,
        required this.driverLicencesAndDbs,
        required this.vehicleMotAndInsurance,
        required this.psvOperatorLicence,
    });

    factory ServiceDocuments.fromJson(Map<String, dynamic> json) => ServiceDocuments(
        publicLiabilityInsurance: DriverLicencesAndDbs.fromJson(json["publicLiabilityInsurance"]),
        driverLicencesAndDbs: DriverLicencesAndDbs.fromJson(json["driverLicencesAndDBS"]),
        vehicleMotAndInsurance: DriverLicencesAndDbs.fromJson(json["vehicleMOTAndInsurance"]),
        psvOperatorLicence: PsvOperatorLicence.fromJson(json["psvOperatorLicence"]),
    );

    Map<String, dynamic> toJson() => {
        "publicLiabilityInsurance": publicLiabilityInsurance.toJson(),
        "driverLicencesAndDBS": driverLicencesAndDbs.toJson(),
        "vehicleMOTAndInsurance": vehicleMotAndInsurance.toJson(),
        "psvOperatorLicence": psvOperatorLicence.toJson(),
    };
}

class DriverLicencesAndDbs {
    bool isAttached;
    String? image;

    DriverLicencesAndDbs({
        required this.isAttached,
        this.image,
    });

    factory DriverLicencesAndDbs.fromJson(Map<String, dynamic> json) => DriverLicencesAndDbs(
        isAttached: json["isAttached"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "isAttached": isAttached,
        "image": image,
    };
}

class PsvOperatorLicence {
    bool isAttached;

    PsvOperatorLicence({
        required this.isAttached,
    });

    factory PsvOperatorLicence.fromJson(Map<String, dynamic> json) => PsvOperatorLicence(
        isAttached: json["isAttached"],
    );

    Map<String, dynamic> toJson() => {
        "isAttached": isAttached,
    };
}

class EquipmentSafety {
    List<dynamic> safetyChecks;
    List<String> animalWelfareStandards;
    bool? isMaintained;
    String? maintenanceFrequency;
    String? uniformType;
    bool? offersRouteInspection;

    EquipmentSafety({
        required this.safetyChecks,
        required this.animalWelfareStandards,
        this.isMaintained,
        this.maintenanceFrequency,
        this.uniformType,
        this.offersRouteInspection,
    });

    factory EquipmentSafety.fromJson(Map<String, dynamic> json) => EquipmentSafety(
        safetyChecks: List<dynamic>.from(json["safetyChecks"].map((x) => x)),
        animalWelfareStandards: List<String>.from(json["animalWelfareStandards"].map((x) => x)),
        isMaintained: json["isMaintained"],
        maintenanceFrequency: json["maintenanceFrequency"],
        uniformType: json["uniformType"],
        offersRouteInspection: json["offersRouteInspection"],
    );

    Map<String, dynamic> toJson() => {
        "safetyChecks": List<dynamic>.from(safetyChecks.map((x) => x)),
        "animalWelfareStandards": List<dynamic>.from(animalWelfareStandards.map((x) => x)),
        "isMaintained": isMaintained,
        "maintenanceFrequency": maintenanceFrequency,
        "uniformType": uniformType,
        "offersRouteInspection": offersRouteInspection,
    };
}

class Events {
    bool weddingDecor;
    int? weddingDecorPrice;
    bool partyLightingSystem;
    int? partyLightingPrice;
    bool champagnePackages;
    int? champagnePackagePrice;
    String champagneBrand;
    int champagneBottles;
    String champagnePackageDetails;
    bool photographyPackages;
    int? photographyPackagePrice;
    String photographyDuration;
    String photographyTeamSize;
    String photographyPackageDetails;
    String photographyDeliveryTime;

    Events({
        required this.weddingDecor,
        this.weddingDecorPrice,
        required this.partyLightingSystem,
        this.partyLightingPrice,
        required this.champagnePackages,
        this.champagnePackagePrice,
        required this.champagneBrand,
        required this.champagneBottles,
        required this.champagnePackageDetails,
        required this.photographyPackages,
        this.photographyPackagePrice,
        required this.photographyDuration,
        required this.photographyTeamSize,
        required this.photographyPackageDetails,
        required this.photographyDeliveryTime,
    });

    factory Events.fromJson(Map<String, dynamic> json) => Events(
        weddingDecor: json["weddingDecor"] == null ? false : json["weddingDecor"],
        weddingDecorPrice: json["weddingDecorPrice"],
        partyLightingSystem: json["partyLightingSystem"],
        partyLightingPrice: json["partyLightingPrice"],
        champagnePackages: json["champagnePackages"],
        champagnePackagePrice: json["champagnePackagePrice"],
        champagneBrand: json["champagneBrand"] == null ? "" : json["champagneBrand"],
        champagneBottles: json["champagneBottles"] == null ? 0 : json["champagneBottles"],
        champagnePackageDetails: json["champagnePackageDetails"],
        photographyPackages: json["photographyPackages"],
        photographyPackagePrice: json["photographyPackagePrice"],
        photographyDuration: json["photographyDuration"],
        photographyTeamSize: json["photographyTeamSize"],
        photographyPackageDetails: json["photographyPackageDetails"],
        photographyDeliveryTime: json["photographyDeliveryTime"],
    );

    Map<String, dynamic> toJson() => {
        "weddingDecor": weddingDecor,
        "weddingDecorPrice": weddingDecorPrice,
        "partyLightingSystem": partyLightingSystem,
        "partyLightingPrice": partyLightingPrice,
        "champagnePackages": champagnePackages,
        "champagnePackagePrice": champagnePackagePrice,
        "champagneBrand": champagneBrand,
        "champagneBottles": champagneBottles,
        "champagnePackageDetails": champagnePackageDetails,
        "photographyPackages": photographyPackages,
        "photographyPackagePrice": photographyPackagePrice,
        "photographyDuration": photographyDuration,
        "photographyTeamSize": photographyTeamSize,
        "photographyPackageDetails": photographyPackageDetails,
        "photographyDeliveryTime": photographyDeliveryTime,
    };
}

class Features {
    FeaturesComfort? comfort;
    Events? events;
    Accessibility? accessibility;
    Security? security;
    bool? wifi;
    bool? airConditioning;
    bool? tv;
    bool? toilet;
    bool? musicSystem;
    bool? cateringFacilities;
    bool? sunDeck;
    bool? overnightStayCabins;
    bool? other;
    String? otherFeature;

    Features({
        this.comfort,
        this.events,
        this.accessibility,
        this.security,
        this.wifi,
        this.airConditioning,
        this.tv,
        this.toilet,
        this.musicSystem,
        this.cateringFacilities,
        this.sunDeck,
        this.overnightStayCabins,
        this.other,
        this.otherFeature,
    });

    factory Features.fromJson(Map<String, dynamic> json) => Features(
        comfort: json["comfort"] == null ? null : FeaturesComfort.fromJson(json["comfort"]),
        events: json["events"] == null ? null : Events.fromJson(json["events"]),
        accessibility: json["accessibility"] == null ? null : Accessibility.fromJson(json["accessibility"]),
        security: json["security"] == null ? null : Security.fromJson(json["security"]),
        wifi: json["wifi"],
        airConditioning: json["airConditioning"],
        tv: json["tv"],
        toilet: json["toilet"],
        musicSystem: json["musicSystem"],
        cateringFacilities: json["cateringFacilities"],
        sunDeck: json["sunDeck"],
        overnightStayCabins: json["overnightStayCabins"],
        other: json["other"],
        otherFeature: json["otherFeature"],
    );

    Map<String, dynamic> toJson() => {
        "comfort": comfort?.toJson(),
        "events": events?.toJson(),
        "accessibility": accessibility?.toJson(),
        "security": security?.toJson(),
        "wifi": wifi,
        "airConditioning": airConditioning,
        "tv": tv,
        "toilet": toilet,
        "musicSystem": musicSystem,
        "cateringFacilities": cateringFacilities,
        "sunDeck": sunDeck,
        "overnightStayCabins": overnightStayCabins,
        "other": other,
        "otherFeature": otherFeature,
    };
}

class FeaturesComfort {
    FluffyComplimentaryDrinks complimentaryDrinks;
    bool leatherInterior;
    bool wifiAccess;
    bool airConditioning;
    bool inCarEntertainment;
    bool bluetoothUsb;
    bool redCarpetService;
    bool chauffeurInUniform;
    bool onboardRestroom;

    FeaturesComfort({
        required this.complimentaryDrinks,
        required this.leatherInterior,
        required this.wifiAccess,
        required this.airConditioning,
        required this.inCarEntertainment,
        required this.bluetoothUsb,
        required this.redCarpetService,
        required this.chauffeurInUniform,
        required this.onboardRestroom,
    });

    factory FeaturesComfort.fromJson(Map<String, dynamic> json) => FeaturesComfort(
        complimentaryDrinks: FluffyComplimentaryDrinks.fromJson(json["complimentaryDrinks"]),
        leatherInterior: json["leatherInterior"],
        wifiAccess: json["wifiAccess"],
        airConditioning: json["airConditioning"],
        inCarEntertainment: json["inCarEntertainment"],
        bluetoothUsb: json["bluetoothUsb"],
        redCarpetService: json["redCarpetService"],
        chauffeurInUniform: json["chauffeurInUniform"],
        onboardRestroom: json["onboardRestroom"] == null ? false : json["onboardRestroom"],
    );

    Map<String, dynamic> toJson() => {
        "complimentaryDrinks": complimentaryDrinks.toJson(),
        "leatherInterior": leatherInterior,
        "wifiAccess": wifiAccess,
        "airConditioning": airConditioning,
        "inCarEntertainment": inCarEntertainment,
        "bluetoothUsb": bluetoothUsb,
        "redCarpetService": redCarpetService,
        "chauffeurInUniform": chauffeurInUniform,
        "onboardRestroom": onboardRestroom,
    };
}

class FluffyComplimentaryDrinks {
    bool available;

    FluffyComplimentaryDrinks({
        required this.available,
    });

    factory FluffyComplimentaryDrinks.fromJson(Map<String, dynamic> json) => FluffyComplimentaryDrinks(
        available: json["available"],
    );

    Map<String, dynamic> toJson() => {
        "available": available,
    };
}

class Security {
    bool vehicleTrackingGps;
    bool cctvFitted;
    bool publicLiabilityInsurance;
    bool safetyCertifiedDrivers;

    Security({
        required this.vehicleTrackingGps,
        required this.cctvFitted,
        required this.publicLiabilityInsurance,
        required this.safetyCertifiedDrivers,
    });

    factory Security.fromJson(Map<String, dynamic> json) => Security(
        vehicleTrackingGps: json["vehicleTrackingGps"],
        cctvFitted: json["cctvFitted"],
        publicLiabilityInsurance: json["publicLiabilityInsurance"],
        safetyCertifiedDrivers: json["safetyCertifiedDrivers"]  == null ? false : json["safetyCertifiedDrivers"],
    );

    Map<String, dynamic> toJson() => {
        "vehicleTrackingGps": vehicleTrackingGps,
        "cctvFitted": cctvFitted,
        "publicLiabilityInsurance": publicLiabilityInsurance,
        "safetyCertifiedDrivers": safetyCertifiedDrivers,
    };
}

class FleetDetails {
    String makeModel;
    DateTime year;
    int luggageCapacity;
    int seats;

    FleetDetails({
        required this.makeModel,
        required this.year,
        required this.luggageCapacity,
        required this.seats,
    });

    factory FleetDetails.fromJson(Map<String, dynamic> json) => FleetDetails(
        makeModel: json["makeModel"],
        year: DateTime.parse(json["year"]),
        luggageCapacity: json["luggageCapacity"],
        seats: json["seats"],
    );

    Map<String, dynamic> toJson() => {
        "makeModel": makeModel,
        "year": year.toIso8601String(),
        "luggageCapacity": luggageCapacity,
        "seats": seats,
    };
}

class FleetInfo {
    String makeAndModel;
    int seats;
    int luggageCapacity;
    DateTime? firstRegistration;
    DateTime? firstRegistered;
    int? largeSuitcases;
    int? mediumSuitcases;
    int? smallSuitcases;
    bool? wheelchairAccessible;
    int? wheelchairAccessiblePrice;
    bool? airConditioning;
    bool? luggageSpace;

    FleetInfo({
        required this.makeAndModel,
        required this.seats,
        required this.luggageCapacity,
        this.firstRegistration,
        this.firstRegistered,
        this.largeSuitcases,
        this.mediumSuitcases,
        this.smallSuitcases,
        this.wheelchairAccessible,
        this.wheelchairAccessiblePrice,
        this.airConditioning,
        this.luggageSpace,
    });

    factory FleetInfo.fromJson(Map<String, dynamic> json) => FleetInfo(
        makeAndModel: json["makeAndModel"],
        seats: json["seats"],
        luggageCapacity: json["luggageCapacity"] == null ? 0 : json["luggageCapacity"],
        firstRegistration: json["firstRegistration"] == null ? null : DateTime.parse(json["firstRegistration"]),
        firstRegistered: json["firstRegistered"] == null ? null : DateTime.parse(json["firstRegistered"]),
        largeSuitcases: json["largeSuitcases"],
        mediumSuitcases: json["mediumSuitcases"],
        smallSuitcases: json["smallSuitcases"],
        wheelchairAccessible: json["wheelchairAccessible"],
        wheelchairAccessiblePrice: json["wheelchairAccessiblePrice"],
        airConditioning: json["airConditioning"],
        luggageSpace: json["luggageSpace"],
    );

    Map<String, dynamic> toJson() => {
        "makeAndModel": makeAndModel,
        "seats": seats,
        "luggageCapacity": luggageCapacity,
        "firstRegistration": firstRegistration?.toIso8601String(),
        "firstRegistered": firstRegistered?.toIso8601String(),
        "largeSuitcases": largeSuitcases,
        "mediumSuitcases": mediumSuitcases,
        "smallSuitcases": smallSuitcases,
        "wheelchairAccessible": wheelchairAccessible,
        "wheelchairAccessiblePrice": wheelchairAccessiblePrice,
        "airConditioning": airConditioning,
        "luggageSpace": luggageSpace,
    };
}

class FuneralPackageOptions {
    int standard;
    int vipExecutive;

    FuneralPackageOptions({
        required this.standard,
        required this.vipExecutive,
    });

    factory FuneralPackageOptions.fromJson(Map<String, dynamic> json) => FuneralPackageOptions(
        standard: json["standard"],
        vipExecutive: json["vipExecutive"],
    );

    Map<String, dynamic> toJson() => {
        "standard": standard,
        "vipExecutive": vipExecutive,
    };
}

class Licensing {
    LicensingDocuments documents;

    Licensing({
        required this.documents,
    });

    factory Licensing.fromJson(Map<String, dynamic> json) => Licensing(
        documents: LicensingDocuments.fromJson(json["documents"]),
    );

    Map<String, dynamic> toJson() => {
        "documents": documents.toJson(),
    };
}

class LicensingDocuments {
    DriverLicencesAndDbs operatorLicence;
    PsvOperatorLicence vehicleInsurance;
    DriverLicencesAndDbs publicLiabilityInsurance;
    PsvOperatorLicence v5CLogbook;
    PsvOperatorLicence chauffeurDrivingLicence;

    LicensingDocuments({
        required this.operatorLicence,
        required this.vehicleInsurance,
        required this.publicLiabilityInsurance,
        required this.v5CLogbook,
        required this.chauffeurDrivingLicence,
    });

    factory LicensingDocuments.fromJson(Map<String, dynamic> json) => LicensingDocuments(
        operatorLicence: DriverLicencesAndDbs.fromJson(json["operatorLicence"]),
        vehicleInsurance: PsvOperatorLicence.fromJson(json["vehicleInsurance"]),
        publicLiabilityInsurance: DriverLicencesAndDbs.fromJson(json["publicLiabilityInsurance"]),
        v5CLogbook: PsvOperatorLicence.fromJson(json["v5cLogbook"]),
        chauffeurDrivingLicence: PsvOperatorLicence.fromJson(json["chauffeurDrivingLicence"]),
    );

    Map<String, dynamic> toJson() => {
        "operatorLicence": operatorLicence.toJson(),
        "vehicleInsurance": vehicleInsurance.toJson(),
        "publicLiabilityInsurance": publicLiabilityInsurance.toJson(),
        "v5cLogbook": v5CLogbook.toJson(),
        "chauffeurDrivingLicence": chauffeurDrivingLicence.toJson(),
    };
}

class Marketing {
    String companyLogo;
    String description;

    Marketing({
        required this.companyLogo,
        required this.description,
    });

    factory Marketing.fromJson(Map<String, dynamic> json) => Marketing(
        companyLogo: json["companyLogo"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "companyLogo": companyLogo,
        "description": description,
    };
}

class MiniBusRates {
    int hourlyRate;
    double halfDayRate;
    double fullDayRate;
    double additionalMileageFee;
    int mileageLimit;

    MiniBusRates({
        required this.hourlyRate,
        required this.halfDayRate,
        required this.fullDayRate,
        required this.additionalMileageFee,
        required this.mileageLimit,
    });

    factory MiniBusRates.fromJson(Map<String, dynamic> json) => MiniBusRates(
        hourlyRate: json["hourlyRate"] ?? 0,
        halfDayRate: _toDouble(json["halfDayRate"]),
        fullDayRate: _toDouble(json["fullDayRate"]),
        additionalMileageFee: _toDouble(json["additionalMileageFee"]),
        mileageLimit: _toInt(json["mileageLimit"]),
    );

    Map<String, dynamic> toJson() => {
        "hourlyRate": hourlyRate,
        "halfDayRate": halfDayRate,
        "fullDayRate": fullDayRate,
        "additionalMileageFee": additionalMileageFee,
        "mileageLimit": mileageLimit,
    };
}

class Photos {
    List<dynamic> interior;
    List<dynamic> exterior;
    List<dynamic> onWaterView;

    Photos({
        required this.interior,
        required this.exterior,
        required this.onWaterView,
    });

    factory Photos.fromJson(Map<String, dynamic> json) => Photos(
        interior: List<dynamic>.from(json["interior"].map((x) => x)),
        exterior: List<dynamic>.from(json["exterior"].map((x) => x)),
        onWaterView: List<dynamic>.from(json["onWaterView"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "interior": List<dynamic>.from(interior.map((x) => x)),
        "exterior": List<dynamic>.from(exterior.map((x) => x)),
        "onWaterView": List<dynamic>.from(onWaterView.map((x) => x)),
    };
}

class Pricing {
    double hourlyRate;
    double halfDayRate;
    double fullDayRate;
    List<FixedPackage> fixedPackages;

    Pricing({
        required this.hourlyRate,
        required this.halfDayRate,
        required this.fullDayRate,
        required this.fixedPackages,
    });

    factory Pricing.fromJson(Map<String, dynamic> json) => Pricing(
        hourlyRate: json["hourlyRate"]?.toDouble(),
        halfDayRate: json["halfDayRate"]?.toDouble(),
        fullDayRate: json["fullDayRate"]?.toDouble(),
        fixedPackages: List<FixedPackage>.from(json["fixedPackages"].map((x) => FixedPackage.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "hourlyRate": hourlyRate,
        "halfDayRate": halfDayRate,
        "fullDayRate": fullDayRate,
        "fixedPackages": List<dynamic>.from(fixedPackages.map((x) => x.toJson())),
    };
}

class FixedPackage {
    String packageName;
    String packageDescription;
    int packageRate;
    String id;

    FixedPackage({
        required this.packageName,
        required this.packageDescription,
        required this.packageRate,
        required this.id,
    });

    factory FixedPackage.fromJson(Map<String, dynamic> json) => FixedPackage(
        packageName: json["packageName"],
        packageDescription: json["packageDescription"],
        packageRate: json["packageRate"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "packageName": packageName,
        "packageDescription": packageDescription,
        "packageRate": packageRate,
        "_id": id,
    };
}

class PricingDetails {
    double? dayRate;
    int? mileageLimit;
    double? extraMileageCharge;
    double hourlyRate;
    int halfDayRate;
    int? fullDayRate;
    double? weddingPackageRate;
    double? airportTransferRate;
    double? depositRequired;
    bool? fuelIncluded;
    bool? mileageLimitApplicable;
    int? additionalMileageFee;
    bool? waitingChargesApplicable;
    double? waitingChargesPerHour;

    PricingDetails({
        this.dayRate,
        this.mileageLimit,
        this.extraMileageCharge,
        required this.hourlyRate,
        required this.halfDayRate,
        this.fullDayRate,
        this.weddingPackageRate,
        this.airportTransferRate,
        this.depositRequired,
        this.fuelIncluded,
        this.mileageLimitApplicable,
        this.additionalMileageFee,
        this.waitingChargesApplicable,
        this.waitingChargesPerHour,
    });

    factory PricingDetails.fromJson(Map<String, dynamic> json) => PricingDetails(
        dayRate: _toDouble(json["dayRate"]),
        mileageLimit: _toInt(json["mileageLimit"]),
        extraMileageCharge: _toDouble(json["extraMileageCharge"]),
        hourlyRate: _toDouble(json["hourlyRate"]),
        halfDayRate: _toInt(json["halfDayRate"]),
        fullDayRate: _toNullableInt(json["fullDayRate"]),
        weddingPackageRate: _toDouble(json["weddingPackageRate"]),
        airportTransferRate: _toDouble(json["airportTransferRate"]),
        depositRequired: _toDouble(json["depositRequired"]),
        fuelIncluded: json["fuelIncluded"],
        mileageLimitApplicable: json["mileageLimitApplicable"],
        additionalMileageFee: _toInt(json["additionalMileageFee"]),
        waitingChargesApplicable: json["waitingChargesApplicable"],
        waitingChargesPerHour: _toDouble(json["waitingChargesPerHour"]),
    );

    Map<String, dynamic> toJson() => {
        "dayRate": dayRate,
        "mileageLimit": mileageLimit,
        "extraMileageCharge": extraMileageCharge,
        "hourlyRate": hourlyRate,
        "halfDayRate": halfDayRate,
        "fullDayRate": fullDayRate,
        "weddingPackageRate": weddingPackageRate,
        "airportTransferRate": airportTransferRate,
        "depositRequired": depositRequired,
        "fuelIncluded": fuelIncluded,
        "mileageLimitApplicable": mileageLimitApplicable,
        "additionalMileageFee": additionalMileageFee,
        "waitingChargesApplicable": waitingChargesApplicable,
        "waitingChargesPerHour": waitingChargesPerHour,
    };
}

class ServiceDetail {
    bool worksWithFuneralDirectors;
    bool supportsAllFuneralTypes;
    String funeralServiceType;
    List<dynamic> additionalSupportServices;

    ServiceDetail({
        required this.worksWithFuneralDirectors,
        required this.supportsAllFuneralTypes,
        required this.funeralServiceType,
        required this.additionalSupportServices,
    });

    factory ServiceDetail.fromJson(Map<String, dynamic> json) => ServiceDetail(
        worksWithFuneralDirectors: json["worksWithFuneralDirectors"],
        supportsAllFuneralTypes: json["supportsAllFuneralTypes"],
        funeralServiceType: json["funeralServiceType"],
        additionalSupportServices: List<dynamic>.from(json["additionalSupportServices"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "worksWithFuneralDirectors": worksWithFuneralDirectors,
        "supportsAllFuneralTypes": supportsAllFuneralTypes,
        "funeralServiceType": funeralServiceType,
        "additionalSupportServices": List<dynamic>.from(additionalSupportServices.map((x) => x)),
    };
}

class SpecialPriceDay {
    DateTime date;
    double price;
    String? id;

    SpecialPriceDay({
        required this.date,
        required this.price,
        this.id,
    });

    factory SpecialPriceDay.fromJson(Map<String, dynamic> json) => SpecialPriceDay(
        date: DateTime.parse(json["date"]),
        price: json["price"]?.toDouble(),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "price": price,
        "_id": id,
    };
}

class SubcategoryId {
    String id;
    String subcategoryName;

    SubcategoryId({
        required this.id,
        required this.subcategoryName,
    });

    factory SubcategoryId.fromJson(Map<String, dynamic> json) => SubcategoryId(
        id: json["_id"],
        subcategoryName: json["subcategory_name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "subcategory_name": subcategoryName,
    };
}

class UploadedDocuments {
    List<dynamic> fleetPhotos;

    UploadedDocuments({
        required this.fleetPhotos,
    });

    factory UploadedDocuments.fromJson(Map<String, dynamic> json) => UploadedDocuments(
        fleetPhotos: List<dynamic>.from(json["fleetPhotos"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "fleetPhotos": List<dynamic>.from(fleetPhotos.map((x) => x)),
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}