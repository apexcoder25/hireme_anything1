class BoatHireServiceEditModel {
    BoatHireServiceEditModel({
        required this.boatTypes,
        required this.typicalUseCases,
        required this.fleetInfo,
        required this.cateringEntertainment,
        required this.availability,
        required this.bookingOptions,
        required this.boatRates,
        required this.licensing,
        required this.id,
        required this.categoryId,
        required this.subcategoryId,
        required this.vendorId,
        required this.serviceName,
        required this.fleetSize,
        required this.departurePoints,
        required this.navigableRoutes,
        required this.advanceBooking,
        required this.licenseRequired,
        required this.hireOptions,
        required this.bookingDateFrom,
        required this.bookingDateTo,
        required this.specialPriceDays,
        required this.offeringPrice,
        required this.serviceImage,
        required this.uniqueFeatures,
        required this.promotionalDescription,
        required this.cancellationPolicyType,
        required this.serviceStatus,
        required this.serviceApproveStatus,
        required this.coupons,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final BoatTypes? boatTypes;
    final TypicalUseCases? typicalUseCases;
    final FleetInfo? fleetInfo;
    final CateringEntertainment? cateringEntertainment;
    final Availability? availability;
    final BookingOptions? bookingOptions;
    final BoatRates? boatRates;
    final Licensing? licensing;
    final String? id;
    final String? categoryId;
    final String? subcategoryId;
    final String? vendorId;
    final String? serviceName;
    final int? fleetSize;
    final String? departurePoints;
    final List<String> navigableRoutes;
    final String? advanceBooking;
    final bool? licenseRequired;
    final String? hireOptions;
    final DateTime? bookingDateFrom;
    final DateTime? bookingDateTo;
    final List<dynamic> specialPriceDays;
    final int? offeringPrice;
    final List<String> serviceImage;
    final String? uniqueFeatures;
    final String? promotionalDescription;
    final String? cancellationPolicyType;
    final String? serviceStatus;
    final String? serviceApproveStatus;
    final List<Coupon> coupons;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory BoatHireServiceEditModel.fromJson(Map<String, dynamic> json){ 
        return BoatHireServiceEditModel(
            boatTypes: json["boatTypes"] == null ? null : BoatTypes.fromJson(json["boatTypes"]),
            typicalUseCases: json["typicalUseCases"] == null ? null : TypicalUseCases.fromJson(json["typicalUseCases"]),
            fleetInfo: json["fleetInfo"] == null ? null : FleetInfo.fromJson(json["fleetInfo"]),
            cateringEntertainment: json["cateringEntertainment"] == null ? null : CateringEntertainment.fromJson(json["cateringEntertainment"]),
            availability: json["availability"] == null ? null : Availability.fromJson(json["availability"]),
            bookingOptions: json["bookingOptions"] == null ? null : BookingOptions.fromJson(json["bookingOptions"]),
            boatRates: json["boatRates"] == null ? null : BoatRates.fromJson(json["boatRates"]),
            licensing: json["licensing"] == null ? null : Licensing.fromJson(json["licensing"]),
            id: json["_id"],
            categoryId: json["categoryId"],
            subcategoryId: json["subcategoryId"],
            vendorId: json["vendorId"],
            serviceName: json["service_name"],
            fleetSize: json["fleetSize"],
            departurePoints: json["departurePoints"],
            navigableRoutes: json["navigableRoutes"] == null ? [] : List<String>.from(json["navigableRoutes"]!.map((x) => x)),
            advanceBooking: json["advanceBooking"],
            licenseRequired: json["licenseRequired"],
            hireOptions: json["hireOptions"],
            bookingDateFrom: DateTime.tryParse(json["booking_date_from"] ?? ""),
            bookingDateTo: DateTime.tryParse(json["booking_date_to"] ?? ""),
            specialPriceDays: json["special_price_days"] == null ? [] : List<dynamic>.from(json["special_price_days"]!.map((x) => x)),
            offeringPrice: json["offering_price"],
            serviceImage: json["service_image"] == null ? [] : List<String>.from(json["service_image"]!.map((x) => x)),
            uniqueFeatures: json["uniqueFeatures"],
            promotionalDescription: json["promotionalDescription"],
            cancellationPolicyType: json["cancellation_policy_type"],
            serviceStatus: json["service_status"],
            serviceApproveStatus: json["service_approve_status"],
            coupons: json["coupons"] == null ? [] : List<Coupon>.from(json["coupons"]!.map((x) => Coupon.fromJson(x))),
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
        );
    }

    Map<String, dynamic> toJson() => {
        "boatTypes": boatTypes?.toJson(),
        "typicalUseCases": typicalUseCases?.toJson(),
        "fleetInfo": fleetInfo?.toJson(),
        "cateringEntertainment": cateringEntertainment?.toJson(),
        "availability": availability?.toJson(),
        "bookingOptions": bookingOptions?.toJson(),
        "boatRates": boatRates?.toJson(),
        "licensing": licensing?.toJson(),
        "_id": id,
        "categoryId": categoryId,
        "subcategoryId": subcategoryId,
        "vendorId": vendorId,
        "service_name": serviceName,
        "fleetSize": fleetSize,
        "departurePoints": departurePoints,
        "navigableRoutes": navigableRoutes.map((x) => x).toList(),
        "advanceBooking": advanceBooking,
        "licenseRequired": licenseRequired,
        "hireOptions": hireOptions,
        "booking_date_from": bookingDateFrom?.toIso8601String(),
        "booking_date_to": bookingDateTo?.toIso8601String(),
        "special_price_days": specialPriceDays.map((x) => x).toList(),
        "offering_price": offeringPrice,
        "service_image": serviceImage.map((x) => x).toList(),
        "uniqueFeatures": uniqueFeatures,
        "promotionalDescription": promotionalDescription,
        "cancellation_policy_type": cancellationPolicyType,
        "service_status": serviceStatus,
        "service_approve_status": serviceApproveStatus,
        "coupons": coupons.map((x) => x?.toJson()).toList(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };

}

class Availability {
    Availability({
        required this.yearRound,
        required this.seasonal,
        required this.seasonalMonths,
    });

    final bool? yearRound;
    final bool? seasonal;
    final List<dynamic> seasonalMonths;

    factory Availability.fromJson(Map<String, dynamic> json){ 
        return Availability(
            yearRound: json["yearRound"],
            seasonal: json["seasonal"],
            seasonalMonths: json["seasonalMonths"] == null ? [] : List<dynamic>.from(json["seasonalMonths"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "yearRound": yearRound,
        "seasonal": seasonal,
        "seasonalMonths": seasonalMonths.map((x) => x).toList(),
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

class BoatTypes {
    BoatTypes({
        required this.canalBoat,
        required this.narrowboat,
        required this.dayCruiser,
        required this.luxuryYacht,
        required this.sailboat,
        required this.partyBoat,
        required this.fishingBoat,
        required this.rib,
        required this.houseboat,
        required this.selfDrive,
        required this.skipperedStaffed,
        required this.other,
        required this.otherSpecified,
    });

    final bool? canalBoat;
    final bool? narrowboat;
    final bool? dayCruiser;
    final bool? luxuryYacht;
    final bool? sailboat;
    final bool? partyBoat;
    final bool? fishingBoat;
    final bool? rib;
    final bool? houseboat;
    final bool? selfDrive;
    final bool? skipperedStaffed;
    final bool? other;
    final String? otherSpecified;

    factory BoatTypes.fromJson(Map<String, dynamic> json){ 
        return BoatTypes(
            canalBoat: json["canalBoat"],
            narrowboat: json["narrowboat"],
            dayCruiser: json["dayCruiser"],
            luxuryYacht: json["luxuryYacht"],
            sailboat: json["sailboat"],
            partyBoat: json["partyBoat"],
            fishingBoat: json["fishingBoat"],
            rib: json["rib"],
            houseboat: json["houseboat"],
            selfDrive: json["selfDrive"],
            skipperedStaffed: json["skipperedStaffed"],
            other: json["other"],
            otherSpecified: json["otherSpecified"],
        );
    }

    Map<String, dynamic> toJson() => {
        "canalBoat": canalBoat,
        "narrowboat": narrowboat,
        "dayCruiser": dayCruiser,
        "luxuryYacht": luxuryYacht,
        "sailboat": sailboat,
        "partyBoat": partyBoat,
        "fishingBoat": fishingBoat,
        "rib": rib,
        "houseboat": houseboat,
        "selfDrive": selfDrive,
        "skipperedStaffed": skipperedStaffed,
        "other": other,
        "otherSpecified": otherSpecified,
    };

}

class BookingOptions {
    BookingOptions({
        required this.hourly,
        required this.halfDay,
        required this.fullDay,
        required this.multiDay,
        required this.overnightStay,
    });

    final bool? hourly;
    final bool? halfDay;
    final bool? fullDay;
    final bool? multiDay;
    final bool? overnightStay;

    factory BookingOptions.fromJson(Map<String, dynamic> json){ 
        return BookingOptions(
            hourly: json["hourly"],
            halfDay: json["halfDay"],
            fullDay: json["fullDay"],
            multiDay: json["multiDay"],
            overnightStay: json["overnightStay"],
        );
    }

    Map<String, dynamic> toJson() => {
        "hourly": hourly,
        "halfDay": halfDay,
        "fullDay": fullDay,
        "multiDay": multiDay,
        "overnightStay": overnightStay,
    };

}

class CateringEntertainment {
    CateringEntertainment({
        required this.offered,
        required this.description,
    });

    final bool? offered;
    final String? description;

    factory CateringEntertainment.fromJson(Map<String, dynamic> json){ 
        return CateringEntertainment(
            offered: json["offered"],
            description: json["description"],
        );
    }

    Map<String, dynamic> toJson() => {
        "offered": offered,
        "description": description,
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

class FleetInfo {
    FleetInfo({
        required this.boatName,
        required this.type,
        required this.capacity,
        required this.onboardFeatures,
        required this.year,
        required this.notes,
    });

    final String? boatName;
    final String? type;
    final int? capacity;
    final String? onboardFeatures;
    final int? year;
    final String? notes;

    factory FleetInfo.fromJson(Map<String, dynamic> json){ 
        return FleetInfo(
            boatName: json["boatName"],
            type: json["type"],
            capacity: json["capacity"],
            onboardFeatures: json["onboardFeatures"],
            year: json["year"],
            notes: json["notes"],
        );
    }

    Map<String, dynamic> toJson() => {
        "boatName": boatName,
        "type": type,
        "capacity": capacity,
        "onboardFeatures": onboardFeatures,
        "year": year,
        "notes": notes,
    };

}

class Licensing {
    Licensing({
        required this.documents,
        required this.publicLiabilityInsuranceProvider,
        required this.insuranceProvider,
        required this.vesselInsuranceProvider,
        required this.policyNumber,
        required this.expiryDate,
    });

    final Documents? documents;
    final String? publicLiabilityInsuranceProvider;
    final String? insuranceProvider;
    final String? vesselInsuranceProvider;
    final String? policyNumber;
    final DateTime? expiryDate;

    factory Licensing.fromJson(Map<String, dynamic> json){ 
        return Licensing(
            documents: json["documents"] == null ? null : Documents.fromJson(json["documents"]),
            publicLiabilityInsuranceProvider: json["publicLiabilityInsuranceProvider"],
            insuranceProvider: json["insuranceProvider"],
            vesselInsuranceProvider: json["vesselInsuranceProvider"],
            policyNumber: json["policyNumber"],
            expiryDate: DateTime.tryParse(json["expiryDate"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "documents": documents?.toJson(),
        "publicLiabilityInsuranceProvider": publicLiabilityInsuranceProvider,
        "insuranceProvider": insuranceProvider,
        "vesselInsuranceProvider": vesselInsuranceProvider,
        "policyNumber": policyNumber,
        "expiryDate": expiryDate?.toIso8601String(),
    };

}

class Documents {
    Documents({
        required this.boatMasterLicence,
        required this.skipperCredentials,
        required this.boatSafetyCertificate,
        required this.vesselInsurance,
        required this.publicLiabilityInsurance,
        required this.localAuthorityLicence,
    });

    final BoatMasterLicence? boatMasterLicence;
    final BoatMasterLicence? skipperCredentials;
    final BoatMasterLicence? boatSafetyCertificate;
    final BoatMasterLicence? vesselInsurance;
    final BoatMasterLicence? publicLiabilityInsurance;
    final BoatMasterLicence? localAuthorityLicence;

    factory Documents.fromJson(Map<String, dynamic> json){ 
        return Documents(
            boatMasterLicence: json["boatMasterLicence"] == null ? null : BoatMasterLicence.fromJson(json["boatMasterLicence"]),
            skipperCredentials: json["skipperCredentials"] == null ? null : BoatMasterLicence.fromJson(json["skipperCredentials"]),
            boatSafetyCertificate: json["boatSafetyCertificate"] == null ? null : BoatMasterLicence.fromJson(json["boatSafetyCertificate"]),
            vesselInsurance: json["vesselInsurance"] == null ? null : BoatMasterLicence.fromJson(json["vesselInsurance"]),
            publicLiabilityInsurance: json["publicLiabilityInsurance"] == null ? null : BoatMasterLicence.fromJson(json["publicLiabilityInsurance"]),
            localAuthorityLicence: json["localAuthorityLicence"] == null ? null : BoatMasterLicence.fromJson(json["localAuthorityLicence"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "boatMasterLicence": boatMasterLicence?.toJson(),
        "skipperCredentials": skipperCredentials?.toJson(),
        "boatSafetyCertificate": boatSafetyCertificate?.toJson(),
        "vesselInsurance": vesselInsurance?.toJson(),
        "publicLiabilityInsurance": publicLiabilityInsurance?.toJson(),
        "localAuthorityLicence": localAuthorityLicence?.toJson(),
    };

}

class BoatMasterLicence {
    BoatMasterLicence({
        required this.isAttached,
        required this.image,
    });

    final bool? isAttached;
    final String? image;

    factory BoatMasterLicence.fromJson(Map<String, dynamic> json){ 
        return BoatMasterLicence(
            isAttached: json["isAttached"],
            image: json["image"],
        );
    }

    Map<String, dynamic> toJson() => {
        "isAttached": isAttached,
        "image": image,
    };

}

class TypicalUseCases {
    TypicalUseCases({
        required this.privateHire,
        required this.familyTrips,
        required this.corporateEvents,
        required this.henStagParties,
        required this.birthdayParties,
        required this.sightseeingTours,
        required this.fishingTrips,
        required this.overnightStays,
        required this.weddingsProposals,
        required this.other,
        required this.otherSpecified,
    });

    final bool? privateHire;
    final bool? familyTrips;
    final bool? corporateEvents;
    final bool? henStagParties;
    final bool? birthdayParties;
    final bool? sightseeingTours;
    final bool? fishingTrips;
    final bool? overnightStays;
    final bool? weddingsProposals;
    final bool? other;
    final String? otherSpecified;

    factory TypicalUseCases.fromJson(Map<String, dynamic> json){ 
        return TypicalUseCases(
            privateHire: json["privateHire"],
            familyTrips: json["familyTrips"],
            corporateEvents: json["corporateEvents"],
            henStagParties: json["henStagParties"],
            birthdayParties: json["birthdayParties"],
            sightseeingTours: json["sightseeingTours"],
            fishingTrips: json["fishingTrips"],
            overnightStays: json["overnightStays"],
            weddingsProposals: json["weddingsProposals"],
            other: json["other"],
            otherSpecified: json["otherSpecified"],
        );
    }

    Map<String, dynamic> toJson() => {
        "privateHire": privateHire,
        "familyTrips": familyTrips,
        "corporateEvents": corporateEvents,
        "henStagParties": henStagParties,
        "birthdayParties": birthdayParties,
        "sightseeingTours": sightseeingTours,
        "fishingTrips": fishingTrips,
        "overnightStays": overnightStays,
        "weddingsProposals": weddingsProposals,
        "other": other,
        "otherSpecified": otherSpecified,
    };

}
