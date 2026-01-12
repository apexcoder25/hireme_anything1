import 'package:hire_any_thing/data/models/user_side_model/CouponSharedModel.dart';

class HorsePartnersDetails {
    HorsePartnersDetails({
        required this.carriageDetails,
        required this.marketing,
        required this.pricing,
        required this.features,
        required this.equipmentSafety,
        required this.id,
        required this.categoryId,
        required this.subcategoryId,
        required this.vendorId,
        required this.listingTitle,
        required this.basePostcode,
        required this.locationRadius,
        required this.areasCovered,
        required this.serviceStatus,
        required this.serviceTypes,
        required this.otherServiceType,
        required this.documents,
        required this.offeringPrice,
        required this.hireTypes,
        required this.otherHireType,
        required this.packageDeals,
        required this.bookingDateFrom,
        required this.bookingDateTo,
        required this.specialPriceDays,
        required this.serviceImage,
        required this.approvalStatus,
        required this.serviceApproveStatus,
        required this.coupons,
        required this.cancellationPolicyType,
        required this.commissionPolicyAccepted,
        required this.commissionPolicyVersion,
        required this.commissionRate,
        required this.createdAt,
        required this.v,
    });

    final CarriageDetails? carriageDetails;
    final Marketing? marketing;
    final Pricing? pricing;
    final Features? features;
    final EquipmentSafety? equipmentSafety;
    final String? id;
    final String? categoryId;
    final SubcategoryId? subcategoryId;
    final String? vendorId;
    final String? listingTitle;
    final String? basePostcode;
    final int? locationRadius;
    final List<String> areasCovered;
    final String? serviceStatus;
    final List<String> serviceTypes;
    final String? otherServiceType;
    final Documents? documents;
    final int? offeringPrice;
    final List<dynamic> hireTypes;
    final String? otherHireType;
    final List<PackageDeal> packageDeals;
    final DateTime? bookingDateFrom;
    final DateTime? bookingDateTo;
    final List<dynamic> specialPriceDays;
    final List<String> serviceImage;
    final String? approvalStatus;
    final bool? serviceApproveStatus;
    final List<Coupon> coupons;
    final String? cancellationPolicyType;
    final bool? commissionPolicyAccepted;
    final DateTime? commissionPolicyVersion;
    final int? commissionRate;
    final DateTime? createdAt;
    final int? v;

