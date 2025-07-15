
class FilterModel {
  FilterModel({
    required this.success,
    required this.count,
    required this.data,
  });

  final bool? success;
  final int? count;
  final List<Datum> data;

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    return FilterModel(
      success: json["success"],
      count: json["count"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "count": count,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.categoryId,
    required this.subcategoryId,
    required this.vendorId,
    required this.datumServiceName,
    required this.emergencyContactNumber,
    required this.funeralVehicleTypes,
    required this.pricingDetails,
    required this.accessibilityAndSpecialServices,
    required this.funeralPackageOptions,
    required this.bookingAvailabilityDateFrom,
    required this.bookingAvailabilityDateTo,
    required this.datumSpecialPriceDays,
    required this.areasCovered,
    required this.fleetDetails,
    required this.driverDetail,
    required this.serviceDetail,
    required this.licensingDetails,
    required this.insuranceDetails,
    required this.uploadedDocuments,
    required this.businessProfile,
    required this.approvalStatus,
    required this.serviceStatus,
    required this.serviceApproveStatus,
    required this.cancellationPolicyType,
    required this.coupons,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.sourceModel,
    required this.serviceName,
    required this.serviceDetails,
    required this.equipmentSafety,
    required this.licensingInsurance,
    required this.marketing,
    required this.bookingAvailability,
    required this.serviceAreas,
    required this.availabilityPeriod,
    required this.specialPriceDays,
    required this.pricing,
    required this.images,
    required this.accessibilityServices,
    required this.documents,
    required this.eventsExtras,
    required this.featurePricing,
    required this.serviceType,
    required this.vehicleType,
    required this.baseLocationPostcode,
    required this.fleetInfo,
    required this.occasionsCatered,
    required this.features,
    required this.datumBookingDateFrom,
    required this.datumBookingDateTo,
    required this.licensing,
    required this.serviceImage,
    required this.listingData,
    required this.media,
    required this.occasionsCovered,
    required this.available247,
    required this.bookingOptions,
    required this.datumFleetDetails,
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
    required this.documentation,
    required this.otherOccasions,
    required this.promoVideoLink,
    required this.promotionalDescription,
    required this.serviceHighlights,
  });

