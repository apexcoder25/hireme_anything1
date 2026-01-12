import 'package:hire_any_thing/data/models/user_side_model/CouponSharedModel.dart';

class LimousineServiceDetail {
    LimousineServiceDetail({
        required this.fleetInfo,
        required this.operatingHours,
        required this.pricingDetails,
        required this.comfort,
        required this.events,
        required this.accessibility,
        required this.security,
        required this.marketingHighlights,
        required this.id,
        required this.categoryId,
        required this.subcategoryId,
        required this.vendorId,
        required this.serviceType,
        required this.listingTitle,
        required this.numberOfLimousines,
        required this.fleetType,
        required this.otherFleetType,
        required this.wheelchairAccessibleVehicles,
        required this.fleetFeatures,
        required this.otherFleetFeature,
        required this.baseLocationPostcode,
        required this.locationRadius,
        required this.areasCovered,
        required this.occasionsCovered,
        required this.otherOccasions,
        required this.is24X7,
        required this.offeringPrice,
        required this.hireTypes,
        required this.otherHireType,
        required this.packageDeals,
        required this.serviceStatus,
        required this.serviceApproveStatus,
        required this.bookingDateFrom,
        required this.bookingDateTo,
        required this.specialPriceDays,
        required this.operatorLicenceNumber,
        required this.licensingAuthority,
        required this.insuranceProvider,
        required this.policyNumber,
        required this.policyExpiry,
        required this.documents,
        required this.serviceImage,
        required this.coupons,
        required this.availableDays,
        required this.cancellationPolicyType,
        required this.commissionPolicyAccepted,
        required this.commissionPolicyVersion,
        required this.commissionRate,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final FleetInfo? fleetInfo;
    final OperatingHours? operatingHours;
    final PricingDetails? pricingDetails;
    final Comfort? comfort;
    final Events? events;
    final Accessibility? accessibility;
    final Security? security;
    final MarketingHighlights? marketingHighlights;
    final String? id;
    final String? categoryId;
    final SubcategoryId? subcategoryId;
    final String? vendorId;
    final String? serviceType;
    final String? listingTitle;
    final int? numberOfLimousines;
    final String? fleetType;
    final String? otherFleetType;
    final bool? wheelchairAccessibleVehicles;
    final List<String> fleetFeatures;
    final String? otherFleetFeature;
    final String? baseLocationPostcode;
    final int? locationRadius;
    final List<String> areasCovered;
    final List<String> occasionsCovered;
    final String? otherOccasions;
    final bool? is24X7;
    final int? offeringPrice;
    final List<String> hireTypes;
    final String? otherHireType;
    final List<PackageDeal> packageDeals;
    final String? serviceStatus;
    final String? serviceApproveStatus;
    final DateTime? bookingDateFrom;
    final DateTime? bookingDateTo;
    final List<dynamic> specialPriceDays;
    final String? operatorLicenceNumber;
    final String? licensingAuthority;
    final String? insuranceProvider;
    final String? policyNumber;
    final dynamic policyExpiry;
    final Documents? documents;
    final List<String> serviceImage;
   final List<Coupon> coupons;
    final List<String> availableDays;
    final String? cancellationPolicyType;
    final bool? commissionPolicyAccepted;
    final DateTime? commissionPolicyVersion;
    final int? commissionRate;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory LimousineServiceDetail.fromJson(Map<String, dynamic> json){ 
        return LimousineServiceDetail(
            fleetInfo: json["fleetInfo"] == null ? null : FleetInfo.fromJson(json["fleetInfo"]),
            operatingHours: json["operatingHours"] == null ? null : OperatingHours.fromJson(json["operatingHours"]),
            pricingDetails: json["pricingDetails"] == null ? null : PricingDetails.fromJson(json["pricingDetails"]),
            comfort: json["comfort"] == null ? null : Comfort.fromJson(json["comfort"]),
            events: json["events"] == null ? null : Events.fromJson(json["events"]),
            accessibility: json["accessibility"] == null ? null : Accessibility.fromJson(json["accessibility"]),
            security: json["security"] == null ? null : Security.fromJson(json["security"]),
            marketingHighlights: json["marketingHighlights"] == null ? null : MarketingHighlights.fromJson(json["marketingHighlights"]),
            id: json["_id"],
            categoryId: json["categoryId"],
            subcategoryId: json["subcategoryId"] == null ? null : SubcategoryId.fromJson(json["subcategoryId"]),
            vendorId: json["vendorId"],
            serviceType: json["service_type"],
            listingTitle: json["listingTitle"],
            numberOfLimousines: json["numberOfLimousines"],
            fleetType: json["fleetType"],
            otherFleetType: json["otherFleetType"],
            wheelchairAccessibleVehicles: json["wheelchairAccessibleVehicles"],
            fleetFeatures: json["fleetFeatures"] == null ? [] : List<String>.from(json["fleetFeatures"]!.map((x) => x)),
            otherFleetFeature: json["otherFleetFeature"],
            baseLocationPostcode: json["baseLocationPostcode"],
            locationRadius: json["locationRadius"],
            areasCovered: json["areasCovered"] == null ? [] : List<String>.from(json["areasCovered"]!.map((x) => x)),
            occasionsCovered: json["occasionsCovered"] == null ? [] : List<String>.from(json["occasionsCovered"]!.map((x) => x)),
            otherOccasions: json["otherOccasions"],
            is24X7: json["is24x7"],
            offeringPrice: json["offering_price"],
            hireTypes: json["hireTypes"] == null ? [] : List<String>.from(json["hireTypes"]!.map((x) => x)),
            otherHireType: json["otherHireType"],
            packageDeals: json["packageDeals"] == null ? [] : List<PackageDeal>.from(json["packageDeals"]!.map((x) => PackageDeal.fromJson(x))),
            serviceStatus: json["service_status"],
            serviceApproveStatus: json["service_approve_status"],
            bookingDateFrom: DateTime.tryParse(json["booking_date_from"] ?? ""),
            bookingDateTo: DateTime.tryParse(json["booking_date_to"] ?? ""),
            specialPriceDays: json["special_price_days"] == null ? [] : List<dynamic>.from(json["special_price_days"]!.map((x) => x)),
            operatorLicenceNumber: json["operatorLicenceNumber"],
            licensingAuthority: json["licensingAuthority"],
            insuranceProvider: json["insuranceProvider"],
            policyNumber: json["policyNumber"],
            policyExpiry: json["policyExpiry"],
            documents: json["documents"] == null ? null : Documents.fromJson(json["documents"]),
            serviceImage: json["service_image"] == null ? [] : List<String>.from(json["service_image"]!.map((x) => x)),
           coupons: json["coupons"] == null 
    ? [] 
    : List<Coupon>.from(json["coupons"].map((x) => Coupon.fromJson(x))),
            availableDays: json["availableDays"] == null ? [] : List<String>.from(json["availableDays"]!.map((x) => x)),
            cancellationPolicyType: json["cancellation_policy_type"],
            commissionPolicyAccepted: json["commissionPolicyAccepted"],
            commissionPolicyVersion: DateTime.tryParse(json["commissionPolicyVersion"] ?? ""),
            commissionRate: json["commissionRate"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
        );
    }

    Map<String, dynamic> toJson() => {
        "fleetInfo": fleetInfo?.toJson(),
        "operatingHours": operatingHours?.toJson(),
        "pricingDetails": pricingDetails?.toJson(),
        "comfort": comfort?.toJson(),
        "events": events?.toJson(),
        "accessibility": accessibility?.toJson(),
        "security": security?.toJson(),
        "marketingHighlights": marketingHighlights?.toJson(),
        "_id": id,
        "categoryId": categoryId,
        "subcategoryId": subcategoryId?.toJson(),
        "vendorId": vendorId,
        "service_type": serviceType,
        "listingTitle": listingTitle,
        "numberOfLimousines": numberOfLimousines,
        "fleetType": fleetType,
        "otherFleetType": otherFleetType,
        "wheelchairAccessibleVehicles": wheelchairAccessibleVehicles,
        "fleetFeatures": fleetFeatures.map((x) => x).toList(),
        "otherFleetFeature": otherFleetFeature,
        "baseLocationPostcode": baseLocationPostcode,
        "locationRadius": locationRadius,
        "areasCovered": areasCovered.map((x) => x).toList(),
        "occasionsCovered": occasionsCovered.map((x) => x).toList(),
        "otherOccasions": otherOccasions,
        "is24x7": is24X7,
        "offering_price": offeringPrice,
        "hireTypes": hireTypes.map((x) => x).toList(),
        "otherHireType": otherHireType,
        "packageDeals": packageDeals.map((x) => x?.toJson()).toList(),
        "service_status": serviceStatus,
        "service_approve_status": serviceApproveStatus,
        "booking_date_from": bookingDateFrom?.toIso8601String(),
        "booking_date_to": bookingDateTo?.toIso8601String(),
        "special_price_days": specialPriceDays.map((x) => x).toList(),
        "operatorLicenceNumber": operatorLicenceNumber,
        "licensingAuthority": licensingAuthority,
        "insuranceProvider": insuranceProvider,
        "policyNumber": policyNumber,
        "policyExpiry": policyExpiry,
        "documents": documents?.toJson(),
        "service_image": serviceImage.map((x) => x).toList(),
        "coupons": coupons.map((x) => x?.toJson()).toList(),
        "availableDays": availableDays.map((x) => x).toList(),
        "cancellation_policy_type": cancellationPolicyType,
        "commissionPolicyAccepted": commissionPolicyAccepted,
        "commissionPolicyVersion": "${commissionPolicyVersion!.year.toString().padLeft(4)}-${commissionPolicyVersion!.month.toString().padLeft(2)}-${commissionPolicyVersion?.day.toString().padLeft(2)}",
        "commissionRate": commissionRate,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
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

class Comfort {
    Comfort({
        required this.complimentaryDrinks,
        required this.leatherInterior,
        required this.wifiAccess,
        required this.airConditioning,
        required this.inCarEntertainment,
        required this.bluetoothUsb,
        required this.redCarpetService,
        required this.recliningSeats,
        required this.starlights,
        required this.massagingSeats,
        required this.onboardRestroom,
    });

    final ComplimentaryDrinks? complimentaryDrinks;
    final bool? leatherInterior;
    final bool? wifiAccess;
    final bool? airConditioning;
    final bool? inCarEntertainment;
    final bool? bluetoothUsb;
    final bool? redCarpetService;
    final bool? recliningSeats;
    final bool? starlights;
    final bool? massagingSeats;
    final bool? onboardRestroom;

    factory Comfort.fromJson(Map<String, dynamic> json){ 
        return Comfort(
            complimentaryDrinks: json["complimentaryDrinks"] == null ? null : ComplimentaryDrinks.fromJson(json["complimentaryDrinks"]),
            leatherInterior: json["leatherInterior"],
            wifiAccess: json["wifiAccess"],
            airConditioning: json["airConditioning"],
            inCarEntertainment: json["inCarEntertainment"],
            bluetoothUsb: json["bluetoothUsb"],
            redCarpetService: json["redCarpetService"],
            recliningSeats: json["recliningSeats"],
            starlights: json["starlights"],
            massagingSeats: json["massagingSeats"],
            onboardRestroom: json["onboardRestroom"],
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
        "recliningSeats": recliningSeats,
        "starlights": starlights,
        "massagingSeats": massagingSeats,
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


class Documents {
    Documents({
        required this.v5CDocument,
        required this.vehicleMot,
        required this.driverLicence,
    });

    final DriverLicence? v5CDocument;
    final DriverLicence? vehicleMot;
    final DriverLicence? driverLicence;

    factory Documents.fromJson(Map<String, dynamic> json){ 
        return Documents(
            v5CDocument: json["v5cDocument"] == null ? null : DriverLicence.fromJson(json["v5cDocument"]),
            vehicleMot: json["vehicleMOT"] == null ? null : DriverLicence.fromJson(json["vehicleMOT"]),
            driverLicence: json["driverLicence"] == null ? null : DriverLicence.fromJson(json["driverLicence"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "v5cDocument": v5CDocument?.toJson(),
        "vehicleMOT": vehicleMot?.toJson(),
        "driverLicence": driverLicence?.toJson(),
    };

}

class DriverLicence {
    DriverLicence({
        required this.isAttached,
        required this.image,
    });

    final bool? isAttached;
    final String? image;

    factory DriverLicence.fromJson(Map<String, dynamic> json){ 
        return DriverLicence(
            isAttached: json["isAttached"],
            image: json["image"],
        );
    }

    Map<String, dynamic> toJson() => {
        "isAttached": isAttached,
        "image": image,
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
        required this.champagnePackageDetails,
        required this.photographyPackages,
        required this.photographyPackagePrice,
        required this.photographyDuration,
        required this.photographyTeamSize,
        required this.photographyPackageDetails,
        required this.photographyDeliveryTime,
        required this.champagneBrand,
        required this.champagneBottles,
    });

    final bool? weddingDecor;
    final dynamic weddingDecorPrice;
    final bool? partyLightingSystem;
    final int? partyLightingPrice;
    final bool? champagnePackages;
    final dynamic champagnePackagePrice;
    final String? champagnePackageDetails;
    final bool? photographyPackages;
    final dynamic photographyPackagePrice;
    final String? photographyDuration;
    final String? photographyTeamSize;
    final String? photographyPackageDetails;
    final String? photographyDeliveryTime;
    final String? champagneBrand;
    final int? champagneBottles;

    factory Events.fromJson(Map<String, dynamic> json){ 
        return Events(
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

    Map<String, dynamic> toJson() => {
        "weddingDecor": weddingDecor,
        "weddingDecorPrice": weddingDecorPrice,
        "partyLightingSystem": partyLightingSystem,
        "partyLightingPrice": partyLightingPrice,
        "champagnePackages": champagnePackages,
        "champagnePackagePrice": champagnePackagePrice,
        "champagnePackageDetails": champagnePackageDetails,
        "photographyPackages": photographyPackages,
        "photographyPackagePrice": photographyPackagePrice,
        "photographyDuration": photographyDuration,
        "photographyTeamSize": photographyTeamSize,
        "photographyPackageDetails": photographyPackageDetails,
        "photographyDeliveryTime": photographyDeliveryTime,
        "champagneBrand": champagneBrand,
        "champagneBottles": champagneBottles,
    };

}

class FleetInfo {
    FleetInfo({
        required this.makeAndModel,
        required this.seats,
        required this.largeSuitcases,
        required this.mediumSuitcases,
        required this.smallSuitcases,
        required this.firstRegistration,
        required this.colour,
    });

    final String? makeAndModel;
    final int? seats;
    final int? largeSuitcases;
    final int? mediumSuitcases;
    final int? smallSuitcases;
    final DateTime? firstRegistration;
    final String? colour;

    factory FleetInfo.fromJson(Map<String, dynamic> json){ 
        return FleetInfo(
            makeAndModel: json["makeAndModel"],
            seats: json["seats"],
            largeSuitcases: json["largeSuitcases"],
            mediumSuitcases: json["mediumSuitcases"],
            smallSuitcases: json["smallSuitcases"],
            firstRegistration: DateTime.tryParse(json["firstRegistration"] ?? ""),
            colour: json["colour"],
        );
    }

    Map<String, dynamic> toJson() => {
        "makeAndModel": makeAndModel,
        "seats": seats,
        "largeSuitcases": largeSuitcases,
        "mediumSuitcases": mediumSuitcases,
        "smallSuitcases": smallSuitcases,
        "firstRegistration": firstRegistration?.toIso8601String(),
        "colour": colour,
    };

}

class MarketingHighlights {
    MarketingHighlights({
        required this.highlights,
        required this.shortDescription,
    });

    final String? highlights;
    final String? shortDescription;

    factory MarketingHighlights.fromJson(Map<String, dynamic> json){ 
        return MarketingHighlights(
            highlights: json["highlights"],
            shortDescription: json["shortDescription"],
        );
    }

    Map<String, dynamic> toJson() => {
        "highlights": highlights,
        "shortDescription": shortDescription,
    };

}

class OperatingHours {
    OperatingHours({
        required this.seasonalClosures,
    });

    final String? seasonalClosures;

    factory OperatingHours.fromJson(Map<String, dynamic> json){ 
        return OperatingHours(
            seasonalClosures: json["seasonalClosures"],
        );
    }

    Map<String, dynamic> toJson() => {
        "seasonalClosures": seasonalClosures,
    };

}

class PackageDeal {
    PackageDeal({
        required this.packageName,
        required this.packageDescription,
        required this.packageRate,
        required this.inclusions,
        required this.id,
    });

    final String? packageName;
    final String? packageDescription;
    final int? packageRate;
    final List<String> inclusions;
    final String? id;

    factory PackageDeal.fromJson(Map<String, dynamic> json){ 
        return PackageDeal(
            packageName: json["packageName"],
            packageDescription: json["packageDescription"],
            packageRate: json["packageRate"],
            inclusions: json["inclusions"] == null ? [] : List<String>.from(json["inclusions"]!.map((x) => x)),
            id: json["_id"],
        );
    }

    Map<String, dynamic> toJson() => {
        "packageName": packageName,
        "packageDescription": packageDescription,
        "packageRate": packageRate,
        "inclusions": inclusions.map((x) => x).toList(),
        "_id": id,
    };

}

class PricingDetails {
    PricingDetails({
        required this.hourlyRate,
        required this.halfDayRate,
        required this.fullDayRate,
        required this.additionalMileageFee,
        required this.mileageLimit,
    });

    final int? hourlyRate;
    final int? halfDayRate;
    final int? fullDayRate;
    final double? additionalMileageFee;
    final int? mileageLimit;

    factory PricingDetails.fromJson(Map<String, dynamic> json){ 
        return PricingDetails(
            hourlyRate: json["hourlyRate"],
            halfDayRate: json["halfDayRate"],
            fullDayRate: json["fullDayRate"],
            additionalMileageFee: json["additionalMileageFee"],
            mileageLimit: json["mileageLimit"],
        );
    }

    Map<String, dynamic> toJson() => {
        "hourlyRate": hourlyRate,
        "halfDayRate": halfDayRate,
        "fullDayRate": fullDayRate,
        "additionalMileageFee": additionalMileageFee,
        "mileageLimit": mileageLimit,
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
