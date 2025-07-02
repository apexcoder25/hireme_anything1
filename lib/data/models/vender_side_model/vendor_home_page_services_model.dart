// services_model.dart

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
        success: json['success'],
        message: json['message'],
        data: Data.fromJson(json['data']),
        fromCache: json['fromCache'],
        processingTime: json['processingTime'],
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data.toJson(),
        'fromCache': fromCache,
        'processingTime': processingTime,
      };
}

class Data {
  List<Service> services;
  int totalServices;
  Map<String, int> serviceStats;
  String vendorId;

  Data({
    required this.services,
    required this.totalServices,
    required this.serviceStats,
    required this.vendorId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        services: List<Service>.from(json['services'].map((x) => Service.fromJson(x))),
        totalServices: json['totalServices'],
        serviceStats: Map<String, int>.from(json['serviceStats']),
        vendorId: json['vendorId'],
      );

  Map<String, dynamic> toJson() => {
        'services': List<dynamic>.from(services.map((x) => x.toJson())),
        'totalServices': totalServices,
        'serviceStats': serviceStats,
        'vendorId': vendorId,
      };
}

class Service {
  String id;
  CategoryId categoryId;
  SubcategoryId subcategoryId;
  String? serviceName;
  ServiceDetails? serviceDetails;
  PricingDetails? pricingDetails;
  List<String>? navigableRoutes;
  Map<String, dynamic>? boatRates; // Added for boat-specific rates
  List<String>? occasionsCovered;
  List<String>? areasCovered;
  List<FleetDetail>? fleetDetails;
  FleetInfo? fleetInfo;
  List<String>? images;
  List<String>? serviceImage;
  String? vehicleType;
  OccasionsCatered? occasionsCatered;
  Features? features;
  UploadedDocuments? uploadedDocuments;
  String? serviceStatus;
  String? serviceApproveStatus;
  String? createdAt;
  String? serviceType; // e.g., "chauffeur" or "boat"
  String? basePostcode;
  double? fullDayRate;
  double? hourlyRate;
  double? halfDayRate;
  double? ceremonyPackageRate;
  double? dayRate;
  double? mileageLimit;
  double? extraMileageCharge;
  double? waitTimeFeePerHour;
  double? decoratingFloralServiceFee;
  bool? chauffeurIncluded;
  bool? fuelChargesIncluded;
  bool? depositRequired;
  double? depositAmount;
  bool? seatBeltsInAllVehicles;
  bool? wheelchairAccessible;
  bool? airConditioning;
  bool? luggageSpace;
  String? notes;