  final String? id;
  final CategoryId? categoryId;
  final SubcategoryId? subcategoryId;
  final String? vendorId;
  final String? datumServiceName;
  final String? emergencyContactNumber;
  final List<String> funeralVehicleTypes;
  final PricingDetails? pricingDetails;
  final List<AccessibilityAndSpecialService> accessibilityAndSpecialServices;
  final FuneralPackageOptions? funeralPackageOptions;
  final DateTime? bookingAvailabilityDateFrom;
  final DateTime? bookingAvailabilityDateTo;
  final List<SpecialPriceDay> datumSpecialPriceDays;
  final List<String> areasCovered;
  final FleetDetails? fleetDetails;
  final DriverDetail? driverDetail;
  final ServiceDetail? serviceDetail;
  final LicensingDetails? licensingDetails;
  final InsuranceDetails? insuranceDetails;
  final UploadedDocuments? uploadedDocuments;
  final BusinessProfile? businessProfile;
  final String? approvalStatus;
  final String? serviceStatus;
  final dynamic serviceApproveStatus;
  final String? cancellationPolicyType;
  final List<Coupon> coupons;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? sourceModel;
  final String? serviceName;
  final ServiceDetails? serviceDetails;
  final EquipmentSafety? equipmentSafety;
  final LicensingInsurance? licensingInsurance;
  final Marketing? marketing;
  final BookingAvailability? bookingAvailability;
  final List<String> serviceAreas;
  final AvailabilityPeriod? availabilityPeriod;
  final List<SpecialPriceDay> specialPriceDays;
  final Pricing? pricing;
  final List<String> images;
  final List<String> accessibilityServices;
  final DatumDocuments? documents;
  final List<String> eventsExtras;
  final FeaturePricing? featurePricing;
  final String? serviceType;
  final String? vehicleType;
  final String? baseLocationPostcode;
  final FleetInfo? fleetInfo;
  final OccasionsCatered? occasionsCatered;
  final Features? features;
  final DateTime? datumBookingDateFrom;
  final String? datumBookingDateTo;
  final Licensing? licensing;
  final List<String> serviceImage;
  final ListingData? listingData;
  final Media? media;
  final List<String> occasionsCovered;
  final bool? available247;
  final List<dynamic> bookingOptions;
  final List<FleetDetail> datumFleetDetails;
  final int? fullDayRate;
  final int? hourlyRate;
  final double? halfDayRate;
  final double? weddingPackageRate;
  final double? airportTransferRate;
  final bool? fuelIncluded;
  final int? mileageCapLimit;
  final int? mileageCapExcessCharge;
  final DateTime? bookingDateFrom;
  final DateTime? bookingDateTo;
  final Documentation? documentation;
  final String? otherOccasions;
  final String? promoVideoLink;
  final String? promotionalDescription;
  final String? serviceHighlights;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["_id"],
      categoryId: json["categoryId"] == null ? null : CategoryId.fromJson(json["categoryId"]),
      subcategoryId: json["subcategoryId"] == null ? null : SubcategoryId.fromJson(json["subcategoryId"]),
      vendorId: json["vendorId"],
      datumServiceName: json["service_name"],
      emergencyContactNumber: json["emergencyContactNumber"],
      funeralVehicleTypes: json["funeralVehicleTypes"] == null ? [] : List<String>.from(json["funeralVehicleTypes"]!.map((x) => x)),
      pricingDetails: json["pricingDetails"] == null ? null : PricingDetails.fromJson(json["pricingDetails"]),
      accessibilityAndSpecialServices: json["accessibilityAndSpecialServices"] == null ? [] : List<AccessibilityAndSpecialService>.from(json["accessibilityAndSpecialServices"]!.map((x) => AccessibilityAndSpecialService.fromJson(x))),
      funeralPackageOptions: json["funeralPackageOptions"] == null ? null : FuneralPackageOptions.fromJson(json["funeralPackageOptions"]),
      bookingAvailabilityDateFrom: DateTime.tryParse(json["booking_availability_date_from"] ?? ""),
      bookingAvailabilityDateTo: DateTime.tryParse(json["booking_availability_date_to"] ?? ""),
      datumSpecialPriceDays: json["special_price_days"] == null ? [] : List<SpecialPriceDay>.from(json["special_price_days"]!.map((x) => SpecialPriceDay.fromJson(x))),
      areasCovered: json["areasCovered"] == null ? [] : List<String>.from(json["areasCovered"]!.map((x) => x)),
      fleetDetails: json["fleetDetails"] == null ? null : FleetDetails.fromJson(json["fleetDetails"]),
      driverDetail: json["driver_detail"] == null ? null : DriverDetail.fromJson(json["driver_detail"]),
      serviceDetail: json["service_detail"] == null ? null : ServiceDetail.fromJson(json["service_detail"]),
      licensingDetails: json["licensingDetails"] == null ? null : LicensingDetails.fromJson(json["licensingDetails"]),
      insuranceDetails: json["insuranceDetails"] == null ? null : InsuranceDetails.fromJson(json["insuranceDetails"]),
      uploadedDocuments: json["uploaded_Documents"] == null ? null : UploadedDocuments.fromJson(json["uploaded_Documents"]),
      businessProfile: json["businessProfile"] == null ? null : BusinessProfile.fromJson(json["businessProfile"]),
      approvalStatus: json["approvalStatus"],
      serviceStatus: json["service_status"],
      serviceApproveStatus: json["service_approve_status"],
      cancellationPolicyType: json["cancellation_policy_type"],
      coupons: json["coupons"] == null ? [] : List<Coupon>.from(json["coupons"]!.map((x) => Coupon.fromJson(x))),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      sourceModel: json["_sourceModel"],
      serviceName: json["serviceName"],
      serviceDetails: json["serviceDetails"] == null ? null : ServiceDetails.fromJson(json["serviceDetails"]),
      equipmentSafety: json["equipmentSafety"] == null ? null : EquipmentSafety.fromJson(json["equipmentSafety"]),
      licensingInsurance: json["licensingInsurance"] == null ? null : LicensingInsurance.fromJson(json["licensingInsurance"]),
      marketing: json["marketing"] == null ? null : Marketing.fromJson(json["marketing"]),
      bookingAvailability: json["bookingAvailability"] == null ? null : BookingAvailability.fromJson(json["bookingAvailability"]),
      serviceAreas: json["serviceAreas"] == null ? [] : List<String>.from(json["serviceAreas"]!.map((x) => x)),
      availabilityPeriod: json["availabilityPeriod"] == null ? null : AvailabilityPeriod.fromJson(json["availabilityPeriod"]),
      specialPriceDays: json["specialPriceDays"] == null ? [] : List<SpecialPriceDay>.from(json["specialPriceDays"]!.map((x) => SpecialPriceDay.fromJson(x))),
      pricing: json["pricing"] == null ? null : Pricing.fromJson(json["pricing"]),
      images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
      accessibilityServices: json["accessibilityServices"] == null ? [] : List<String>.from(json["accessibilityServices"]!.map((x) => x)),
      documents: json["documents"] == null ? null : DatumDocuments.fromJson(json["documents"]),
      eventsExtras: json["eventsExtras"] == null ? [] : List<String>.from(json["eventsExtras"]!.map((x) => x)),
      featurePricing: json["featurePricing"] == null ? null : FeaturePricing.fromJson(json["featurePricing"]),
      serviceType: json["serviceType"],
      vehicleType: json["vehicleType"],
      baseLocationPostcode: json["baseLocationPostcode"],
      fleetInfo: json["fleetInfo"] == null ? null : FleetInfo.fromJson(json["fleetInfo"]),
      occasionsCatered: json["occasionsCatered"] == null ? null : OccasionsCatered.fromJson(json["occasionsCatered"]),
      features: json["features"] == null ? null : Features.fromJson(json["features"]),
      datumBookingDateFrom: DateTime.tryParse(json["booking_date_from"] ?? ""),
      datumBookingDateTo: json["booking_date_to"],
      licensing: json["licensing"] == null ? null : Licensing.fromJson(json["licensing"]),
      serviceImage: json["service_image"] == null ? [] : List<String>.from(json["service_image"]!.map((x) => x)),
      listingData: json["listing_data"] == null ? null : ListingData.fromJson(json["listing_data"]),
      media: json["media"] == null ? null : Media.fromJson(json["media"]),
      occasionsCovered: json["occasionsCovered"] == null ? [] : List<String>.from(json["occasionsCovered"]!.map((x) => x)),
      available247: json["available_24_7"],
      bookingOptions: json["bookingOptions"] == null ? [] : List<dynamic>.from(json["bookingOptions"]!.map((x) => x)),
      datumFleetDetails: json["fleet_details"] == null ? [] : List<FleetDetail>.from(json["fleet_details"]!.map((x) => FleetDetail.fromJson(x))),
      fullDayRate: json["fullDayRate"] != null ? int.tryParse(json["fullDayRate"].toString()) : null,
      hourlyRate: json["hourlyRate"] != null ? int.tryParse(json["hourlyRate"].toString()) : null,
      halfDayRate: json["halfDayRate"] != null ? double.tryParse(json["halfDayRate"].toString()) : null,
      weddingPackageRate: json["weddingPackageRate"] != null ? double.tryParse(json["weddingPackageRate"].toString()) : null,
      airportTransferRate: json["airportTransferRate"] != null ? double.tryParse(json["airportTransferRate"].toString()) : null,
      fuelIncluded: json["fuelIncluded"],
      mileageCapLimit: json["mileageCapLimit"] != null ? int.tryParse(json["mileageCapLimit"].toString()) : null,
      mileageCapExcessCharge: json["mileageCapExcessCharge"] != null ? int.tryParse(json["mileageCapExcessCharge"].toString()) : null,
      bookingDateFrom: DateTime.tryParse(json["bookingDateFrom"] ?? ""),
      bookingDateTo: DateTime.tryParse(json["bookingDateTo"] ?? ""),
      documentation: json["documentation"] == null ? null : Documentation.fromJson(json["documentation"]),
      otherOccasions: json["otherOccasions"],
      promoVideoLink: json["promoVideoLink"],
      promotionalDescription: json["promotionalDescription"],
      serviceHighlights: json["serviceHighlights"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "categoryId": categoryId?.toJson(),
        "subcategoryId": subcategoryId?.toJson(),
        "vendorId": vendorId,
        "service_name": datumServiceName,
        "emergencyContactNumber": emergencyContactNumber,
        "funeralVehicleTypes": funeralVehicleTypes.map((x) => x).toList(),
        "pricingDetails": pricingDetails?.toJson(),
        "accessibilityAndSpecialServices": accessibilityAndSpecialServices.map((x) => x.toJson()).toList(),
        "funeralPackageOptions": funeralPackageOptions?.toJson(),
        "booking_availability_date_from": bookingAvailabilityDateFrom?.toIso8601String(),
        "booking_availability_date_to": bookingAvailabilityDateTo?.toIso8601String(),
        "special_price_days": datumSpecialPriceDays.map((x) => x.toJson()).toList(),
        "areasCovered": areasCovered.map((x) => x).toList(),
        "fleetDetails": fleetDetails?.toJson(),
        "driver_detail": driverDetail?.toJson(),
        "service_detail": serviceDetail?.toJson(),
        "licensingDetails": licensingDetails?.toJson(),
        "insuranceDetails": insuranceDetails?.toJson(),
        "uploaded_Documents": uploadedDocuments?.toJson(),
        "businessProfile": businessProfile?.toJson(),
        "approvalStatus": approvalStatus,
        "service_status": serviceStatus,
        "service_approve_status": serviceApproveStatus,
        "cancellation_policy_type": cancellationPolicyType,
        "coupons": coupons.map((x) => x.toJson()).toList(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "_sourceModel": sourceModel,
        "serviceName": serviceName,
        "serviceDetails": serviceDetails?.toJson(),
        "equipmentSafety": equipmentSafety?.toJson(),
        "licensingInsurance": licensingInsurance?.toJson(),
        "marketing": marketing?.toJson(),
        "bookingAvailability": bookingAvailability?.toJson(),
        "serviceAreas": serviceAreas.map((x) => x).toList(),
        "availabilityPeriod": availabilityPeriod?.toJson(),
        "specialPriceDays": specialPriceDays.map((x) => x.toJson()).toList(),
        "pricing": pricing?.toJson(),
        "images": images.map((x) => x).toList(),
        "accessibilityServices": accessibilityServices.map((x) => x).toList(),
        "documents": documents?.toJson(),
        "eventsExtras": eventsExtras.map((x) => x).toList(),
        "featurePricing": featurePricing?.toJson(),
        "serviceType": serviceType,
        "vehicleType": vehicleType,
        "baseLocationPostcode": baseLocationPostcode,
        "fleetInfo": fleetInfo?.toJson(),
        "occasionsCatered": occasionsCatered?.toJson(),
        "features": features?.toJson(),
        "booking_date_from": datumBookingDateFrom?.toIso8601String(),
        "booking_date_to": datumBookingDateTo,
        "licensing": licensing?.toJson(),
        "service_image": serviceImage.map((x) => x).toList(),
        "listing_data": listingData?.toJson(),
        "media": media?.toJson(),
        "occasionsCovered": occasionsCovered.map((x) => x).toList(),
        "available_24_7": available247,
        "bookingOptions": bookingOptions.map((x) => x).toList(),
        "fleet_details": datumFleetDetails.map((x) => x.toJson()).toList(),
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
        "documentation": documentation?.toJson(),
        "otherOccasions": otherOccasions,
        "promoVideoLink": promoVideoLink,
        "promotionalDescription": promotionalDescription,
        "serviceHighlights": serviceHighlights,
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

  factory AccessibilityAndSpecialService.fromJson(Map<String, dynamic> json) {
    return AccessibilityAndSpecialService(
      serviceType: json["serviceType"],
      additionalPrice: json["additionalPrice"] != null ? int.tryParse(json["additionalPrice"].toString()) : null,
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

  factory AvailabilityPeriod.fromJson(Map<String, dynamic> json) {
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
    required this.available247,
    required this.serviceHours,
  });

  final List<String> availableFor;
  final String? leadTime;
  final List<dynamic> bookingOptions;
  final bool? available247;
  final String? serviceHours;

  factory BookingAvailability.fromJson(Map<String, dynamic> json) {
    return BookingAvailability(
      availableFor: json["availableFor"] == null ? [] : List<String>.from(json["availableFor"]!.map((x) => x)),
      leadTime: json["leadTime"],
      bookingOptions: json["bookingOptions"] == null ? [] : List<dynamic>.from(json["bookingOptions"]!.map((x) => x)),
      available247: json["available_24_7"],
      serviceHours: json["serviceHours"],
    );
  }

  Map<String, dynamic> toJson() => {
        "availableFor": availableFor.map((x) => x).toList(),
        "leadTime": leadTime,
        "bookingOptions": bookingOptions.map((x) => x).toList(),
        "available_24_7": available247,
        "serviceHours": serviceHours,
      };
}

class BusinessProfile {
  BusinessProfile({
    required this.businessHighlights,
    required this.promotionalDescription,
    required this.description,
  });

  final String? businessHighlights;
  final String? promotionalDescription;
  final String? description;

  factory BusinessProfile.fromJson(Map<String, dynamic> json) {
    return BusinessProfile(
      businessHighlights: json["businessHighlights"],
      promotionalDescription: json["promotionalDescription"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() => {
        "businessHighlights": businessHighlights,
        "promotionalDescription": promotionalDescription,
        "description": description,
      };
}

class CategoryId {
  CategoryId({
    required this.id,
    required this.categoryName,
  });

  final String? id;
  final String? categoryName;

  factory CategoryId.fromJson(Map<String, dynamic> json) {
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

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      couponCode: json["coupon_code"],
      discountType: json["discount_type"],
      discountValue: json["discount_value"] != null ? double.tryParse(json["discount_value"].toString()) : null,
      usageLimit: json["usage_limit"] != null ? int.tryParse(json["usage_limit"].toString()) : null,
      currentUsageCount: json["current_usage_count"] != null ? int.tryParse(json["current_usage_count"].toString()) : null,
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

  factory FleetDetail.fromJson(Map<String, dynamic> json) {
    return FleetDetail(
      vehicleId: json["vehicleId"],
      makeModel: json["make_Model"],
      type: json["type"],
      year: json["year"] != null ? int.tryParse(json["year"].toString()) : null,
      color: json["color"],
      capacity: json["capacity"] != null ? int.tryParse(json["capacity"].toString()) : null,
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

  factory SpecialPriceDay.fromJson(Map<String, dynamic> json) {
    return SpecialPriceDay(
      date: DateTime.tryParse(json["date"] ?? ""),
      price: json["price"] != null ? double.tryParse(json["price"].toString()) : null,
      id: json["_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "date": "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
        "price": price,
        "_id": id,
      };
}

class Documentation {
  Documentation({
    required this.insuranceCertificate,
    required this.v5CDocument,
    required this.vehicleMot,
    required this.driverLicence,
    required this.operatorLicence,
    required this.chauffeurLicences,
  });

  final String? insuranceCertificate;
  final String? v5CDocument;
  final String? vehicleMot;
  final String? driverLicence;
  final String? operatorLicence;
  final String? chauffeurLicences;

  factory Documentation.fromJson(Map<String, dynamic> json) {
    return Documentation(
      insuranceCertificate: json["insuranceCertificate"],
      v5CDocument: json["v5cDocument"],
      vehicleMot: json["vehicleMOT"],
      driverLicence: json["driverLicence"],
      operatorLicence: json["operatorLicence"],
      chauffeurLicences: json["chauffeurLicences"],
    );
  }

  Map<String, dynamic> toJson() => {
        "insuranceCertificate": insuranceCertificate,
        "v5cDocument": v5CDocument,
        "vehicleMOT": vehicleMot,
        "driverLicence": driverLicence,
        "operatorLicence": operatorLicence,
        "chauffeurLicences": chauffeurLicences,
      };
}

class DatumDocuments {
  DatumDocuments({
    required this.publicLiabilityInsurance,
    required this.animalLicense,
    required this.riskAssessment,
  });

  final String? publicLiabilityInsurance;
  final String? animalLicense;
  final String? riskAssessment;

  factory DatumDocuments.fromJson(Map<String, dynamic> json) {
    return DatumDocuments(
      publicLiabilityInsurance: json["publicLiabilityInsurance"],
      animalLicense: json["animalLicense"],
      riskAssessment: json["riskAssessment"],
    );
  }

  Map<String, dynamic> toJson() => {
        "publicLiabilityInsurance": publicLiabilityInsurance,
        "animalLicense": animalLicense,
        "riskAssessment": riskAssessment,
      };
}

class DriverDetail {
  DriverDetail({
    required this.driversUniformed,
    required this.driversDbsChecked,
  });

  final bool? driversUniformed;
  final bool? driversDbsChecked;

  factory DriverDetail.fromJson(Map<String, dynamic> json) {
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

class EquipmentSafety {
  EquipmentSafety({
    required this.safetyChecks,
    required this.isMaintained,
    required this.uniformType,
    required this.offersRouteInspection,
    required this.animalWelfareStandards,
    required this.otherMaintenanceFrequency,
  });

  final List<String> safetyChecks;
  final bool? isMaintained;
  final String? uniformType;
  final bool? offersRouteInspection;
  final List<String> animalWelfareStandards;
  final String? otherMaintenanceFrequency;

  factory EquipmentSafety.fromJson(Map<String, dynamic> json) {
    return EquipmentSafety(
      safetyChecks: json["safetyChecks"] == null ? [] : List<String>.from(json["safetyChecks"]!.map((x) => x)),
      isMaintained: json["isMaintained"],
      uniformType: json["uniformType"],
      offersRouteInspection: json["offersRouteInspection"],
      animalWelfareStandards: json["animalWelfareStandards"] == null ? [] : List<String>.from(json["animalWelfareStandards"]!.map((x) => x)),
      otherMaintenanceFrequency: json["otherMaintenanceFrequency"],
    );
  }

  Map<String, dynamic> toJson() => {
        "safetyChecks": safetyChecks.map((x) => x).toList(),
        "isMaintained": isMaintained,
        "uniformType": uniformType,
        "offersRouteInspection": offersRouteInspection,
        "animalWelfareStandards": animalWelfareStandards.map((x) => x).toList(),
        "otherMaintenanceFrequency": otherMaintenanceFrequency,
      };
}

class FeaturePricing {
  FeaturePricing({
    required this.eventsExtras,
    required this.accessibilityServices,
    required this.eventsAndCustomization,
  });

  final EventsExtras? eventsExtras;
  final AccessibilityServices? accessibilityServices;
  final EventsAndCustomization? eventsAndCustomization;

  factory FeaturePricing.fromJson(Map<String, dynamic> json) {
    return FeaturePricing(
      eventsExtras: json["eventsExtras"] == null ? null : EventsExtras.fromJson(json["eventsExtras"]),
      accessibilityServices: json["accessibilityServices"] == null ? null : AccessibilityServices.fromJson(json["accessibilityServices"]),
      eventsAndCustomization: json["eventsAndCustomization"] == null ? null : EventsAndCustomization.fromJson(json["eventsAndCustomization"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "eventsExtras": eventsExtras?.toJson(),
        "accessibilityServices": accessibilityServices?.toJson(),
        "eventsAndCustomization": eventsAndCustomization?.toJson(),
      };
}

class AccessibilityServices {
  AccessibilityServices({
    required this.wheelchairAccessVehicle,
    required this.childCarSeats,
    required this.strollerBuggyStorage,
    required this.wheelchairAccess,
  });

  final double? wheelchairAccessVehicle;
  final double? childCarSeats;
  final int? strollerBuggyStorage;
  final double? wheelchairAccess;

  factory AccessibilityServices.fromJson(Map<String, dynamic> json) {
    return AccessibilityServices(
      wheelchairAccessVehicle: json["WheelchairAccessVehicle"] != null ? double.tryParse(json["WheelchairAccessVehicle"].toString()) : null,
      childCarSeats: json["ChildCarSeats"] != null ? double.tryParse(json["ChildCarSeats"].toString()) : null,
      strollerBuggyStorage: json["Stroller/BuggyStorage"] != null ? int.tryParse(json["Stroller/BuggyStorage"].toString()) : null,
      wheelchairAccess: json["WheelchairAccess"] != null ? double.tryParse(json["WheelchairAccess"].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "WheelchairAccessVehicle": wheelchairAccessVehicle,
        "ChildCarSeats": childCarSeats,
        "Stroller/BuggyStorage": strollerBuggyStorage,
        "WheelchairAccess": wheelchairAccess,
      };
}

class EventsAndCustomization {
  EventsAndCustomization({
    required this.redCarpetService,
  });

  final double? redCarpetService;

  factory EventsAndCustomization.fromJson(Map<String, dynamic> json) {
    return EventsAndCustomization(
      redCarpetService: json["RedCarpetService"] != null ? double.tryParse(json["RedCarpetService"].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "RedCarpetService": redCarpetService,
      };
}

class EventsExtras {
  EventsExtras({
    required this.partyLightingSystem,
    required this.weddingDcorribbonsFlowers,
    required this.champagnePackages,
    required this.photographyPackages,
  });

  final int? partyLightingSystem;
  final double? weddingDcorribbonsFlowers;
  final double? champagnePackages;
  final int? photographyPackages;

  factory EventsExtras.fromJson(Map<String, dynamic> json) {
    return EventsExtras(
      partyLightingSystem: json["PartyLightingSystem"] != null ? int.tryParse(json["PartyLightingSystem"].toString()) : null,
      weddingDcorribbonsFlowers: json["WeddingDécorribbons,flowers"] != null ? double.tryParse(json["WeddingDécorribbons,flowers"].toString()) : null,
      champagnePackages: json["ChampagnePackages"] != null ? double.tryParse(json["ChampagnePackages"].toString()) : null,
      photographyPackages: json["PhotographyPackages"] != null ? int.tryParse(json["PhotographyPackages"].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "PartyLightingSystem": partyLightingSystem,
        "WeddingDécorribbons,flowers": weddingDcorribbonsFlowers,
        "ChampagnePackages": champagnePackages,
        "PhotographyPackages": photographyPackages,
      };
}

class Features {
  Features({
    required this.comfort,
    required this.events,
    required this.accessibility,
    required this.security,
    required this.comfortAndLuxury,
    required this.eventsAndCustomization,
    required this.accessibilityServices,
    required this.safetyAndCompliance,
  });

  final Comfort? comfort;
  final Events? events;
  final Accessibility? accessibility;
  final Security? security;
  final List<String> comfortAndLuxury;
  final List<String> eventsAndCustomization;
  final List<String> accessibilityServices;
  final List<String> safetyAndCompliance;

  factory Features.fromJson(Map<String, dynamic> json) {
    return Features(
      comfort: json["comfort"] == null ? null : Comfort.fromJson(json["comfort"]),
      events: json["events"] == null ? null : Events.fromJson(json["events"]),
      accessibility: json["accessibility"] == null ? null : Accessibility.fromJson(json["accessibility"]),
      security: json["security"] == null ? null : Security.fromJson(json["security"]),
      comfortAndLuxury: json["comfortAndLuxury"] == null ? [] : List<String>.from(json["comfortAndLuxury"]!.map((x) => x)),
      eventsAndCustomization: json["eventsAndCustomization"] == null ? [] : List<String>.from(json["eventsAndCustomization"]!.map((x) => x)),
      accessibilityServices: json["accessibilityServices"] == null ? [] : List<String>.from(json["accessibilityServices"]!.map((x) => x)),
      safetyAndCompliance: json["safetyAndCompliance"] == null ? [] : List<String>.from(json["safetyAndCompliance"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "comfort": comfort?.toJson(),
        "events": events?.toJson(),
        "accessibility": accessibility?.toJson(),
        "security": security?.toJson(),
        "comfortAndLuxury": comfortAndLuxury.map((x) => x).toList(),
        "eventsAndCustomization": eventsAndCustomization.map((x) => x).toList(),
        "accessibilityServices": accessibilityServices.map((x) => x).toList(),
        "safetyAndCompliance": safetyAndCompliance.map((x) => x).toList(),
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
    required this.childCarSeatsPrice,
    required this.disabledAccessRampPrice,
    required this.seniorAssistancePrice,
    required this.strollerStoragePrice,
  });

  final bool? wheelchairAccessVehicle;
  final bool? petFriendlyService;
  final bool? childCarSeats;
  final bool? disabledAccessRamp;
  final bool? seniorFriendlyAssistance;
  final bool? strollerBuggyStorage;
  final int? wheelchairAccessPrice;
  final int? petFriendlyPrice;
  final int? childCarSeatsPrice;
  final int? disabledAccessRampPrice;
  final int? seniorAssistancePrice;
  final int? strollerStoragePrice;

  factory Accessibility.fromJson(Map<String, dynamic> json) {
    return Accessibility(
      wheelchairAccessVehicle: json["wheelchairAccessVehicle"],
      petFriendlyService: json["petFriendlyService"],
      childCarSeats: json["childCarSeats"],
      disabledAccessRamp: json["disabledAccessRamp"],
      seniorFriendlyAssistance: json["seniorFriendlyAssistance"],
      strollerBuggyStorage: json["strollerBuggyStorage"],
      wheelchairAccessPrice: json["wheelchairAccessPrice"] != null ? int.tryParse(json["wheelchairAccessPrice"].toString()) : null,
      petFriendlyPrice: json["petFriendlyPrice"] != null ? int.tryParse(json["petFriendlyPrice"].toString()) : null,
      childCarSeatsPrice: json["childCarSeatsPrice"] != null ? int.tryParse(json["childCarSeatsPrice"].toString()) : null,
      disabledAccessRampPrice: json["disabledAccessRampPrice"] != null ? int.tryParse(json["disabledAccessRampPrice"].toString()) : null,
      seniorAssistancePrice: json["seniorAssistancePrice"] != null ? int.tryParse(json["seniorAssistancePrice"].toString()) : null,
      strollerStoragePrice: json["strollerStoragePrice"] != null ? int.tryParse(json["strollerStoragePrice"].toString()) : null,
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
        "childCarSeatsPrice": childCarSeatsPrice,
        "disabledAccessRampPrice": disabledAccessRampPrice,
        "seniorAssistancePrice": seniorAssistancePrice,
        "strollerStoragePrice": strollerStoragePrice,
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

  factory Comfort.fromJson(Map<String, dynamic> json) {
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

  factory ComplimentaryDrinks.fromJson(Map<String, dynamic> json) {
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

  factory Events.fromJson(Map<String, dynamic> json) {
    return Events(
      weddingDecor: json["weddingDecor"],
      partyLightingSystem: json["partyLightingSystem"],
      champagnePackages: json["champagnePackages"],
      photographyPackages: json["photographyPackages"],
      weddingDecorPrice: json["weddingDecorPrice"] != null ? int.tryParse(json["weddingDecorPrice"].toString()) : null,
      partyLightingPrice: json["partyLightingPrice"] != null ? int.tryParse(json["partyLightingPrice"].toString()) : null,
      champagnePackagePrice: json["champagnePackagePrice"] != null ? int.tryParse(json["champagnePackagePrice"].toString()) : null,
      photographyPackagePrice: json["photographyPackagePrice"] != null ? int.tryParse(json["photographyPackagePrice"].toString()) : null,
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

  factory Security.fromJson(Map<String, dynamic> json) {
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

  factory FleetDetails.fromJson(Map<String, dynamic> json) {
    return FleetDetails(
      vehicleType: json["vehicleType"],
      makeModel: json["makeModel"],
      color: json["color"],
      capacity: json["capacity"] != null ? int.tryParse(json["capacity"].toString()) : null,
      year: json["year"] != null ? int.tryParse(json["year"].toString()) : null,
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
  });

  final String? makeAndModel;
  final int? year;
  final String? colour;
  final int? seats;
  final String? bootSpace;
  final String? chauffeurName;

  factory FleetInfo.fromJson(Map<String, dynamic> json) {
    return FleetInfo(
      makeAndModel: json["makeAndModel"],
      year: json["year"] != null ? int.tryParse(json["year"].toString()) : null,
      colour: json["colour"],
      seats: json["seats"] != null ? int.tryParse(json["seats"].toString()) : null,
      bootSpace: json["bootSpace"],
      chauffeurName: json["chauffeurName"],
    );
  }

  Map<String, dynamic> toJson() => {
        "makeAndModel": makeAndModel,
        "year": year,
        "colour": colour,
        "seats": seats,
        "bootSpace": bootSpace,
        "chauffeurName": chauffeurName,
      };
}

class FuneralPackageOptions {
  FuneralPackageOptions({
    required this.standard,
    required this.vipExecutive,
  });

  final int? standard;
  final int? vipExecutive;

  factory FuneralPackageOptions.fromJson(Map<String, dynamic> json) {
    return FuneralPackageOptions(
      standard: json["standard"] != null ? int.tryParse(json["standard"].toString()) : null,
      vipExecutive: json["vipExecutive"] != null ? int.tryParse(json["vipExecutive"].toString()) : null,
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

  factory InsuranceDetails.fromJson(Map<String, dynamic> json) {
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
  });

  final LicensingDocuments? documents;

  factory Licensing.fromJson(Map<String, dynamic> json) {
    return Licensing(
      documents: json["documents"] == null ? null : LicensingDocuments.fromJson(json["documents"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "documents": documents?.toJson(),
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

  final OperatorLicence? operatorLicence;
  final ChauffeurDrivingLicence? vehicleInsurance;
  final ChauffeurDrivingLicence? publicLiabilityInsurance;
  final ChauffeurDrivingLicence? v5CLogbook;
  final ChauffeurDrivingLicence? chauffeurDrivingLicence;

  factory LicensingDocuments.fromJson(Map<String, dynamic> json) {
    return LicensingDocuments(
      operatorLicence: json["operatorLicence"] == null ? null : OperatorLicence.fromJson(json["operatorLicence"]),
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

  factory ChauffeurDrivingLicence.fromJson(Map<String, dynamic> json) {
    return ChauffeurDrivingLicence(
      isAttached: json["isAttached"],
    );
  }

  Map<String, dynamic> toJson() => {
        "isAttached": isAttached,
      };
}

class OperatorLicence {
  OperatorLicence({
    required this.isAttached,
    required this.image,
  });

  final bool? isAttached;
  final String? image;

  factory OperatorLicence.fromJson(Map<String, dynamic> json) {
    return OperatorLicence(
      isAttached: json["isAttached"],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
        "isAttached": isAttached,
        "image": image,
      };
}

class LicensingDetails {
  LicensingDetails({
    required this.operatorLicenceNumber,
    required this.licensingAuthority,
  });

  final String? operatorLicenceNumber;
  final String? licensingAuthority;

  factory LicensingDetails.fromJson(Map<String, dynamic> json) {
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

  factory LicensingInsurance.fromJson(Map<String, dynamic> json) {
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

  factory ListingData.fromJson(Map<String, dynamic> json) {
    return ListingData(
      summary: json["summary"] == null ? null : Summary.fromJson(json["summary"]),
      title: json["title"],
      description: json["description"],
      price: json["price"] != null ? int.tryParse(json["price"].toString()) : null,
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

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      dayRate: json["day_rate"] != null ? int.tryParse(json["day_rate"].toString()) : null,
      hourlyRate: json["hourly_rate"] != null ? int.tryParse(json["hourly_rate"].toString()) : null,
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
    required this.promoVideoLink,
  });

  final String? description;
  final List<dynamic> serviceHighlights;
  final String? promoVideoLink;

  factory Marketing.fromJson(Map<String, dynamic> json) {
    return Marketing(
      description: json["description"],
      serviceHighlights: json["serviceHighlights"] == null ? [] : List<dynamic>.from(json["serviceHighlights"]!.map((x) => x)),
      promoVideoLink: json["promoVideoLink"],
    );
  }

  Map<String, dynamic> toJson() => {
        "description": description,
        "serviceHighlights": serviceHighlights.map((x) => x).toList(),
        "promoVideoLink": promoVideoLink,
      };
}

class Media {
  Media({
    required this.chauffeurPhoto,
  });

  final String? chauffeurPhoto;

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      chauffeurPhoto: json["chauffeurPhoto"],
    );
  }

  Map<String, dynamic> toJson() => {
        "chauffeurPhoto": chauffeurPhoto,
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

  factory OccasionsCatered.fromJson(Map<String, dynamic> json) {
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

class Pricing {
  Pricing({
    required this.hourlyRate,
    required this.halfDayRate,
    required this.fullDayRate,
    required this.ceremonyPackageRate,
  });

  final int? hourlyRate;
  final int? halfDayRate;
  final double? fullDayRate;
  final int? ceremonyPackageRate;

  factory Pricing.fromJson(Map<String, dynamic> json) {
    return Pricing(
      hourlyRate: json["hourlyRate"] != null ? int.tryParse(json["hourlyRate"].toString()) : null,
      halfDayRate: json["halfDayRate"] != null ? int.tryParse(json["halfDayRate"].toString()) : null,
      fullDayRate: json["fullDayRate"] != null ? double.tryParse(json["fullDayRate"].toString()) : null,
      ceremonyPackageRate: json["ceremonyPackageRate"] != null ? int.tryParse(json["ceremonyPackageRate"].toString()) : null,
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
    required this.halfDayRate,
    required this.hourlyRate,
    required this.fuelChargesIncluded,
    required this.extraMileageCharge,
    required this.waitTimeFeePerHour,
    required this.decoratingFloralServiceFee,
    required this.mileageLimit,
    required this.chauffeurIncluded,
    required this.weddingPackage,
    required this.airportTransfer,
  });

  final double? dayRate;
  final double? halfDayRate;
  final double? hourlyRate;
  final bool? fuelChargesIncluded;
  final double? extraMileageCharge;
  final double? waitTimeFeePerHour;
  final int? decoratingFloralServiceFee;
  final double? mileageLimit;
  final bool? chauffeurIncluded;
  final int? weddingPackage;
  final int? airportTransfer;

  factory PricingDetails.fromJson(Map<String, dynamic> json) {
    return PricingDetails(
      dayRate: json["dayRate"] != null ? double.tryParse(json["dayRate"].toString()) : null,
      halfDayRate: json["halfDayRate"] != null ? double.tryParse(json["halfDayRate"].toString()) : null,
      hourlyRate: json["hourlyRate"] != null ? double.tryParse(json["hourlyRate"].toString()) : null,
      fuelChargesIncluded: json["fuelChargesIncluded"],
      extraMileageCharge: json["extraMileageCharge"] != null ? double.tryParse(json["extraMileageCharge"].toString()) : null,
      waitTimeFeePerHour: json["waitTimeFeePerHour"] != null ? double.tryParse(json["waitTimeFeePerHour"].toString()) : null,
      decoratingFloralServiceFee: json["decoratingFloralServiceFee"] != null ? int.tryParse(json["decoratingFloralServiceFee"].toString()) : null,
      mileageLimit: json["mileageLimit"] != null ? double.tryParse(json["mileageLimit"].toString()) : null,
      chauffeurIncluded: json["chauffeurIncluded"],
      weddingPackage: json["weddingPackage"] != null ? int.tryParse(json["weddingPackage"].toString()) : null,
      airportTransfer: json["airportTransfer"] != null ? int.tryParse(json["airportTransfer"].toString()) : null,
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
        "chauffeurIncluded": chauffeurIncluded,
        "weddingPackage": weddingPackage,
        "airportTransfer": airportTransfer,
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

  factory ServiceDetail.fromJson(Map<String, dynamic> json) {
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
    required this.otherOccasion,
    required this.otherCarriageType,
    required this.otherHorseType,
  });

  final List<String> occasionsCatered;
  final List<String> carriageTypes;
  final List<String> horseTypes;
  final int? numberOfCarriages;
  final int? fleetSize;
  final String? basePostcode;
  final String? otherOccasion;
  final String? otherCarriageType;
  final String? otherHorseType;

  factory ServiceDetails.fromJson(Map<String, dynamic> json) {
    return ServiceDetails(
      occasionsCatered: json["occasionsCatered"] == null ? [] : List<String>.from(json["occasionsCatered"]!.map((x) => x)),
      carriageTypes: json["carriageTypes"] == null ? [] : List<String>.from(json["carriageTypes"]!.map((x) => x)),
      horseTypes: json["horseTypes"] == null ? [] : List<String>.from(json["horseTypes"]!.map((x) => x)),
      numberOfCarriages: json["numberOfCarriages"] != null ? int.tryParse(json["numberOfCarriages"].toString()) : null,
      fleetSize: json["fleetSize"] != null ? int.tryParse(json["fleetSize"].toString()) : null,
      basePostcode: json["basePostcode"],
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
        "otherOccasion": otherOccasion,
        "otherCarriageType": otherCarriageType,
        "otherHorseType": otherHorseType,
      };
}

class SubcategoryId {
  SubcategoryId({
    required this.id,
    required this.subcategoryName,
  });

  final String? id;
  final String? subcategoryName;

  factory SubcategoryId.fromJson(Map<String, dynamic> json) {
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

  factory UploadedDocuments.fromJson(Map<String, dynamic> json) {
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
