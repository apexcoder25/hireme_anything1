// data/models/user_side_model/coach_service_detail_model.dart

import 'package:hire_any_thing/data/models/user_side_model/CouponSharedModel.dart';

class CoachServiceDetail {
  FleetInfo? fleetInfo;
  PricingDetails? pricingDetails;
  Comfort? comfort;
  Events? events;
  Accessibility? accessibility;
  Security? security;
  Documents? documents;
  String? id;
  CategoryId? categoryId;
  SubcategoryId? subcategoryId;
  VendorId? vendorId;
  String? serviceType;
  DateTime? bookingDateFrom;
  DateTime? bookingDateTo;
  List<dynamic>? specialPriceDays;
  int? offeringPrice;
  List<String>? hireTypes;
  String? otherHireType;
  List<PackageDeal>? packageDeals;
  String? listingTitle;
  String? basePostcode;
  int? locationRadius;
  List<String>? areasCovered;
  List<String>? serviceImage;
  String? cancellationPolicyType;
  bool? commissionPolicyAccepted;
  String? commissionPolicyVersion;
  int? commissionRate;
  String? serviceStatus;
  String? serviceApproveStatus;
 final List<Coupon> coupons;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  Features? features;

  CoachServiceDetail({
    this.fleetInfo,
    this.pricingDetails,
    this.comfort,
    this.events,
    this.accessibility,
    this.security,
    this.documents,
    this.id,
    this.categoryId,
    this.subcategoryId,
    this.vendorId,
    this.serviceType,
    this.bookingDateFrom,
    this.bookingDateTo,
    this.specialPriceDays,
    this.offeringPrice,
    this.hireTypes,
    this.otherHireType,
    this.packageDeals,
    this.listingTitle,
    this.basePostcode,
    this.locationRadius,
    this.areasCovered,
    this.serviceImage,
    this.cancellationPolicyType,
    this.commissionPolicyAccepted,
    this.commissionPolicyVersion,
    this.commissionRate,
    this.serviceStatus,
    this.serviceApproveStatus,
    this.coupons = const [],
    this.createdAt,
    this.updatedAt,
    this.v,
    this.features,
  });

  factory CoachServiceDetail.fromJson(Map<String, dynamic> json) => CoachServiceDetail(
        fleetInfo: json["fleetInfo"] == null ? null : FleetInfo.fromJson(json["fleetInfo"]),
        pricingDetails: json["pricingDetails"] == null ? null : PricingDetails.fromJson(json["pricingDetails"]),
        comfort: json["comfort"] == null ? null : Comfort.fromJson(json["comfort"]),
        events: json["events"] == null ? null : Events.fromJson(json["events"]),
        accessibility: json["accessibility"] == null ? null : Accessibility.fromJson(json["accessibility"]),
        security: json["security"] == null ? null : Security.fromJson(json["security"]),
        documents: json["documents"] == null ? null : Documents.fromJson(json["documents"]),
        id: json["_id"],
        categoryId: json["categoryId"] == null ? null : CategoryId.fromJson(json["categoryId"]),
        subcategoryId: json["subcategoryId"] == null ? null : SubcategoryId.fromJson(json["subcategoryId"]),
        vendorId: json["vendorId"] == null ? null : VendorId.fromJson(json["vendorId"]),
        serviceType: json["service_type"],
        bookingDateFrom: json["booking_date_from"] == null ? null : DateTime.parse(json["booking_date_from"]),
        bookingDateTo: json["booking_date_to"] == null ? null : DateTime.parse(json["booking_date_to"]),
        specialPriceDays: json["special_price_days"],
        offeringPrice: json["offering_price"],
        hireTypes: json["hireTypes"] == null ? null : List<String>.from(json["hireTypes"]),
        otherHireType: json["otherHireType"],
        packageDeals: json["packageDeals"] == null ? null : List<PackageDeal>.from(json["packageDeals"].map((x) => PackageDeal.fromJson(x))),
        listingTitle: json["listingTitle"],
        basePostcode: json["basePostcode"],
        locationRadius: json["locationRadius"],
        areasCovered: json["areasCovered"] == null ? null : List<String>.from(json["areasCovered"]),
        serviceImage: json["service_image"] == null ? null : List<String>.from(json["service_image"]),
        cancellationPolicyType: json["cancellation_policy_type"],
        commissionPolicyAccepted: json["commissionPolicyAccepted"],
        commissionPolicyVersion: json["commissionPolicyVersion"],
        commissionRate: json["commissionRate"],
        serviceStatus: json["service_status"],
        serviceApproveStatus: json["service_approve_status"],
       coupons: json["coupons"] == null 
    ? [] 
    : List<Coupon>.from(json["coupons"].map((x) => Coupon.fromJson(x))),

        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        features: json["features"] == null ? null : Features.fromJson(json["features"]),
      );
}

// Supporting classes (same as before, all nullable)
class FleetInfo {
  String? makeAndModel;
  int? seats;
  int? luggageCapacity;
  int? largeSuitcases;
  int? mediumSuitcases;
  int? smallSuitcases;
  String? firstRegistered;