  Service({
    required this.id,
    required this.categoryId,
    required this.subcategoryId,
    this.serviceName,
    this.serviceDetails,
    this.pricingDetails,
    this.boatRates,
    this.occasionsCovered,
    this.navigableRoutes,
    this.areasCovered,
    this.fleetDetails,
    this.fleetInfo,
    this.images,
    this.serviceImage,
    this.vehicleType,
    this.occasionsCatered,
    this.features,
    this.uploadedDocuments,
    this.serviceStatus,
    this.serviceApproveStatus,
    this.createdAt,
    this.serviceType,
    this.basePostcode,
    this.fullDayRate,
    this.hourlyRate,
    this.halfDayRate,
    this.ceremonyPackageRate,
    this.dayRate,
    this.mileageLimit,
    this.extraMileageCharge,
    this.waitTimeFeePerHour,
    this.decoratingFloralServiceFee,
    this.chauffeurIncluded,
    this.fuelChargesIncluded,
    this.depositRequired,
    this.depositAmount,
    this.seatBeltsInAllVehicles,
    this.wheelchairAccessible,
    this.airConditioning,
    this.luggageSpace,
    this.notes,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json['_id'],
        categoryId: CategoryId.fromJson(json['categoryId']),
        subcategoryId: SubcategoryId.fromJson(json['subcategoryId']),
        serviceName: json['service_name'] as String? ?? json['serviceName'] as String?,
        serviceDetails: json['serviceDetails'] != null ? ServiceDetails.fromJson(json['serviceDetails']) : null,
        pricingDetails: json['pricingDetails'] != null ? PricingDetails.fromJson(json['pricingDetails']) : null,
        boatRates: json['boatRates'], // Map boatRates directly as a dynamic map
        occasionsCovered: json['occasionsCovered'] != null ? List<String>.from(json['occasionsCovered']) : null,
        navigableRoutes: json['navigableRoutes'] != null ? List<String>.from(json['navigableRoutes']) : null,
        areasCovered: json['areasCovered'] != null ? List<String>.from(json['areasCovered']) : null,
        fleetDetails: json['fleet_details'] != null ? List<FleetDetail>.from(json['fleet_details'].map((x) => FleetDetail.fromJson(x))) : null,
        fleetInfo: json['fleetInfo'] != null ? FleetInfo.fromJson(json['fleetInfo']) : null,
        images: json['images'] != null ? List<String>.from(json['images']) : null,
        serviceImage: json['service_image'] != null ? List<String>.from(json['service_image']) : null,
        vehicleType: json['vehicleType'],
        occasionsCatered: json['occasionsCatered'] != null ? OccasionsCatered.fromJson(json['occasionsCatered']) : null,
        features: json['features'] != null ? Features.fromJson(json['features']) : null,
        uploadedDocuments: json['uploaded_Documents'] != null ? UploadedDocuments.fromJson(json['uploaded_Documents']) : null,
        serviceStatus: json['service_status'],
        serviceApproveStatus: _parseServiceApproveStatus(json['service_approve_status']),
        createdAt: json['createdAt'],
        serviceType: json['serviceType'],
        basePostcode: json['basePostcode'],
        fullDayRate: json['fullDayRate']?.toDouble(),
        hourlyRate: json['hourlyRate']?.toDouble(),
        halfDayRate: json['halfDayRate']?.toDouble(),
        ceremonyPackageRate: json['ceremonyPackageRate']?.toDouble(),
        dayRate: json['dayRate']?.toDouble(),
        mileageLimit: json['mileageLimit']?.toDouble(),
        extraMileageCharge: json['extraMileageCharge']?.toDouble(),
        waitTimeFeePerHour: json['waitTimeFeePerHour']?.toDouble(),
        decoratingFloralServiceFee: json['decoratingFloralServiceFee']?.toDouble(),
        chauffeurIncluded: json['chauffeurIncluded'],
        fuelChargesIncluded: json['fuelChargesIncluded'],
        depositRequired: json['depositRequired'],
        depositAmount: json['depositAmount']?.toDouble(),
        seatBeltsInAllVehicles: json['seatBeltsInAllVehicles'],
        wheelchairAccessible: json['wheelchairAccessible'],
        airConditioning: json['airConditioning'],
        luggageSpace: json['luggageSpace'],
        notes: json['notes'],
      );

  static String? _parseServiceApproveStatus(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value ? "1" : "0";
    if (value is String) return value;
    return value.toString(); // Fallback for unexpected types
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'categoryId': categoryId.toJson(),
        'subcategoryId': subcategoryId.toJson(),
        'service_name': serviceName,
        'serviceDetails': serviceDetails?.toJson(),
        'pricingDetails': pricingDetails?.toJson(),
        'boatRates': boatRates, // Include boatRates in toJson
        'occasionsCovered': occasionsCovered,
        'areasCovered': areasCovered,
        'navigableRoutes': navigableRoutes,
        'fleet_details': fleetDetails?.map((x) => x.toJson()).toList(),
        'fleetInfo': fleetInfo?.toJson(),
        'images': images,
        'service_image': serviceImage,
        'vehicleType': vehicleType,
        'occasionsCatered': occasionsCatered?.toJson(),
        'features': features?.toJson(),
        'uploaded_Documents': uploadedDocuments?.toJson(),
        'service_status': serviceStatus,
        'service_approve_status': serviceApproveStatus,
        'createdAt': createdAt,
        'serviceType': serviceType,
        'basePostcode': basePostcode,
        'fullDayRate': fullDayRate,
        'hourlyRate': hourlyRate,
        'halfDayRate': halfDayRate,
        'ceremonyPackageRate': ceremonyPackageRate,
        'dayRate': dayRate,
        'mileageLimit': mileageLimit,
        'extraMileageCharge': extraMileageCharge,
        'waitTimeFeePerHour': waitTimeFeePerHour,
        'decoratingFloralServiceFee': decoratingFloralServiceFee,
        'chauffeurIncluded': chauffeurIncluded,
        'fuelChargesIncluded': fuelChargesIncluded,
        'depositRequired': depositRequired,
        'depositAmount': depositAmount,
        'seatBeltsInAllVehicles': seatBeltsInAllVehicles,
        'wheelchairAccessible': wheelchairAccessible,
        'airConditioning': airConditioning,
        'luggageSpace': luggageSpace,
        'notes': notes,
      };
}

class CategoryId {
  String id;
  String categoryName;