    factory HorsePartnersDetails.fromJson(Map<String, dynamic> json){ 
        return HorsePartnersDetails(
            carriageDetails: json["carriageDetails"] == null ? null : CarriageDetails.fromJson(json["carriageDetails"]),
            marketing: json["marketing"] == null ? null : Marketing.fromJson(json["marketing"]),
            pricing: json["pricing"] == null ? null : Pricing.fromJson(json["pricing"]),
            features: json["features"] == null ? null : Features.fromJson(json["features"]),
            equipmentSafety: json["equipmentSafety"] == null ? null : EquipmentSafety.fromJson(json["equipmentSafety"]),
            id: json["_id"],
            categoryId: json["categoryId"],
            subcategoryId: json["subcategoryId"] == null ? null : SubcategoryId.fromJson(json["subcategoryId"]),
            vendorId: json["vendorId"],
            listingTitle: json["listingTitle"],
            basePostcode: json["basePostcode"],
            locationRadius: json["locationRadius"],
            areasCovered: json["areasCovered"] == null ? [] : List<String>.from(json["areasCovered"]!.map((x) => x)),
            serviceStatus: json["service_status"],
            serviceTypes: json["serviceTypes"] == null ? [] : List<String>.from(json["serviceTypes"]!.map((x) => x)),
            otherServiceType: json["otherServiceType"],
            documents: json["documents"] == null ? null : Documents.fromJson(json["documents"]),
            offeringPrice: json["offering_price"],
            hireTypes: json["hireTypes"] == null ? [] : List<dynamic>.from(json["hireTypes"]!.map((x) => x)),
            otherHireType: json["otherHireType"],
            packageDeals: json["packageDeals"] == null ? [] : List<PackageDeal>.from(json["packageDeals"]!.map((x) => PackageDeal.fromJson(x))),
            bookingDateFrom: DateTime.tryParse(json["booking_date_from"] ?? ""),
            bookingDateTo: DateTime.tryParse(json["booking_date_to"] ?? ""),
            specialPriceDays: json["special_price_days"] == null ? [] : List<dynamic>.from(json["special_price_days"]!.map((x) => x)),
            serviceImage: json["service_image"] == null ? [] : List<String>.from(json["service_image"]!.map((x) => x)),
            approvalStatus: json["approvalStatus"],
            serviceApproveStatus: json["service_approve_status"],
            coupons: json["coupons"] == null ? [] : List<Coupon>.from(json["coupons"]!.map((x) => Coupon.fromJson(x))),
            cancellationPolicyType: json["cancellation_policy_type"],
            commissionPolicyAccepted: json["commissionPolicyAccepted"],
            commissionPolicyVersion: DateTime.tryParse(json["commissionPolicyVersion"] ?? ""),
            commissionRate: json["commissionRate"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            v: json["__v"],
        );
    }

    Map<String, dynamic> toJson() => {
        "carriageDetails": carriageDetails?.toJson(),
        "marketing": marketing?.toJson(),
        "pricing": pricing?.toJson(),
        "features": features?.toJson(),
        "equipmentSafety": equipmentSafety?.toJson(),
        "_id": id,
        "categoryId": categoryId,
        "subcategoryId": subcategoryId?.toJson(),
        "vendorId": vendorId,
        "listingTitle": listingTitle,
        "basePostcode": basePostcode,
        "locationRadius": locationRadius,
        "areasCovered": areasCovered.map((x) => x).toList(),
        "service_status": serviceStatus,
        "serviceTypes": serviceTypes.map((x) => x).toList(),
        "otherServiceType": otherServiceType,
        "documents": documents?.toJson(),
        "offering_price": offeringPrice,
        "hireTypes": hireTypes.map((x) => x).toList(),
        "otherHireType": otherHireType,
        "packageDeals": packageDeals.map((x) => x?.toJson()).toList(),
        "booking_date_from": bookingDateFrom?.toIso8601String(),
        "booking_date_to": bookingDateTo?.toIso8601String(),
        "special_price_days": specialPriceDays.map((x) => x).toList(),
        "service_image": serviceImage.map((x) => x).toList(),
        "approvalStatus": approvalStatus,
        "service_approve_status": serviceApproveStatus,
        "coupons": coupons.map((x) => x?.toJson()).toList(),
        "cancellation_policy_type": cancellationPolicyType,
        "commissionPolicyAccepted": commissionPolicyAccepted,
        "commissionPolicyVersion": "${commissionPolicyVersion!.year.toString().padLeft(4)}-${commissionPolicyVersion!.month.toString().padLeft(2)}-${commissionPolicyVersion!.day.toString().padLeft(2)}",
        "commissionRate": commissionRate,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
    };

}

class CarriageDetails {
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

    final String? carriageType;
    final int? numberOfCarriages;
    final int? horseCount;
    final List<String> horseBreeds;
    final String? otherHorseBreed;
    final List<String> horseColors;
    final String? otherHorseColor;
    final int? seats;
    final List<String> decorationOptions;
    final String? otherDecoration;

    factory CarriageDetails.fromJson(Map<String, dynamic> json){ 
        return CarriageDetails(
            carriageType: json["carriageType"],
            numberOfCarriages: json["numberOfCarriages"],
            horseCount: json["horseCount"],
            horseBreeds: json["horseBreeds"] == null ? [] : List<String>.from(json["horseBreeds"]!.map((x) => x)),
            otherHorseBreed: json["otherHorseBreed"],
            horseColors: json["horseColors"] == null ? [] : List<String>.from(json["horseColors"]!.map((x) => x)),
            otherHorseColor: json["otherHorseColor"],
            seats: json["seats"],
            decorationOptions: json["decorationOptions"] == null ? [] : List<String>.from(json["decorationOptions"]!.map((x) => x)),
            otherDecoration: json["otherDecoration"],
        );
    }

    Map<String, dynamic> toJson() => {
        "carriageType": carriageType,
        "numberOfCarriages": numberOfCarriages,
        "horseCount": horseCount,
        "horseBreeds": horseBreeds.map((x) => x).toList(),
        "otherHorseBreed": otherHorseBreed,
        "horseColors": horseColors.map((x) => x).toList(),
        "otherHorseColor": otherHorseColor,
        "seats": seats,
        "decorationOptions": decorationOptions.map((x) => x).toList(),
        "otherDecoration": otherDecoration,
    };

}



class Documents {
    Documents({
        required this.animalLicense,
        required this.riskAssessment,
    });

    final AnimalLicense? animalLicense;
    final AnimalLicense? riskAssessment;