  FleetInfo({this.makeAndModel, this.seats, this.luggageCapacity, this.largeSuitcases, this.mediumSuitcases, this.smallSuitcases, this.firstRegistered});

  factory FleetInfo.fromJson(Map<String, dynamic> json) => FleetInfo(
        makeAndModel: json["makeAndModel"],
        seats: json["seats"],
        luggageCapacity: json["luggageCapacity"],
        largeSuitcases: json["largeSuitcases"],
        mediumSuitcases: json["mediumSuitcases"],
        smallSuitcases: json["smallSuitcases"],
        firstRegistered: json["firstRegistered"],
      );
}

class PricingDetails {
  int? hourlyRate;
  int? halfDayRate;
  int? fullDayRate;
  int? additionalMileageFee;
  int? mileageLimit;

  PricingDetails({this.hourlyRate, this.halfDayRate, this.fullDayRate, this.additionalMileageFee, this.mileageLimit});

  factory PricingDetails.fromJson(Map<String, dynamic> json) => PricingDetails(
        hourlyRate: json["hourlyRate"],
        halfDayRate: json["halfDayRate"],
        fullDayRate: json["fullDayRate"],
        additionalMileageFee: json["additionalMileageFee"],
        mileageLimit: json["mileageLimit"],
      );
}

class Comfort {
  ComplimentaryDrinks? complimentaryDrinks;
  bool? leatherInterior;
  bool? wifiAccess;
  bool? airConditioning;
  bool? inCarEntertainment;
  bool? bluetoothUsb;
  bool? redCarpetService;
  bool? chauffeurInUniform;
  bool? recliningSeats;
  bool? starlights;
  bool? massagingSeats;
  bool? onboardRestroom;

  Comfort({
    this.complimentaryDrinks,
    this.leatherInterior,
    this.wifiAccess,
    this.airConditioning,
    this.inCarEntertainment,
    this.bluetoothUsb,
    this.redCarpetService,
    this.chauffeurInUniform,
    this.recliningSeats,
    this.starlights,
    this.massagingSeats,
    this.onboardRestroom,
  });

  factory Comfort.fromJson(Map<String, dynamic> json) => Comfort(
        complimentaryDrinks: json["complimentaryDrinks"] == null ? null : ComplimentaryDrinks.fromJson(json["complimentaryDrinks"]),
        leatherInterior: json["leatherInterior"],
        wifiAccess: json["wifiAccess"],
        airConditioning: json["airConditioning"],
        inCarEntertainment: json["inCarEntertainment"],
        bluetoothUsb: json["bluetoothUsb"],
        redCarpetService: json["redCarpetService"],
        chauffeurInUniform: json["chauffeurInUniform"],
        recliningSeats: json["recliningSeats"],
        starlights: json["starlights"],
        massagingSeats: json["massagingSeats"],
        onboardRestroom: json["onboardRestroom"],
      );
}

class ComplimentaryDrinks {
  bool? available;
  String? details;

  ComplimentaryDrinks({this.available, this.details});

  factory ComplimentaryDrinks.fromJson(Map<String, dynamic> json) => ComplimentaryDrinks(
        available: json["available"],
        details: json["details"],
      );
}

class Events {
  bool? weddingDecor;
  int? weddingDecorPrice;
  bool? partyLightingSystem;
  int? partyLightingPrice;
  bool? champagnePackages;
  int? champagnePackagePrice;
  String? champagnePackageDetails;
  bool? photographyPackages;
  int? photographyPackagePrice;
  String? photographyDuration;
  String? photographyTeamSize;
  String? photographyPackageDetails;
  String? photographyDeliveryTime;
  String? champagneBrand;
  int? champagneBottles;

  Events({
    this.weddingDecor,
    this.weddingDecorPrice,
    this.partyLightingSystem,
    this.partyLightingPrice,
    this.champagnePackages,
    this.champagnePackagePrice,
    this.champagnePackageDetails,
    this.photographyPackages,
    this.photographyPackagePrice,
    this.photographyDuration,
    this.photographyTeamSize,
    this.photographyPackageDetails,
    this.photographyDeliveryTime,
    this.champagneBrand,
    this.champagneBottles,
  });

  factory Events.fromJson(Map<String, dynamic> json) => Events(
        weddingDecor: json["weddingDecor"],
        weddingDecorPrice: json["weddingDecorPrice"],
        partyLightingSystem: json["partyLightingSystem"],
        partyLightingPrice: json["partyLightingPrice"],
        champagnePackages: json["champagnePackages"],
        champagnePackagePrice: json["champagnePackagePrice"],
        champagnePackageDetails: json["champagnePackageDetails"],
        photographyPackages: json["photographyPackages"],
        photographyPackagePrice: json["photographyPackagePrice"],
        photographyDuration: json["photographyDuration"],
        photographyTeamSize: json["photographyTeamSize"],
        photographyPackageDetails: json["photographyPackageDetails"],
        photographyDeliveryTime: json["photographyDeliveryTime"],
        champagneBrand: json["champagneBrand"],
        champagneBottles: json["champagneBottles"],
      );
}