  CategoryId({
    required this.id,
    required this.categoryName,
  });

  factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
        id: json['_id'],
        categoryName: json['category_name'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'category_name': categoryName,
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
        id: json['_id'],
        subcategoryName: json['subcategory_name'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'subcategory_name': subcategoryName,
      };
}

class ServiceDetails {
  List<String>? occasionsCatered;
  List<String>? carriageTypes;
  List<String>? horseTypes;
  int? numberOfCarriages;
  int? fleetSize;
  String? basePostcode;

  ServiceDetails({
    this.occasionsCatered,
    this.carriageTypes,
    this.horseTypes,
    this.numberOfCarriages,
    this.fleetSize,
    this.basePostcode,
  });

  factory ServiceDetails.fromJson(Map<String, dynamic> json) => ServiceDetails(
        occasionsCatered: json['occasionsCatered'] != null ? List<String>.from(json['occasionsCatered']) : null,
        carriageTypes: json['carriageTypes'] != null ? List<String>.from(json['carriageTypes']) : null,
        horseTypes: json['horseTypes'] != null ? List<String>.from(json['horseTypes']) : null,
        numberOfCarriages: json['numberOfCarriages'],
        fleetSize: json['fleetSize'],
        basePostcode: json['basePostcode'],
      );

  Map<String, dynamic> toJson() => {
        'occasionsCatered': occasionsCatered,
        'carriageTypes': carriageTypes,
        'horseTypes': horseTypes,
        'numberOfCarriages': numberOfCarriages,
        'fleetSize': fleetSize,
        'basePostcode': basePostcode,
      };
}

class PricingDetails {
  double? dayRate;
  double? mileageLimit;
  double? extraMileageCharge;
  bool? chauffeurIncluded;
  double? hourlyRate;
  double? halfDayRate;
  double? weddingPackage;
  double? airportTransfer;
  bool? fuelChargesIncluded;
  double? waitTimeFeePerHour;
  double? decoratingFloralServiceFee;
  double? depositAmount;
  bool? depositRequired;
  double? mileageAllowance;
  double? additionalMileageFee;
  double? multiDayRate;

  PricingDetails({
    this.dayRate,
    this.mileageLimit,
    this.extraMileageCharge,
    this.chauffeurIncluded,
    this.hourlyRate,
    this.halfDayRate,
    this.weddingPackage,
    this.airportTransfer,
    this.fuelChargesIncluded,
    this.waitTimeFeePerHour,
    this.decoratingFloralServiceFee,
    this.depositAmount,
    this.depositRequired,
    this.mileageAllowance,
    this.additionalMileageFee,
    this.multiDayRate,
  });

  factory PricingDetails.fromJson(Map<String, dynamic> json) => PricingDetails(
        dayRate: json['dayRate']?.toDouble(),
        mileageLimit: json['mileageLimit']?.toDouble(),
        extraMileageCharge: json['extraMileageCharge']?.toDouble(),
        chauffeurIncluded: json['chauffeurIncluded'],
        hourlyRate: json['hourlyRate']?.toDouble(),
        halfDayRate: json['halfDayRate']?.toDouble(),
        weddingPackage: json['weddingPackage']?.toDouble(),
        airportTransfer: json['airportTransfer']?.toDouble(),
        fuelChargesIncluded: json['fuelChargesIncluded'],
        waitTimeFeePerHour: json['waitTimeFeePerHour']?.toDouble(),
        decoratingFloralServiceFee: json['decoratingFloralServiceFee']?.toDouble(),
        depositAmount: json['depositAmount']?.toDouble(),
        depositRequired: json['depositRequired'],
        mileageAllowance: json['mileageAllowance']?.toDouble(),
        additionalMileageFee: json['additionalMileageFee']?.toDouble(),
        multiDayRate: json['multiDayRate']?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'dayRate': dayRate,
        'mileageLimit': mileageLimit,
        'extraMileageCharge': extraMileageCharge,
        'chauffeurIncluded': chauffeurIncluded,
        'hourlyRate': hourlyRate,
        'halfDayRate': halfDayRate,
        'weddingPackage': weddingPackage,
        'airportTransfer': airportTransfer,
        'fuelChargesIncluded': fuelChargesIncluded,
        'waitTimeFeePerHour': waitTimeFeePerHour,
        'decoratingFloralServiceFee': decoratingFloralServiceFee,
        'depositAmount': depositAmount,
        'depositRequired': depositRequired,
        'mileageAllowance': mileageAllowance,
        'additionalMileageFee': additionalMileageFee,
        'multiDayRate': multiDayRate,
      };
}

class FleetDetail {
  String vehicleId;
  String makeModel;
  String type;
  int year;
  String color;
  int capacity;
  String vehicleDescription;
  String bootSpace;
  String keyFeatures;
  String id;

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

