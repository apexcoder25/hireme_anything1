// To parse this JSON data, do
//
// final servicesModel = servicesModelFromJson(jsonString);

import 'dart:convert';

ServicesModel servicesModelFromJson(String str) =>
    ServicesModel.fromJson(json.decode(str));

String servicesModelToJson(ServicesModel data) => json.encode(data.toJson());

// ---------- Helpers ----------
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

// ---------- Root models ----------
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
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] != null ? Data.fromJson(json["data"]) : Data.empty(),
        fromCache: json["fromCache"] ?? false,
        processingTime: json["processingTime"]?.toString() ?? "",
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

  factory Data.empty() => Data(
        services: const [],
        totalServices: 0,
        serviceStats: ServiceStats(passengerTransport: 0),
        vendorId: "",
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        services: json["services"] != null
            ? List<Service>.from(
                (json["services"] as List).map((x) => Service.fromJson(x)),
              )
            : <Service>[],
        totalServices: _toInt(json["totalServices"]),
        serviceStats: json["serviceStats"] != null
            ? ServiceStats.fromJson(json["serviceStats"])
            : ServiceStats(passengerTransport: 0),
        vendorId: json["vendorId"]?.toString() ?? "",
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

// ---------- Service ----------
class Service {
  String id;
  CategoryId? categoryId;
  SubcategoryId? subcategoryId;
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
    this.categoryId,
    this.subcategoryId,
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
        id: json["_id"]?.toString() ?? "",
        categoryId: json["categoryId"] is Map<String, dynamic>
            ? CategoryId.fromJson(json["categoryId"])
            : null,
        subcategoryId: json["subcategoryId"] is Map<String, dynamic>
            ? SubcategoryId.fromJson(json["subcategoryId"])
            : null,
        serviceName: json["service_name"],
        listingTitle: json["listingTitle"]?.toString() ?? "",
        basePostcode: json["basePostcode"],
        locationRadius: _toInt(json["locationRadius"]),
        pricingDetails: json["pricingDetails"] is Map<String, dynamic>
            ? PricingDetails.fromJson(json["pricingDetails"])
            : null,
        accessibilityAndSpecialServices:
            json["accessibilityAndSpecialServices"] == null
                ? []
                : List<dynamic>.from(
                    (json["accessibilityAndSpecialServices"] as List)
                        .map((x) => x),
                  ),
        funeralPackageOptions: json["funeralPackageOptions"] is Map<String, dynamic>
            ? FuneralPackageOptions.fromJson(json["funeralPackageOptions"])
            : null,
        bookingAvailabilityDateFrom:
            json["booking_availability_date_from"] == null
                ? null
                : DateTime.parse(json["booking_availability_date_from"]),
        bookingAvailabilityDateTo:
            json["booking_availability_date_to"] == null
                ? null
                : DateTime.parse(json["booking_availability_date_to"]),
        specialPriceDays: json["special_price_days"] == null
            ? []
            : List<SpecialPriceDay>.from(
                (json["special_price_days"] as List)
                    .map((x) => SpecialPriceDay.fromJson(x)),
              ),
        areasCovered: json["areasCovered"] == null
            ? []
            : List<String>.from(
                (json["areasCovered"] as List).map((x) => x.toString()),
              ),
        fleetDetails: json["fleetDetails"] is Map<String, dynamic>
            ? FleetDetails.fromJson(json["fleetDetails"])
            : null,
        serviceDetail: json["service_detail"] is Map<String, dynamic>
            ? ServiceDetail.fromJson(json["service_detail"])
            : null,
        uploadedDocuments: json["uploaded_Documents"] is Map<String, dynamic>
            ? UploadedDocuments.fromJson(json["uploaded_Documents"])
            : null,
        serviceImages: json["serviceImages"] == null
            ? []
            : List<String>.from(
                (json["serviceImages"] as List).map((x) => x.toString()),
              ),
        businessProfile: json["businessProfile"] is Map<String, dynamic>
            ? BusinessProfile.fromJson(json["businessProfile"])
            : null,
        approvalStatus: json["approvalStatus"],
        serviceStatus: json["service_status"]?.toString() ?? "",
        serviceApproveStatus: json["service_approve_status"],
        cancellationPolicyType: json["cancellation_policy_type"] == null
            ? null
            : cancellationPolicyTypeValues.map[json["cancellation_policy_type"]] ??
                CancellationPolicyType.FLEXIBLE,
        coupons: json["coupons"] == null
            ? []
            : List<Coupon>.from(
                (json["coupons"] as List).map((x) => Coupon.fromJson(x)),
              ),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        serviceType: json["service_type"]?.toString() ?? "",
        numberOfLimousines: _toInt(json["numberOfLimousines"]),
        fleetInfo: json["fleetInfo"] is Map<String, dynamic>
            ? FleetInfo.fromJson(json["fleetInfo"])
            : null,
        fleetFeatures: json["fleetFeatures"] == null
            ? []
            : List<String>.from(
                (json["fleetFeatures"] as List).map((x) => x.toString()),
              ),
        baseLocationPostcode: json["baseLocationPostcode"],
        bookingDateFrom: json["booking_date_from"],
        bookingDateTo: json["booking_date_to"],
        serviceImage: json["service_image"] == null
            ? []
            : List<String>.from(
                (json["service_image"] as List).map((x) => x.toString()),
              ),
        carriageDetails: json["carriageDetails"] is Map<String, dynamic>
            ? CarriageDetails.fromJson(json["carriageDetails"])
            : null,
        marketing: json["marketing"] is Map<String, dynamic>
            ? Marketing.fromJson(json["marketing"])
            : null,
        pricing: json["pricing"] is Map<String, dynamic>
            ? Pricing.fromJson(json["pricing"])
            : null,
        equipmentSafety: json["equipmentSafety"] is Map<String, dynamic>
            ? EquipmentSafety.fromJson(json["equipmentSafety"])
            : null,
        offeringPrice: _toInt(json["offering_price"]),
        comfort: json["comfort"] is Map<String, dynamic>
            ? ServiceComfort.fromJson(json["comfort"])
            : null,
        events: json["events"] is Map<String, dynamic>
            ? Events.fromJson(json["events"])
            : null,
        accessibility: json["accessibility"] is Map<String, dynamic>
            ? Accessibility.fromJson(json["accessibility"])
            : null,
        security: json["security"] is Map<String, dynamic>
            ? Security.fromJson(json["security"])
            : null,
        documents: json["documents"] is Map<String, dynamic>
            ? ServiceDocuments.fromJson(json["documents"])
            : null,
        features: json["features"] is Map<String, dynamic>
            ? Features.fromJson(json["features"])
            : null,
        licensing: json["licensing"] is Map<String, dynamic>
            ? Licensing.fromJson(json["licensing"])
            : null,
        photos: json["photos"] is Map<String, dynamic>
            ? Photos.fromJson(json["photos"])
            : null,
        boatType: json["boatType"],
        makeAndModel: json["makeAndModel"],
        firstRegistered: json["firstRegistered"] == null
            ? null
            : DateTime.parse(json["firstRegistered"]),
        luggageCapacity: json["luggageCapacity"] == null
            ? null
            : (json["luggageCapacity"] is Map<String, dynamic>
                ? LuggageCapacity.fromJson(json["luggageCapacity"])
                : null),
        seats: _toInt(json["seats"]),
        hireType: json["hireType"],
        departurePoint: json["departurePoint"],
        postcode: json["postcode"],
        serviceCoverage: json["serviceCoverage"] == null
            ? []
            : List<String>.from(
                (json["serviceCoverage"] as List).map((x) => x.toString()),
              ),
        mileageRadius: _toInt(json["mileageRadius"]),
        boatRates: json["boatRates"] is Map<String, dynamic>
            ? BoatRates.fromJson(json["boatRates"])
            : null,
        miniBusRates: json["miniBusRates"] is Map<String, dynamic>
            ? MiniBusRates.fromJson(json["miniBusRates"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "categoryId": categoryId?.toJson(),
        "subcategoryId": subcategoryId?.toJson(),
        "service_name": serviceName,
        "listingTitle": listingTitle,
        "basePostcode": basePostcode,
        "locationRadius": locationRadius,
        "pricingDetails": pricingDetails?.toJson(),
        "accessibilityAndSpecialServices":
            accessibilityAndSpecialServices ?? [],
        "funeralPackageOptions": funeralPackageOptions?.toJson(),
        "booking_availability_date_from":
            bookingAvailabilityDateFrom?.toIso8601String(),
        "booking_availability_date_to":
            bookingAvailabilityDateTo?.toIso8601String(),
        "special_price_days": specialPriceDays == null
            ? []
            : List<dynamic>.from(specialPriceDays!.map((x) => x.toJson())),
        "areasCovered": areasCovered ?? [],
        "fleetDetails": fleetDetails?.toJson(),
        "service_detail": serviceDetail?.toJson(),
        "uploaded_Documents": uploadedDocuments?.toJson(),
        "serviceImages": serviceImages ?? [],
        "businessProfile": businessProfile?.toJson(),
        "approvalStatus": approvalStatus,
        "service_status": serviceStatus,
        "service_approve_status": serviceApproveStatus,
        "cancellation_policy_type":
            cancellationPolicyTypeValues.reverse[cancellationPolicyType],
        "coupons": coupons == null
            ? []
            : List<dynamic>.from(coupons!.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "service_type": serviceType,
        "numberOfLimousines": numberOfLimousines,
        "fleetInfo": fleetInfo?.toJson(),
        "fleetFeatures": fleetFeatures ?? [],
        "baseLocationPostcode": baseLocationPostcode,
        "booking_date_from": bookingDateFrom,
        "booking_date_to": bookingDateTo,
        "service_image": serviceImage ?? [],
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
        "luggageCapacity": luggageCapacity?.toJson(),
        "seats": seats,
        "hireType": hireType,
        "departurePoint": departurePoint,
        "postcode": postcode,
        "serviceCoverage": serviceCoverage ?? [],
        "mileageRadius": mileageRadius,
        "boatRates": boatRates?.toJson(),
        "miniBusRates": miniBusRates?.toJson(),
      };
}

// ---------- Nested Models ----------

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
        wheelchairAccessVehicle: json["wheelchairAccessVehicle"] ?? false,
        wheelchairAccessPrice: _toInt(json["wheelchairAccessPrice"]),
        childCarSeats: json["childCarSeats"] ?? false,
        childCarSeatsPrice: _toInt(json["childCarSeatsPrice"]),
        petFriendlyService: json["petFriendlyService"] ?? false,
        petFriendlyPrice: _toInt(json["petFriendlyPrice"]),
        disabledAccessRamp: json["disabledAccessRamp"] ?? false,
        disabledAccessRampPrice: _toInt(json["disabledAccessRampPrice"]),
        seniorFriendlyAssistance: json["seniorFriendlyAssistance"] ?? false,
        seniorAssistancePrice: _toInt(json["seniorAssistancePrice"]),
        strollerBuggyStorage: json["strollerBuggyStorage"] ?? false,
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
        if (fullDayRate != null) "fullDayRate": fullDayRate,
        if (halfDayRate != null) "halfDayRate": halfDayRate,
        if (threeHourRate != null) "threeHourRate": threeHourRate,
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

  factory LuggageCapacity.fromJson(Map<String, dynamic> json) =>
      LuggageCapacity(
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

  factory BusinessProfile.fromJson(Map<String, dynamic> json) =>
      BusinessProfile(
        businessHighlights: json["businessHighlights"] ?? "",
        promotionalDescription: json["promotionalDescription"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "businessHighlights": businessHighlights,
        "promotionalDescription": promotionalDescription,
      };
}

enum CancellationPolicyType { FLEXIBLE }

final cancellationPolicyTypeValues =
    EnumValues({"FLEXIBLE": CancellationPolicyType.FLEXIBLE});

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

  factory CarriageDetails.fromJson(Map<String, dynamic> json) =>
      CarriageDetails(
        carriageType: json["carriageType"] ?? "",
        numberOfCarriages: _toInt(json["numberOfCarriages"]),
        horseCount: _toInt(json["horseCount"]),
        horseBreeds: json["horseBreeds"] == null
            ? []
            : List<String>.from(
                (json["horseBreeds"] as List).map((x) => x.toString())),
        otherHorseBreed: json["otherHorseBreed"] ?? "",
        horseColors: json["horseColors"] == null
            ? []
            : List<String>.from(
                (json["horseColors"] as List).map((x) => x.toString())),
        otherHorseColor: json["otherHorseColor"] ?? "",
        seats: _toInt(json["seats"]),
        decorationOptions: json["decorationOptions"] == null
            ? []
            : List<String>.from(
                (json["decorationOptions"] as List).map((x) => x.toString())),
        otherDecoration: json["otherDecoration"] ?? "",
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
  Id? id;
  CategoryName? categoryName;

  CategoryId({
    this.id,
    this.categoryName,
  });

  factory CategoryId.fromJson(Map<String, dynamic> json) {
    final rawId = json["_id"];
    final rawName = json["category_name"];
    final Id? parsedId =
        rawId == null ? null : idValues.map[rawId.toString()];
    final CategoryName? parsedName =
        rawName == null ? null : categoryNameValues.map[rawName.toString()];
    return CategoryId(
      id: parsedId,
      categoryName: parsedName,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": idValues.reverse[id],
        "category_name": categoryNameValues.reverse[categoryName],
      };
}

enum CategoryName { PASSENGER_TRANSPORT }

final categoryNameValues =
    EnumValues({"Passenger Transport": CategoryName.PASSENGER_TRANSPORT});

enum Id { THE_676_AC544234968_D45_B494992 }

final idValues =
    EnumValues({"676ac544234968d45b494992": Id.THE_676_AC544234968_D45_B494992});

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

  factory ServiceComfort.fromJson(Map<String, dynamic> json) =>
      ServiceComfort(
        complimentaryDrinks:
            PurpleComplimentaryDrinks.fromJson(json["complimentaryDrinks"] ?? {}),
        leatherInterior: json["leatherInterior"] ?? false,
        wifiAccess: json["wifiAccess"] ?? false,
        airConditioning: json["airConditioning"] ?? false,
        inCarEntertainment: json["inCarEntertainment"] ?? false,
        bluetoothUsb: json["bluetoothUsb"] ?? false,
        redCarpetService: json["redCarpetService"] ?? false,
        onboardRestroom: json["onboardRestroom"] ?? false,
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

  factory PurpleComplimentaryDrinks.fromJson(Map<String, dynamic> json) =>
      PurpleComplimentaryDrinks(
        available: json["available"] ?? false,
        details: json["details"] ?? "",
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
        couponCode: json["coupon_code"]?.toString() ?? "",
        discountType:
            discountTypeValues.map[json["discount_type"]] ?? DiscountType.PERCENTAGE,
        discountValue: _toInt(json["discount_value"]),
        usageLimit: _toInt(json["usage_limit"]),
        currentUsageCount: _toInt(json["current_usage_count"]),
        expiryDate: json["expiry_date"] == null
            ? DateTime.now()
            : DateTime.parse(json["expiry_date"]),
        isGlobal: json["is_global"] ?? false,
        id: json["_id"]?.toString() ?? "",
        minimumDays: _toNullableInt(json["minimum_days"]),
        minimumVehicles: _toNullableInt(json["minimum_vehicles"]),
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
        if (minimumDays != null) "minimum_days": minimumDays,
        if (minimumVehicles != null) "minimum_vehicles": minimumVehicles,
        if (description != null) "description": description,
      };
}

enum DiscountType { PERCENTAGE }

final discountTypeValues = EnumValues({"PERCENTAGE": DiscountType.PERCENTAGE});

// ---------- Critical Fixed Classes: ServiceDocuments & Licensing ----------

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
        publicLiabilityInsurance: json["publicLiabilityInsurance"] is Map<String, dynamic>
            ? DriverLicencesAndDbs.fromJson(json["publicLiabilityInsurance"])
            : DriverLicencesAndDbs(isAttached: false),
        driverLicencesAndDbs: json["driverLicencesAndDBS"] is Map<String, dynamic>
            ? DriverLicencesAndDbs.fromJson(json["driverLicencesAndDBS"])
            : DriverLicencesAndDbs(isAttached: false),
        vehicleMotAndInsurance: json["vehicleMOTAndInsurance"] is Map<String, dynamic>
            ? DriverLicencesAndDbs.fromJson(json["vehicleMOTAndInsurance"])
            : DriverLicencesAndDbs(isAttached: false),
        psvOperatorLicence: json["psvOperatorLicence"] is Map<String, dynamic>
            ? PsvOperatorLicence.fromJson(json["psvOperatorLicence"])
            : PsvOperatorLicence(isAttached: false),
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

  factory DriverLicencesAndDbs.fromJson(Map<String, dynamic> json) =>
      DriverLicencesAndDbs(
        isAttached: json["isAttached"] ?? false,
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "isAttached": isAttached,
        if (image != null) "image": image,
      };
}

class PsvOperatorLicence {
  bool isAttached;

  PsvOperatorLicence({
    required this.isAttached,
  });

  factory PsvOperatorLicence.fromJson(Map<String, dynamic> json) =>
      PsvOperatorLicence(
        isAttached: json["isAttached"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "isAttached": isAttached,
      };
}

class Licensing {
  LicensingDocuments documents;

  Licensing({
    required this.documents,
  });

  factory Licensing.fromJson(Map<String, dynamic> json) => Licensing(
        documents: json["documents"] is Map<String, dynamic>
            ? LicensingDocuments.fromJson(json["documents"])
            : LicensingDocuments(
                operatorLicence: DriverLicencesAndDbs(isAttached: false),
                vehicleInsurance: PsvOperatorLicence(isAttached: false),
                publicLiabilityInsurance: DriverLicencesAndDbs(isAttached: false),
                v5CLogbook: PsvOperatorLicence(isAttached: false),
                chauffeurDrivingLicence: PsvOperatorLicence(isAttached: false),
              ),
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

  factory LicensingDocuments.fromJson(Map<String, dynamic> json) =>
      LicensingDocuments(
        operatorLicence: json["operatorLicence"] is Map<String, dynamic>
            ? DriverLicencesAndDbs.fromJson(json["operatorLicence"])
            : DriverLicencesAndDbs(isAttached: false),
        vehicleInsurance: json["vehicleInsurance"] is Map<String, dynamic>
            ? PsvOperatorLicence.fromJson(json["vehicleInsurance"])
            : PsvOperatorLicence(isAttached: false),
        publicLiabilityInsurance: json["publicLiabilityInsurance"] is Map<String, dynamic>
            ? DriverLicencesAndDbs.fromJson(json["publicLiabilityInsurance"])
            : DriverLicencesAndDbs(isAttached: false),
        v5CLogbook: json["v5cLogbook"] is Map<String, dynamic>
            ? PsvOperatorLicence.fromJson(json["v5cLogbook"])
            : PsvOperatorLicence(isAttached: false),
        chauffeurDrivingLicence: json["chauffeurDrivingLicence"] is Map<String, dynamic>
            ? PsvOperatorLicence.fromJson(json["chauffeurDrivingLicence"])
            : PsvOperatorLicence(isAttached: false),
      );

  Map<String, dynamic> toJson() => {
        "operatorLicence": operatorLicence.toJson(),
        "vehicleInsurance": vehicleInsurance.toJson(),
        "publicLiabilityInsurance": publicLiabilityInsurance.toJson(),
        "v5cLogbook": v5CLogbook.toJson(),
        "chauffeurDrivingLicence": chauffeurDrivingLicence.toJson(),
      };
}

// ---------- Remaining Classes ----------

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

  factory EquipmentSafety.fromJson(Map<String, dynamic> json) =>
      EquipmentSafety(
        safetyChecks: json["safetyChecks"] == null
            ? []
            : List<dynamic>.from((json["safetyChecks"] as List).map((x) => x)),
        animalWelfareStandards: json["animalWelfareStandards"] == null
            ? []
            : List<String>.from(
                (json["animalWelfareStandards"] as List).map((x) => x.toString())),
        isMaintained: json["isMaintained"],
        maintenanceFrequency: json["maintenanceFrequency"],
        uniformType: json["uniformType"],
        offersRouteInspection: json["offersRouteInspection"],
      );

  Map<String, dynamic> toJson() => {
        "safetyChecks": List<dynamic>.from(safetyChecks.map((x) => x)),
        "animalWelfareStandards":
            List<dynamic>.from(animalWelfareStandards.map((x) => x)),
        if (isMaintained != null) "isMaintained": isMaintained,
        if (maintenanceFrequency != null) "maintenanceFrequency": maintenanceFrequency,
        if (uniformType != null) "uniformType": uniformType,
        if (offersRouteInspection != null) "offersRouteInspection": offersRouteInspection,
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
        weddingDecor: json["weddingDecor"] ?? false,
        weddingDecorPrice: _toNullableInt(json["weddingDecorPrice"]),
        partyLightingSystem: json["partyLightingSystem"] ?? false,
        partyLightingPrice: _toNullableInt(json["partyLightingPrice"]),
        champagnePackages: json["champagnePackages"] ?? false,
        champagnePackagePrice: _toNullableInt(json["champagnePackagePrice"]),
        champagneBrand: json["champagneBrand"] ?? "",
        champagneBottles: _toInt(json["champagneBottles"]),
        champagnePackageDetails: json["champagnePackageDetails"] ?? "",
        photographyPackages: json["photographyPackages"] ?? false,
        photographyPackagePrice: _toNullableInt(json["photographyPackagePrice"]),
        photographyDuration: json["photographyDuration"] ?? "",
        photographyTeamSize: json["photographyTeamSize"] ?? "",
        photographyPackageDetails: json["photographyPackageDetails"] ?? "",
        photographyDeliveryTime: json["photographyDeliveryTime"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "weddingDecor": weddingDecor,
        if (weddingDecorPrice != null) "weddingDecorPrice": weddingDecorPrice,
        "partyLightingSystem": partyLightingSystem,
        if (partyLightingPrice != null) "partyLightingPrice": partyLightingPrice,
        "champagnePackages": champagnePackages,
        if (champagnePackagePrice != null) "champagnePackagePrice": champagnePackagePrice,
        "champagneBrand": champagneBrand,
        "champagneBottles": champagneBottles,
        "champagnePackageDetails": champagnePackageDetails,
        "photographyPackages": photographyPackages,
        if (photographyPackagePrice != null) "photographyPackagePrice": photographyPackagePrice,
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
        comfort: json["comfort"] is Map<String, dynamic>
            ? FeaturesComfort.fromJson(json["comfort"])
            : null,
        events: json["events"] is Map<String, dynamic>
            ? Events.fromJson(json["events"])
            : null,
        accessibility: json["accessibility"] is Map<String, dynamic>
            ? Accessibility.fromJson(json["accessibility"])
            : null,
        security: json["security"] is Map<String, dynamic>
            ? Security.fromJson(json["security"])
            : null,
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
        if (comfort != null) "comfort": comfort!.toJson(),
        if (events != null) "events": events!.toJson(),
        if (accessibility != null) "accessibility": accessibility!.toJson(),
        if (security != null) "security": security!.toJson(),
        if (wifi != null) "wifi": wifi,
        if (airConditioning != null) "airConditioning": airConditioning,
        if (tv != null) "tv": tv,
        if (toilet != null) "toilet": toilet,
        if (musicSystem != null) "musicSystem": musicSystem,
        if (cateringFacilities != null) "cateringFacilities": cateringFacilities,
        if (sunDeck != null) "sunDeck": sunDeck,
        if (overnightStayCabins != null) "overnightStayCabins": overnightStayCabins,
        if (other != null) "other": other,
        if (otherFeature != null) "otherFeature": otherFeature,
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

  factory FeaturesComfort.fromJson(Map<String, dynamic> json) =>
      FeaturesComfort(
        complimentaryDrinks: FluffyComplimentaryDrinks.fromJson(
            json["complimentaryDrinks"] ?? {}),
        leatherInterior: json["leatherInterior"] ?? false,
        wifiAccess: json["wifiAccess"] ?? false,
        airConditioning: json["airConditioning"] ?? false,
        inCarEntertainment: json["inCarEntertainment"] ?? false,
        bluetoothUsb: json["bluetoothUsb"] ?? false,
        redCarpetService: json["redCarpetService"] ?? false,
        chauffeurInUniform: json["chauffeurInUniform"] ?? false,
        onboardRestroom: json["onboardRestroom"] ?? false,
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

  factory FluffyComplimentaryDrinks.fromJson(Map<String, dynamic> json) =>
      FluffyComplimentaryDrinks(
        available: json["available"] ?? false,
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
        vehicleTrackingGps: json["vehicleTrackingGps"] ?? false,
        cctvFitted: json["cctvFitted"] ?? false,
        publicLiabilityInsurance: json["publicLiabilityInsurance"] ?? false,
        safetyCertifiedDrivers: json["safetyCertifiedDrivers"] ?? false,
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
        makeModel: json["makeModel"] ?? "",
        year: DateTime.parse(json["year"] ?? "1970-01-01"),
        luggageCapacity: _toInt(json["luggageCapacity"]),
        seats: _toInt(json["seats"]),
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
        makeAndModel: json["makeAndModel"] ?? "",
        seats: _toInt(json["seats"]),
        luggageCapacity: _toInt(json["luggageCapacity"]),
        firstRegistration: json["firstRegistration"] == null
            ? null
            : DateTime.parse(json["firstRegistration"]),
        firstRegistered: json["firstRegistered"] == null
            ? null
            : DateTime.parse(json["firstRegistered"]),
        largeSuitcases: _toNullableInt(json["largeSuitcases"]),
        mediumSuitcases: _toNullableInt(json["mediumSuitcases"]),
        smallSuitcases: _toNullableInt(json["smallSuitcases"]),
        wheelchairAccessible: json["wheelchairAccessible"],
        wheelchairAccessiblePrice: _toNullableInt(json["wheelchairAccessiblePrice"]),
        airConditioning: json["airConditioning"],
        luggageSpace: json["luggageSpace"],
      );

  Map<String, dynamic> toJson() => {
        "makeAndModel": makeAndModel,
        "seats": seats,
        "luggageCapacity": luggageCapacity,
        if (firstRegistration != null) "firstRegistration": firstRegistration!.toIso8601String(),
        if (firstRegistered != null) "firstRegistered": firstRegistered!.toIso8601String(),
        if (largeSuitcases != null) "largeSuitcases": largeSuitcases,
        if (mediumSuitcases != null) "mediumSuitcases": mediumSuitcases,
        if (smallSuitcases != null) "smallSuitcases": smallSuitcases,
        if (wheelchairAccessible != null) "wheelchairAccessible": wheelchairAccessible,
        if (wheelchairAccessiblePrice != null) "wheelchairAccessiblePrice": wheelchairAccessiblePrice,
        if (airConditioning != null) "airConditioning": airConditioning,
        if (luggageSpace != null) "luggageSpace": luggageSpace,
      };
}

class FuneralPackageOptions {
  int standard;
  int vipExecutive;

  FuneralPackageOptions({
    required this.standard,
    required this.vipExecutive,
  });

  factory FuneralPackageOptions.fromJson(Map<String, dynamic> json) =>
      FuneralPackageOptions(
        standard: _toInt(json["standard"]),
        vipExecutive: _toInt(json["vipExecutive"]),
      );

  Map<String, dynamic> toJson() => {
        "standard": standard,
        "vipExecutive": vipExecutive,
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
        companyLogo: json["companyLogo"] ?? "",
        description: json["description"] ?? "",
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
        hourlyRate: _toInt(json["hourlyRate"]),
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
        interior: json["interior"] == null
            ? []
            : List<dynamic>.from((json["interior"] as List).map((x) => x)),
        exterior: json["exterior"] == null
            ? []
            : List<dynamic>.from((json["exterior"] as List).map((x) => x)),
        onWaterView: json["onWaterView"] == null
            ? []
            : List<dynamic>.from((json["onWaterView"] as List).map((x) => x)),
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
        hourlyRate: _toDouble(json["hourlyRate"]),
        halfDayRate: _toDouble(json["halfDayRate"]),
        fullDayRate: _toDouble(json["fullDayRate"]),
        fixedPackages: json["fixedPackages"] == null
            ? []
            : List<FixedPackage>.from(
                (json["fixedPackages"] as List)
                    .map((x) => FixedPackage.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "hourlyRate": hourlyRate,
        "halfDayRate": halfDayRate,
        "fullDayRate": fullDayRate,
        "fixedPackages":
            List<dynamic>.from(fixedPackages.map((x) => x.toJson())),
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
        packageName: json["packageName"] ?? "",
        packageDescription: json["packageDescription"] ?? "",
        packageRate: _toInt(json["packageRate"]),
        id: json["_id"]?.toString() ?? "",
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
        dayRate: _toNullableDouble(json["dayRate"]),
        mileageLimit: _toNullableInt(json["mileageLimit"]),
        extraMileageCharge: _toNullableDouble(json["extraMileageCharge"]),
        hourlyRate: _toDouble(json["hourlyRate"]),
        halfDayRate: _toInt(json["halfDayRate"]),
        fullDayRate: _toNullableInt(json["fullDayRate"]),
        weddingPackageRate: _toNullableDouble(json["weddingPackageRate"]),
        airportTransferRate: _toNullableDouble(json["airportTransferRate"]),
        depositRequired: _toNullableDouble(json["depositRequired"]),
        fuelIncluded: json["fuelIncluded"],
        mileageLimitApplicable: json["mileageLimitApplicable"],
        additionalMileageFee: _toNullableInt(json["additionalMileageFee"]),
        waitingChargesApplicable: json["waitingChargesApplicable"],
        waitingChargesPerHour: _toNullableDouble(json["waitingChargesPerHour"]),
      );

  Map<String, dynamic> toJson() => {
        if (dayRate != null) "dayRate": dayRate,
        if (mileageLimit != null) "mileageLimit": mileageLimit,
        if (extraMileageCharge != null) "extraMileageCharge": extraMileageCharge,
        "hourlyRate": hourlyRate,
        "halfDayRate": halfDayRate,
        if (fullDayRate != null) "fullDayRate": fullDayRate,
        if (weddingPackageRate != null) "weddingPackageRate": weddingPackageRate,
        if (airportTransferRate != null) "airportTransferRate": airportTransferRate,
        if (depositRequired != null) "depositRequired": depositRequired,
        if (fuelIncluded != null) "fuelIncluded": fuelIncluded,
        if (mileageLimitApplicable != null) "mileageLimitApplicable": mileageLimitApplicable,
        if (additionalMileageFee != null) "additionalMileageFee": additionalMileageFee,
        if (waitingChargesApplicable != null) "waitingChargesApplicable": waitingChargesApplicable,
        if (waitingChargesPerHour != null) "waitingChargesPerHour": waitingChargesPerHour,
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
        worksWithFuneralDirectors: json["worksWithFuneralDirectors"] ?? false,
        supportsAllFuneralTypes: json["supportsAllFuneralTypes"] ?? false,
        funeralServiceType: json["funeralServiceType"] ?? "",
        additionalSupportServices: json["additionalSupportServices"] == null
            ? []
            : List<dynamic>.from(
                (json["additionalSupportServices"] as List).map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "worksWithFuneralDirectors": worksWithFuneralDirectors,
        "supportsAllFuneralTypes": supportsAllFuneralTypes,
        "funeralServiceType": funeralServiceType,
        "additionalSupportServices":
            List<dynamic>.from(additionalSupportServices.map((x) => x)),
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

  factory SpecialPriceDay.fromJson(Map<String, dynamic> json) =>
      SpecialPriceDay(
        date: DateTime.parse(json["date"]),
        price: (json["price"] as num?)?.toDouble() ?? 0.0,
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "price": price,
        if (id != null) "_id": id,
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
        id: json["_id"]?.toString() ?? "",
        subcategoryName: json["subcategory_name"] ?? "",
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

  factory UploadedDocuments.fromJson(Map<String, dynamic> json) =>
      UploadedDocuments(
        fleetPhotos: json["fleetPhotos"] == null
            ? []
            : List<dynamic>.from((json["fleetPhotos"] as List).map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "fleetPhotos": List<dynamic>.from(fleetPhotos.map((x) => x)),
      };
}

// ---------- Enum Helper ----------
class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}