class Accessibility {
  bool? wheelchairAccessVehicle;
  int? wheelchairAccessPrice;
  bool? childCarSeats;
  int? childCarSeatsPrice;
  bool? petFriendlyService;
  int? petFriendlyPrice;
  bool? disabledAccessRamp;
  int? disabledAccessRampPrice;
  bool? seniorFriendlyAssistance;
  int? seniorAssistancePrice;
  bool? strollerBuggyStorage;
  int? strollerStoragePrice;

  Accessibility({
    this.wheelchairAccessVehicle,
    this.wheelchairAccessPrice,
    this.childCarSeats,
    this.childCarSeatsPrice,
    this.petFriendlyService,
    this.petFriendlyPrice,
    this.disabledAccessRamp,
    this.disabledAccessRampPrice,
    this.seniorFriendlyAssistance,
    this.seniorAssistancePrice,
    this.strollerBuggyStorage,
    this.strollerStoragePrice,
  });

  factory Accessibility.fromJson(Map<String, dynamic> json) => Accessibility(
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

class Security {
  bool? vehicleTrackingGps;
  bool? cctvFitted;
  bool? publicLiabilityInsurance;
  bool? dbsCheckedDrivers;

  Security({this.vehicleTrackingGps, this.cctvFitted, this.publicLiabilityInsurance, this.dbsCheckedDrivers});

  factory Security.fromJson(Map<String, dynamic> json) => Security(
        vehicleTrackingGps: json["vehicleTrackingGps"],
        cctvFitted: json["cctvFitted"],
        publicLiabilityInsurance: json["publicLiabilityInsurance"],
        dbsCheckedDrivers: json["dbsCheckedDrivers"],
      );
}

class Documents {
  PsVOperatorLicence? psvOperatorLicence;
  PsVOperatorLicence? publicLiabilityInsurance;
  PsVOperatorLicence? driverLicencesAndDBS;
  PsVOperatorLicence? vehicleMOTAndInsurance;

  Documents({this.psvOperatorLicence, this.publicLiabilityInsurance, this.driverLicencesAndDBS, this.vehicleMOTAndInsurance});

  factory Documents.fromJson(Map<String, dynamic> json) => Documents(
        psvOperatorLicence: json["psvOperatorLicence"] == null ? null : PsVOperatorLicence.fromJson(json["psvOperatorLicence"]),
        publicLiabilityInsurance: json["publicLiabilityInsurance"] == null ? null : PsVOperatorLicence.fromJson(json["publicLiabilityInsurance"]),
        driverLicencesAndDBS: json["driverLicencesAndDBS"] == null ? null : PsVOperatorLicence.fromJson(json["driverLicencesAndDBS"]),
        vehicleMOTAndInsurance: json["vehicleMOTAndInsurance"] == null ? null : PsVOperatorLicence.fromJson(json["vehicleMOTAndInsurance"]),
      );
}

class PsVOperatorLicence {
  bool? isAttached;

  PsVOperatorLicence({this.isAttached});

  factory PsVOperatorLicence.fromJson(Map<String, dynamic> json) => PsVOperatorLicence(isAttached: json["isAttached"]);
}

class CategoryId {
  String? id;
  String? categoryName;

  CategoryId({this.id, this.categoryName});

  factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(id: json["_id"], categoryName: json["category_name"]);
}

class SubcategoryId {
  String? id;
  String? subcategoryName;

  SubcategoryId({this.id, this.subcategoryName});

  factory SubcategoryId.fromJson(Map<String, dynamic> json) => SubcategoryId(id: json["_id"], subcategoryName: json["subcategory_name"]);
}

class VendorId {
  String? id;
  String? name;
  String? email;
  String? cityName;
  String? countryName;
  String? streetName;

  VendorId({this.id, this.name, this.email, this.cityName, this.countryName, this.streetName});

  factory VendorId.fromJson(Map<String, dynamic> json) => VendorId(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        cityName: json["city_name"],
        countryName: json["country_name"],
        streetName: json["street_name"],
      );
}

class PackageDeal {
  String? packageName;
  String? packageDescription;
  int? packageRate;
  List<String>? inclusions;
  String? id;

  PackageDeal({this.packageName, this.packageDescription, this.packageRate, this.inclusions, this.id});

  factory PackageDeal.fromJson(Map<String, dynamic> json) => PackageDeal(
        packageName: json["packageName"],
        packageDescription: json["packageDescription"],
        packageRate: json["packageRate"],
        inclusions: json["inclusions"] == null ? null : List<String>.from(json["inclusions"]),
        id: json["_id"],
      );
}

class Features {
  Comfort? comfort;
  Events? events;
  Accessibility? accessibility;
  Security? security;

  Features({this.comfort, this.events, this.accessibility, this.security});

  factory Features.fromJson(Map<String, dynamic> json) => Features(
        comfort: json["comfort"] == null ? null : Comfort.fromJson(json["comfort"]),
        events: json["events"] == null ? null : Events.fromJson(json["events"]),
        accessibility: json["accessibility"] == null ? null : Accessibility.fromJson(json["accessibility"]),
        security: json["security"] == null ? null : Security.fromJson(json["security"]),
      );
}