  factory FleetDetail.fromJson(Map<String, dynamic> json) => FleetDetail(
        vehicleId: json['vehicleId'],
        makeModel: json['make_Model'],
        type: json['type'],
        year: json['year'],
        color: json['color'],
        capacity: json['capacity'],
        vehicleDescription: json['vehicleDescription'],
        bootSpace: json['bootSpace'],
        keyFeatures: json['key_Features'],
        id: json['_id'],
      );

  Map<String, dynamic> toJson() => {
        'vehicleId': vehicleId,
        'make_Model': makeModel,
        'type': type,
        'year': year,
        'color': color,
        'capacity': capacity,
        'vehicleDescription': vehicleDescription,
        'bootSpace': bootSpace,
        'key_Features': keyFeatures,
        '_id': id,
      };
}

class FleetInfo {
  String? makeAndModel; // Maps to boatName for boats
  String? type; // Added for boat type (e.g., yacht)
  int? seats; // For chauffeur
  int? capacity; // For boat
  bool? wheelchairAccessible;
  bool? airConditioning;
  bool? luggageSpace;
  String? onboardFacilities;
  int? year;
  String? notes;
  String? colour;
  String? chauffeurName;
  String? bootSpace;

  FleetInfo({
    this.makeAndModel,
    this.type,
    this.seats,
    this.capacity,
    this.wheelchairAccessible,
    this.airConditioning,
    this.luggageSpace,
    this.onboardFacilities,
    this.year,
    this.notes,
    this.colour,
    this.chauffeurName,
    this.bootSpace,
  });

  factory FleetInfo.fromJson(Map<String, dynamic> json) => FleetInfo(
        makeAndModel: json['makeAndModel'] ?? json['boatName'], // Handle boatName
        type: json['type'], // Handle boat type
        seats: json['seats'], // For chauffeur
        capacity: json['capacity'], // For boat
        wheelchairAccessible: json['wheelchairAccessible'],
        airConditioning: json['airConditioning'],
        luggageSpace: json['luggageSpace'],
        onboardFacilities: json['onboardFacilities'],
        year: json['year'],
        notes: json['notes'],
        colour: json['colour'],
        chauffeurName: json['chauffeurName'],
        bootSpace: json['bootSpace'],
      );

  Map<String, dynamic> toJson() => {
        'makeAndModel': makeAndModel,
        'type': type,
        'seats': seats,
        'capacity': capacity,
        'wheelchairAccessible': wheelchairAccessible,
        'airConditioning': airConditioning,
        'luggageSpace': luggageSpace,
        'onboardFacilities': onboardFacilities,
        'year': year,
        'notes': notes,
        'colour': colour,
        'chauffeurName': chauffeurName,
        'bootSpace': bootSpace,
      };
}

class OccasionsCatered {
  bool? weddings;
  bool? corporateTravel;
  bool? airportTransfers;
  bool? proms;
  bool? vipRedCarpet;
  bool? filmTVHire;

  OccasionsCatered({
    this.weddings,
    this.corporateTravel,
    this.airportTransfers,
    this.proms,
    this.vipRedCarpet,
    this.filmTVHire,
  });

  factory OccasionsCatered.fromJson(Map<String, dynamic> json) => OccasionsCatered(
        weddings: json['weddings'],
        corporateTravel: json['corporateTravel'],
        airportTransfers: json['airportTransfers'],
        proms: json['proms'],
        vipRedCarpet: json['vipRedCarpet'],
        filmTVHire: json['filmTVHire'],
      );