    factory Documents.fromJson(Map<String, dynamic> json){ 
        return Documents(
            animalLicense: json["animalLicense"] == null ? null : AnimalLicense.fromJson(json["animalLicense"]),
            riskAssessment: json["riskAssessment"] == null ? null : AnimalLicense.fromJson(json["riskAssessment"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "animalLicense": animalLicense?.toJson(),
        "riskAssessment": riskAssessment?.toJson(),
    };

}

class AnimalLicense {
    AnimalLicense({
        required this.isAttached,
        required this.image,
    });

    final bool? isAttached;
    final String? image;

    factory AnimalLicense.fromJson(Map<String, dynamic> json){ 
        return AnimalLicense(
            isAttached: json["isAttached"],
            image: json["image"],
        );
    }

    Map<String, dynamic> toJson() => {
        "isAttached": isAttached,
        "image": image,
    };

}

class EquipmentSafety {
    EquipmentSafety({
        required this.safetyChecks,
        required this.isMaintained,
        required this.maintenanceFrequency,
        required this.uniformType,
        required this.offersRouteInspection,
        required this.animalWelfareStandards,
    });

    final List<dynamic> safetyChecks;
    final bool? isMaintained;
    final String? maintenanceFrequency;
    final String? uniformType;
    final bool? offersRouteInspection;
    final List<String> animalWelfareStandards;

    factory EquipmentSafety.fromJson(Map<String, dynamic> json){ 
        return EquipmentSafety(
            safetyChecks: json["safetyChecks"] == null ? [] : List<dynamic>.from(json["safetyChecks"]!.map((x) => x)),
            isMaintained: json["isMaintained"],
            maintenanceFrequency: json["maintenanceFrequency"],
            uniformType: json["uniformType"],
            offersRouteInspection: json["offersRouteInspection"],
            animalWelfareStandards: json["animalWelfareStandards"] == null ? [] : List<String>.from(json["animalWelfareStandards"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "safetyChecks": safetyChecks.map((x) => x).toList(),
        "isMaintained": isMaintained,
        "maintenanceFrequency": maintenanceFrequency,
        "uniformType": uniformType,
        "offersRouteInspection": offersRouteInspection,
        "animalWelfareStandards": animalWelfareStandards.map((x) => x).toList(),
    };

}

class Features {
    Features({
        required this.comfort,
        required this.events,
        required this.accessibility,
        required this.safety,
    });

    final Comfort? comfort;
    final Events? events;
    final Accessibility? accessibility;
    final Safety? safety;

    factory Features.fromJson(Map<String, dynamic> json){ 
        return Features(
            comfort: json["comfort"] == null ? null : Comfort.fromJson(json["comfort"]),
            events: json["events"] == null ? null : Events.fromJson(json["events"]),
            accessibility: json["accessibility"] == null ? null : Accessibility.fromJson(json["accessibility"]),
            safety: json["safety"] == null ? null : Safety.fromJson(json["safety"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "comfort": comfort?.toJson(),
        "events": events?.toJson(),
        "accessibility": accessibility?.toJson(),
        "safety": safety?.toJson(),
    };

}

class Accessibility {
    Accessibility({
        required this.wheelchairAccessPrice,
        required this.wheelchairAccess,
        required this.assistedBoarding,
        required this.assistedBoardingPrice,
        required this.childSafeSeating,
    });

    final int? wheelchairAccessPrice;
    final bool? wheelchairAccess;
    final bool? assistedBoarding;
    final int? assistedBoardingPrice;
    final bool? childSafeSeating;

    factory Accessibility.fromJson(Map<String, dynamic> json){ 
        return Accessibility(
            wheelchairAccessPrice: json["wheelchairAccessPrice"],
            wheelchairAccess: json["wheelchairAccess"],
            assistedBoarding: json["assistedBoarding"],
            assistedBoardingPrice: json["assistedBoardingPrice"],
            childSafeSeating: json["childSafeSeating"],
        );
    }

    Map<String, dynamic> toJson() => {
        "wheelchairAccessPrice": wheelchairAccessPrice,
        "wheelchairAccess": wheelchairAccess,
        "assistedBoarding": assistedBoarding,
        "assistedBoardingPrice": assistedBoardingPrice,
        "childSafeSeating": childSafeSeating,
    };

}

class Comfort {
    Comfort({
        required this.cushionedSeating,
        required this.weatherProtection,
        required this.blankets,
        required this.heatedCarriage,
    });

    final bool? cushionedSeating;
    final bool? weatherProtection;
    final bool? blankets;
    final bool? heatedCarriage;

    factory Comfort.fromJson(Map<String, dynamic> json){ 
        return Comfort(
            cushionedSeating: json["cushionedSeating"],
            weatherProtection: json["weatherProtection"],
            blankets: json["blankets"],
            heatedCarriage: json["heatedCarriage"],
        );
    }

    Map<String, dynamic> toJson() => {
        "cushionedSeating": cushionedSeating,
        "weatherProtection": weatherProtection,
        "blankets": blankets,
        "heatedCarriage": heatedCarriage,
    };

}

class Events {
    Events({
        required this.weddingDecor,
        required this.weddingDecorPrice,
        required this.ribbonsAndFlowers,
        required this.ribbonsPrice,
        required this.redCarpetService,
        required this.redCarpetPrice,
        required this.champagneService,
        required this.champagnePrice,
        required this.photographyPackage,
        required this.photographyPrice,
    });

    final bool? weddingDecor;
    final dynamic weddingDecorPrice;
    final bool? ribbonsAndFlowers;
    final int? ribbonsPrice;
    final bool? redCarpetService;
    final int? redCarpetPrice;
    final bool? champagneService;
    final int? champagnePrice;
    final bool? photographyPackage;
    final int? photographyPrice;

    factory Events.fromJson(Map<String, dynamic> json){ 
        return Events(
            weddingDecor: json["weddingDecor"],
            weddingDecorPrice: json["weddingDecorPrice"],
            ribbonsAndFlowers: json["ribbonsAndFlowers"],
            ribbonsPrice: json["ribbonsPrice"],
            redCarpetService: json["redCarpetService"],
            redCarpetPrice: json["redCarpetPrice"],
            champagneService: json["champagneService"],
            champagnePrice: json["champagnePrice"],
            photographyPackage: json["photographyPackage"],
            photographyPrice: json["photographyPrice"],
        );
    }

    Map<String, dynamic> toJson() => {
        "weddingDecor": weddingDecor,
        "weddingDecorPrice": weddingDecorPrice,
        "ribbonsAndFlowers": ribbonsAndFlowers,
        "ribbonsPrice": ribbonsPrice,
        "redCarpetService": redCarpetService,
        "redCarpetPrice": redCarpetPrice,
        "champagneService": champagneService,
        "champagnePrice": champagnePrice,
        "photographyPackage": photographyPackage,
        "photographyPrice": photographyPrice,
    };

}

class Safety {
    Safety({
        required this.publicLiabilityInsurance,
        required this.insuranceProvider,
        required this.routeInspection,
        required this.dbsCheckedDrivers,
    });

    final bool? publicLiabilityInsurance;
    final String? insuranceProvider;
    final bool? routeInspection;
    final bool? dbsCheckedDrivers;

    factory Safety.fromJson(Map<String, dynamic> json){ 
        return Safety(
            publicLiabilityInsurance: json["publicLiabilityInsurance"],
            insuranceProvider: json["insuranceProvider"],
            routeInspection: json["routeInspection"],
            dbsCheckedDrivers: json["dbsCheckedDrivers"],
        );
    }

    Map<String, dynamic> toJson() => {
        "publicLiabilityInsurance": publicLiabilityInsurance,
        "insuranceProvider": insuranceProvider,
        "routeInspection": routeInspection,
        "dbsCheckedDrivers": dbsCheckedDrivers,
    };

}

class Marketing {
    Marketing({
        required this.description,
    });

    final String? description;

    factory Marketing.fromJson(Map<String, dynamic> json){ 
        return Marketing(
            description: json["description"],
        );
    }

    Map<String, dynamic> toJson() => {
        "description": description,
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

class Pricing {
    Pricing({
        required this.hourlyRate,
        required this.halfDayRate,
        required this.fullDayRate,
        required this.fixedPackages,
    });

    final int? hourlyRate;
    final int? halfDayRate;
    final int? fullDayRate;
    final List<PackageDeal> fixedPackages;

    factory Pricing.fromJson(Map<String, dynamic> json){ 
        return Pricing(
            hourlyRate: json["hourlyRate"],
            halfDayRate: json["halfDayRate"],
            fullDayRate: json["fullDayRate"],
            fixedPackages: json["fixedPackages"] == null ? [] : List<PackageDeal>.from(json["fixedPackages"]!.map((x) => PackageDeal.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "hourlyRate": hourlyRate,
        "halfDayRate": halfDayRate,
        "fullDayRate": fullDayRate,
        "fixedPackages": fixedPackages.map((x) => x?.toJson()).toList(),
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