  Map<String, dynamic> toJson() => {
        'weddings': weddings,
        'corporateTravel': corporateTravel,
        'airportTransfers': airportTransfers,
        'proms': proms,
        'vipRedCarpet': vipRedCarpet,
        'filmTVHire': filmTVHire,
      };
}

class Features {
  Comfort? comfort;
  Events? events;
  Security? security;
  Accessibility? accessibility;

  Features({
    this.comfort,
    this.events,
    this.security,
    this.accessibility,
  });

  factory Features.fromJson(Map<String, dynamic> json) => Features(
        comfort: json['comfort'] != null ? Comfort.fromJson(json['comfort']) : null,
        events: json['events'] != null ? Events.fromJson(json['events']) : null,
        security: json['security'] != null ? Security.fromJson(json['security']) : null,
        accessibility: json['accessibility'] != null ? Accessibility.fromJson(json['accessibility']) : null,
      );

  Map<String, dynamic> toJson() => {
        'comfort': comfort?.toJson(),
        'events': events?.toJson(),
        'security': security?.toJson(),
        'accessibility': accessibility?.toJson(),
      };
}

class Comfort {
  bool? leatherInterior;
  bool? wifiAccess;
  bool? airConditioning;
  ComplimentaryDrinks? complimentaryDrinks;
  bool? inCarEntertainment;
  bool? bluetoothUsb;
  bool? redCarpetService;
  bool? onboardRestroom;
  bool? chauffeurInUniform;

  Comfort({
    this.leatherInterior,
    this.wifiAccess,
    this.airConditioning,
    this.complimentaryDrinks,
    this.inCarEntertainment,
    this.bluetoothUsb,
    this.redCarpetService,
    this.onboardRestroom,
    this.chauffeurInUniform,
  });

  factory Comfort.fromJson(Map<String, dynamic> json) => Comfort(
        leatherInterior: json['leatherInterior'],
        wifiAccess: json['wifiAccess'],
        airConditioning: json['airConditioning'],
        complimentaryDrinks: json['complimentaryDrinks'] != null ? ComplimentaryDrinks.fromJson(json['complimentaryDrinks']) : null,
        inCarEntertainment: json['inCarEntertainment'],
        bluetoothUsb: json['bluetoothUsb'],
        redCarpetService: json['redCarpetService'],
        onboardRestroom: json['onboardRestroom'],
        chauffeurInUniform: json['chauffeurInUniform'],
      );

  Map<String, dynamic> toJson() => {
        'leatherInterior': leatherInterior,
        'wifiAccess': wifiAccess,
        'airConditioning': airConditioning,
        'complimentaryDrinks': complimentaryDrinks?.toJson(),
        'inCarEntertainment': inCarEntertainment,
        'bluetoothUsb': bluetoothUsb,
        'redCarpetService': redCarpetService,
        'onboardRestroom': onboardRestroom,
        'chauffeurInUniform': chauffeurInUniform,
      };
}

class ComplimentaryDrinks {
  bool? available;
  String? details;

  ComplimentaryDrinks({
    this.available,
    this.details,
  });

  factory ComplimentaryDrinks.fromJson(Map<String, dynamic> json) => ComplimentaryDrinks(
        available: json['available'],
        details: json['details'],
      );

  Map<String, dynamic> toJson() => {
        'available': available,
        'details': details,
      };
}

class Events {
  bool? weddingDecor;
  bool? partyLightingSystem;
  bool? champagnePackages;
  bool? photographyPackages;
  double? weddingDecorPrice;
  double? partyLightingPrice;
  double? champagnePackagePrice;
  double? photographyPackagePrice;

  Events({
    this.weddingDecor,
    this.partyLightingSystem,
    this.champagnePackages,
    this.photographyPackages,
    this.weddingDecorPrice,
    this.partyLightingPrice,
    this.champagnePackagePrice,
    this.photographyPackagePrice,
  });

  factory Events.fromJson(Map<String, dynamic> json) => Events(
        weddingDecor: json['weddingDecor'],
        partyLightingSystem: json['partyLightingSystem'],
        champagnePackages: json['champagnePackages'],
        photographyPackages: json['photographyPackages'],
        weddingDecorPrice: json['weddingDecorPrice']?.toDouble(),
        partyLightingPrice: json['partyLightingPrice']?.toDouble(),
        champagnePackagePrice: json['champagnePackagePrice']?.toDouble(),
        photographyPackagePrice: json['photographyPackagePrice']?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'weddingDecor': weddingDecor,
        'partyLightingSystem': partyLightingSystem,
        'champagnePackages': champagnePackages,
        'photographyPackages': photographyPackages,
        'weddingDecorPrice': weddingDecorPrice,
        'partyLightingPrice': partyLightingPrice,
        'champagnePackagePrice': champagnePackagePrice,
        'photographyPackagePrice': photographyPackagePrice,
      };
}

class Security {
  bool? vehicleTrackingGps;
  bool? cctvFitted;
  bool? publicLiabilityInsurance;
  bool? safetyCertifiedDrivers;

  Security({
    this.vehicleTrackingGps,
    this.cctvFitted,
    this.publicLiabilityInsurance,
    this.safetyCertifiedDrivers,
  });

  factory Security.fromJson(Map<String, dynamic> json) => Security(
        vehicleTrackingGps: json['vehicleTrackingGps'],
        cctvFitted: json['cctvFitted'],
        publicLiabilityInsurance: json['publicLiabilityInsurance'],
        safetyCertifiedDrivers: json['safetyCertifiedDrivers'],
      );

  Map<String, dynamic> toJson() => {
        'vehicleTrackingGps': vehicleTrackingGps,
        'cctvFitted': cctvFitted,
        'publicLiabilityInsurance': publicLiabilityInsurance,
        'safetyCertifiedDrivers': safetyCertifiedDrivers,
      };
}

class Accessibility {
  bool? wheelchairAccessVehicle;
  bool? childCarSeats;
  bool? petFriendlyService;
  bool? disabledAccessRamp;
  bool? seniorFriendlyAssistance;
  bool? strollerBuggyStorage;

  Accessibility({
    this.wheelchairAccessVehicle,
    this.childCarSeats,
    this.petFriendlyService,
    this.disabledAccessRamp,
    this.seniorFriendlyAssistance,
    this.strollerBuggyStorage,
  });

  factory Accessibility.fromJson(Map<String, dynamic> json) => Accessibility(
        wheelchairAccessVehicle: json['wheelchairAccessVehicle'],
        childCarSeats: json['childCarSeats'],
        petFriendlyService: json['petFriendlyService'],
        disabledAccessRamp: json['disabledAccessRamp'],
        seniorFriendlyAssistance: json['seniorFriendlyAssistance'],
        strollerBuggyStorage: json['strollerBuggyStorage'],
      );

  Map<String, dynamic> toJson() => {
        'wheelchairAccessVehicle': wheelchairAccessVehicle,
        'childCarSeats': childCarSeats,
        'petFriendlyService': petFriendlyService,
        'disabledAccessRamp': disabledAccessRamp,
        'seniorFriendlyAssistance': seniorFriendlyAssistance,
        'strollerBuggyStorage': strollerBuggyStorage,
      };
}

class UploadedDocuments {
  String? operatorLicence;
  String? insuranceCertificate;
  String? driverLicencesAndDBS;
  String? vehicleMOTs;
  List<String>? fleetPhotos;

  UploadedDocuments({
    this.operatorLicence,
    this.insuranceCertificate,
    this.driverLicencesAndDBS,
    this.vehicleMOTs,
    this.fleetPhotos,
  });

  factory UploadedDocuments.fromJson(Map<String, dynamic> json) => UploadedDocuments(
        operatorLicence: json['operatorLicence'],
        insuranceCertificate: json['insuranceCertificate'],
        driverLicencesAndDBS: json['driverLicencesAndDBS'],
        vehicleMOTs: json['vehicleMOTs'],
        fleetPhotos: json['fleetPhotos'] != null ? List<String>.from(json['fleetPhotos']) : null,
      );

  Map<String, dynamic> toJson() => {
        'operatorLicence': operatorLicence,
        'insuranceCertificate': insuranceCertificate,
        'driverLicencesAndDBS': driverLicencesAndDBS,
        'vehicleMOTs': vehicleMOTs,
        'fleetPhotos': fleetPhotos,
      };
}