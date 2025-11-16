// To parse this JSON data, do
//
//     final allServices = allServicesFromJson(jsonString);

import 'dart:convert';

AllServices allServicesFromJson(String str) => AllServices.fromJson(json.decode(str));

String allServicesToJson(AllServices data) => json.encode(data.toJson());

class AllServices {
    bool success;
    int count;
    int currentPage;
    int totalPages;
    List<Datum> data;
    dynamic userLocation;
    String sortedBy;
    Pagination pagination;
    ResolvedFilters resolvedFilters;
    AppliedFilters appliedFilters;

    AllServices({
        required this.success,
        required this.count,
        required this.currentPage,
        required this.totalPages,
        required this.data,
        required this.userLocation,
        required this.sortedBy,
        required this.pagination,
        required this.resolvedFilters,
        required this.appliedFilters,
    });

    factory AllServices.fromJson(Map<String, dynamic> json) => AllServices(
        success: json["success"],
        count: json["count"],
        currentPage: json["currentPage"],
        totalPages: json["totalPages"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        userLocation: json["userLocation"],
        sortedBy: json["sortedBy"],
        pagination: Pagination.fromJson(json["pagination"]),
        resolvedFilters: ResolvedFilters.fromJson(json["resolvedFilters"]),
        appliedFilters: AppliedFilters.fromJson(json["appliedFilters"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "count": count,
        "currentPage": currentPage,
        "totalPages": totalPages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "userLocation": userLocation,
        "sortedBy": sortedBy,
        "pagination": pagination.toJson(),
        "resolvedFilters": resolvedFilters.toJson(),
        "appliedFilters": appliedFilters.toJson(),
    };
}

class AppliedFilters {
    dynamic maxDistance;
    String sortBy;

    AppliedFilters({
        required this.maxDistance,
        required this.sortBy,
    });

    factory AppliedFilters.fromJson(Map<String, dynamic> json) => AppliedFilters(
        maxDistance: json["maxDistance"],
        sortBy: json["sortBy"],
    );

    Map<String, dynamic> toJson() => {
        "maxDistance": maxDistance,
        "sortBy": sortBy,
    };
}

class Datum {
    String id;
    CategoryId? categoryId;
    SubcategoryId? subcategoryId;
    VendorId? vendorId;
    String? serviceType;
    DateTime? bookingDateFrom;
    DateTime? bookingDateTo;
    List<SpecialPriceDayElement>? datumSpecialPriceDays;
    int? offeringPrice;
    String? listingTitle;
    String? basePostcode;
    int? locationRadius;
    List<String>? areasCovered;
    FleetInfo? fleetInfo;
    MiniBusRates? miniBusRates;
    Features? features;
    DatumDocuments? documents;
    List<String>? serviceImage;
    String? cancellationPolicyType;
    String? serviceStatus;
    dynamic serviceApproveStatus;
    List<Coupon>? coupons;
    DateTime createdAt;
    DateTime? updatedAt;
    int v;
    String sourceModel;
    int averageRating;
    dynamic tierBadge;
    VisibilityScope visibilityScope;
    int rankingPosition;
    String? serviceName;
    String? baseLocationPostcode;
    PricingDetails? pricingDetails;
    List<dynamic>? accessibilityAndSpecialServices;
    FuneralPackageOptions? funeralPackageOptions;
    FuneralVehicleTypes? funeralVehicleTypes;
    dynamic availability;
    DateTime? bookingAvailabilityDateFrom;
    DateTime? bookingAvailabilityDateTo;
    FleetDetails? fleetDetails;
    ServiceDetail? serviceDetail;
    bool? coordinateWithDirectors;
    bool? supportReligious;
    String? funeralServiceType;
    List<dynamic>? additionalSupportServices;
    UploadedDocuments? uploadedDocuments;
    List<String>? serviceImages;
    BusinessProfile? businessProfile;
    String? uniqueFeatures;
    String? promotionalDescription;
    int? standardPackage;
    int? vipExecutivePackage;
    bool? driversUniformed;
    bool? driversDbsChecked;
    dynamic approvalStatus;
    DatumComfort? comfort;
    Events? events;
    dynamic accessibility;
    Security? security;
    List<String>? serviceTypes;
    String? otherServiceType;
    CarriageDetails? carriageDetails;
    Marketing? marketing;
    Pricing? pricing;
    EquipmentSafety? equipmentSafety;
    Licensing? licensing;
    ListingData? listingData;
    int? numberOfLimousines;
    String? fleetType;
    bool? wheelchairAccessibleVehicles;
    List<String>? fleetFeatures;
    String? otherFleetFeature;
    List<String>? occasionsCovered;
    List<String>? bookingOptions;
    bool? is24X7;
    OperatingHours? operatingHours;
    String? operatorLicenceNumber;
    String? licensingAuthority;
    String? insuranceProvider;
    String? policyNumber;
    dynamic policyExpiry;
    MarketingHighlights? marketingHighlights;
    List<String>? availableDays;
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
    List<String>? hireTypes;
    String? otherHireType;
    List<PackageDeal>? packageDeals;
    String? venueName;
    List<String>? venueType;
    String? description;
    String? address;
    String? city;
    Country? country;
    Facilities? facilities;
    EventRules? eventRules;
    int? rating;
    DateTime? datumCreatedAt;
    int? totalArea;
    AreaUnit? areaUnit;
    int? numberOfRooms;
    List<String>? amenities;
    String? contactEmail;
    String? contactPhone;
    List<DateTime>? unavailableDates;
    List<Addon>? addons;
    DefaultAvailability? defaultAvailability;
    bool? depositRequired;
    List<String>? houseRules;
    int? maximumCapacity;
    int? minimumBookingHours;
    int? minimumCapacity;
    DatumParking? parking;
    String? pricingModel;
    List<Addon>? pricingTiers;
    String? responseTime;
    int? taxRate;
    bool? termsAccepted;
    String? website;
    String? currency;
    FleetInformation? fleetInformation;
    DriverCompliance? driverCompliance;
    Services? services;
    Environmental? environmental;
    ListingPreferences? listingPreferences;
    LegalDeclaration? legalDeclaration;
    String? status;
    Metrics? metrics;
    bool? isActive;
    int? listingViews;
    bool? isDraft;
    DateTime? submittedAt;
    int? complianceScore;
    String? companyName;
    Contact? contactDetails;
    Coverage? coverage;
    List<SpecialPriceDay>? specialPriceDays;
    String? primaryImage;
    String? listingReference;
    String? slug;
    bool? featured;
    MembershipTier? membershipTier;
    BusinessInfo? businessInfo;
    EquipmentSelection? equipmentSelection;
    DimensionsSpecifications? dimensionsSpecifications;
    SetupRequirements? setupRequirements;
    SafetyCertification? safetyCertification;
    PhotosMedia? photosMedia;
    AvailabilityBooking? availabilityBooking;
    LocationCoverage? locationCoverage;
    Policies? policies;
    Stats? stats;

    Datum({
        required this.id,
        this.categoryId,
        this.subcategoryId,
        required this.vendorId,
        this.serviceType,
        this.bookingDateFrom,
        this.bookingDateTo,
        this.datumSpecialPriceDays,
        this.offeringPrice,
        this.listingTitle,
        this.basePostcode,
        this.locationRadius,
        this.areasCovered,
        this.fleetInfo,
        this.miniBusRates,
        this.features,
        this.documents,
        this.serviceImage,
        this.cancellationPolicyType,
        this.serviceStatus,
        required this.serviceApproveStatus,
        this.coupons,
        required this.createdAt,
        this.updatedAt,
        required this.v,
        required this.sourceModel,
        required this.averageRating,
        required this.tierBadge,
        required this.visibilityScope,
        required this.rankingPosition,
        this.serviceName,
        this.baseLocationPostcode,
        this.pricingDetails,
        this.accessibilityAndSpecialServices,
        this.funeralPackageOptions,
        this.funeralVehicleTypes,
        this.availability,
        this.bookingAvailabilityDateFrom,
        this.bookingAvailabilityDateTo,
        this.fleetDetails,
        this.serviceDetail,
        this.coordinateWithDirectors,
        this.supportReligious,
        this.funeralServiceType,
        this.additionalSupportServices,
        this.uploadedDocuments,
        this.serviceImages,
        this.businessProfile,
        this.uniqueFeatures,
        this.promotionalDescription,
        this.standardPackage,
        this.vipExecutivePackage,
        this.driversUniformed,
        this.driversDbsChecked,
        this.approvalStatus,
        this.comfort,
        this.events,
        this.accessibility,
        this.security,
        this.serviceTypes,
        this.otherServiceType,
        this.carriageDetails,
        this.marketing,
        this.pricing,
        this.equipmentSafety,
        this.licensing,
        this.listingData,
        this.numberOfLimousines,
        this.fleetType,
        this.wheelchairAccessibleVehicles,
        this.fleetFeatures,
        this.otherFleetFeature,
        this.occasionsCovered,
        this.bookingOptions,
        this.is24X7,
        this.operatingHours,
        this.operatorLicenceNumber,
        this.licensingAuthority,
        this.insuranceProvider,
        this.policyNumber,
        this.policyExpiry,
        this.marketingHighlights,
        this.availableDays,
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
        this.hireTypes,
        this.otherHireType,
        this.packageDeals,
        this.venueName,
        this.venueType,
        this.description,
        this.address,
        this.city,
        this.country,
        this.facilities,
        this.eventRules,
        this.rating,
        this.datumCreatedAt,
        this.totalArea,
        this.areaUnit,
        this.numberOfRooms,
        this.amenities,
        this.contactEmail,
        this.contactPhone,
        this.unavailableDates,
        this.addons,
        this.defaultAvailability,
        this.depositRequired,
        this.houseRules,
        this.maximumCapacity,
        this.minimumBookingHours,
        this.minimumCapacity,
        this.parking,
        this.pricingModel,
        this.pricingTiers,
        this.responseTime,
        this.taxRate,
        this.termsAccepted,
        this.website,
        this.currency,
        this.fleetInformation,
        this.driverCompliance,
        this.services,
        this.environmental,
        this.listingPreferences,
        this.legalDeclaration,
        this.status,
        this.metrics,
        this.isActive,
        this.listingViews,
        this.isDraft,
        this.submittedAt,
        this.complianceScore,
        this.companyName,
        this.contactDetails,
        this.coverage,
        this.specialPriceDays,
        this.primaryImage,
        this.listingReference,
        this.slug,
        this.featured,
        this.membershipTier,
        this.businessInfo,
        this.equipmentSelection,
        this.dimensionsSpecifications,
        this.setupRequirements,
        this.safetyCertification,
        this.photosMedia,
        this.availabilityBooking,
        this.locationCoverage,
        this.policies,
        this.stats,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        categoryId: json["categoryId"] == null ? null : CategoryId.fromJson(json["categoryId"]),
        subcategoryId: json["subcategoryId"] == null ? null : SubcategoryId.fromJson(json["subcategoryId"]),
        vendorId: json["vendorId"] == null ? null : VendorId.fromJson(json["vendorId"]),
        serviceType: json["service_type"],
        bookingDateFrom: json["booking_date_from"] == null ? null : DateTime.parse(json["booking_date_from"]),
        bookingDateTo: json["booking_date_to"] == null ? null : DateTime.parse(json["booking_date_to"]),
        datumSpecialPriceDays: json["special_price_days"] == null ? [] : List<SpecialPriceDayElement>.from(json["special_price_days"]!.map((x) => SpecialPriceDayElement.fromJson(x))),
        offeringPrice: json["offering_price"],
        listingTitle: json["listingTitle"],
        basePostcode: json["basePostcode"],
        locationRadius: json["locationRadius"],
        areasCovered: json["areasCovered"] == null ? [] : List<String>.from(json["areasCovered"]!.map((x) => x)),
        fleetInfo: json["fleetInfo"] == null ? null : FleetInfo.fromJson(json["fleetInfo"]),
        miniBusRates: json["miniBusRates"] == null ? null : MiniBusRates.fromJson(json["miniBusRates"]),
        features: json["features"] == null ? null : Features.fromJson(json["features"]),
        documents: json["documents"] == null ? null : DatumDocuments.fromJson(json["documents"]),
        serviceImage: json["service_image"] == null ? [] : List<String>.from(json["service_image"]!.map((x) => x)),
        cancellationPolicyType: json["cancellation_policy_type"],
        serviceStatus: json["service_status"],
        serviceApproveStatus: json["service_approve_status"],
        coupons: json["coupons"] == null ? [] : List<Coupon>.from(json["coupons"]!.map((x) => Coupon.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        sourceModel: json["_sourceModel"],
        averageRating: json["averageRating"],
        tierBadge: json["tier_badge"],
        visibilityScope: visibilityScopeValues.map[json["visibility_scope"]]!,
        rankingPosition: json["ranking_position"],
        serviceName: json["service_name"],
        baseLocationPostcode: json["baseLocationPostcode"],
        pricingDetails: json["pricingDetails"] == null ? null : PricingDetails.fromJson(json["pricingDetails"]),
        accessibilityAndSpecialServices: json["accessibilityAndSpecialServices"] == null ? [] : List<dynamic>.from(json["accessibilityAndSpecialServices"]!.map((x) => x)),
        funeralPackageOptions: json["funeralPackageOptions"] == null ? null : FuneralPackageOptions.fromJson(json["funeralPackageOptions"]),
        funeralVehicleTypes: json["funeralVehicleTypes"] == null ? null : FuneralVehicleTypes.fromJson(json["funeralVehicleTypes"]),
        availability: json["availability"],
        bookingAvailabilityDateFrom: json["booking_availability_date_from"] == null ? null : DateTime.parse(json["booking_availability_date_from"]),
        bookingAvailabilityDateTo: json["booking_availability_date_to"] == null ? null : DateTime.parse(json["booking_availability_date_to"]),
        fleetDetails: json["fleetDetails"] == null ? null : FleetDetails.fromJson(json["fleetDetails"]),
        serviceDetail: json["service_detail"] == null ? null : ServiceDetail.fromJson(json["service_detail"]),
        coordinateWithDirectors: json["coordinateWithDirectors"],
        supportReligious: json["supportReligious"],
        funeralServiceType: json["funeralServiceType"],
        additionalSupportServices: json["additionalSupportServices"] == null ? [] : List<dynamic>.from(json["additionalSupportServices"]!.map((x) => x)),
        uploadedDocuments: json["uploaded_Documents"] == null ? null : UploadedDocuments.fromJson(json["uploaded_Documents"]),
        serviceImages: json["serviceImages"] == null ? [] : List<String>.from(json["serviceImages"]!.map((x) => x)),
        businessProfile: json["businessProfile"] == null ? null : BusinessProfile.fromJson(json["businessProfile"]),
        uniqueFeatures: json["uniqueFeatures"],
        promotionalDescription: json["promotionalDescription"],
        standardPackage: json["standardPackage"],
        vipExecutivePackage: json["vipExecutivePackage"],
        driversUniformed: json["driversUniformed"],
        driversDbsChecked: json["driversDBSChecked"],
        approvalStatus: json["approvalStatus"],
        comfort: json["comfort"] == null ? null : DatumComfort.fromJson(json["comfort"]),
        events: json["events"] == null ? null : Events.fromJson(json["events"]),
        accessibility: json["accessibility"],
        security: json["security"] == null ? null : Security.fromJson(json["security"]),
        serviceTypes: json["serviceTypes"] == null ? [] : List<String>.from(json["serviceTypes"]!.map((x) => x)),
        otherServiceType: json["otherServiceType"],
        carriageDetails: json["carriageDetails"] == null ? null : CarriageDetails.fromJson(json["carriageDetails"]),
        marketing: json["marketing"] == null ? null : Marketing.fromJson(json["marketing"]),
        pricing: json["pricing"] == null ? null : Pricing.fromJson(json["pricing"]),
        equipmentSafety: json["equipmentSafety"] == null ? null : EquipmentSafety.fromJson(json["equipmentSafety"]),
        licensing: json["licensing"] == null ? null : Licensing.fromJson(json["licensing"]),
        listingData: json["listing_data"] == null ? null : ListingData.fromJson(json["listing_data"]),
        numberOfLimousines: json["numberOfLimousines"],
        fleetType: json["fleetType"],
        wheelchairAccessibleVehicles: json["wheelchairAccessibleVehicles"],
        fleetFeatures: json["fleetFeatures"] == null ? [] : List<String>.from(json["fleetFeatures"]!.map((x) => x)),
        otherFleetFeature: json["otherFleetFeature"],
        occasionsCovered: json["occasionsCovered"] == null ? [] : List<String>.from(json["occasionsCovered"]!.map((x) => x)),
        bookingOptions: json["bookingOptions"] == null ? [] : List<String>.from(json["bookingOptions"]!.map((x) => x)),
        is24X7: json["is24x7"],
        operatingHours: json["operatingHours"] == null ? null : OperatingHours.fromJson(json["operatingHours"]),
        operatorLicenceNumber: json["operatorLicenceNumber"],
        licensingAuthority: json["licensingAuthority"],
        insuranceProvider: json["insuranceProvider"],
        policyNumber: json["policyNumber"],
        policyExpiry: json["policyExpiry"],
        marketingHighlights: json["marketingHighlights"] == null ? null : MarketingHighlights.fromJson(json["marketingHighlights"]),
        availableDays: json["availableDays"] == null ? [] : List<String>.from(json["availableDays"]!.map((x) => x)),
        photos: json["photos"] == null ? null : Photos.fromJson(json["photos"]),
        boatType: json["boatType"],
        makeAndModel: json["makeAndModel"],
        firstRegistered: json["firstRegistered"] == null ? null : DateTime.parse(json["firstRegistered"]),
        luggageCapacity: json["luggageCapacity"] == null ? null : LuggageCapacity.fromJson(json["luggageCapacity"]),
        seats: json["seats"],
        hireType: json["hireType"],
        departurePoint: json["departurePoint"],
        postcode: json["postcode"],
        serviceCoverage: json["serviceCoverage"] == null ? [] : List<String>.from(json["serviceCoverage"]!.map((x) => x)),
        mileageRadius: json["mileageRadius"],
        boatRates: json["boatRates"] == null ? null : BoatRates.fromJson(json["boatRates"]),
        hireTypes: json["hireTypes"] == null ? [] : List<String>.from(json["hireTypes"]!.map((x) => x)),
        otherHireType: json["otherHireType"],
        packageDeals: json["packageDeals"] == null ? [] : List<PackageDeal>.from(json["packageDeals"]!.map((x) => PackageDeal.fromJson(x))),
        venueName: json["venueName"],
        venueType: json["venueType"] == null ? [] : List<String>.from(json["venueType"]!.map((x) => x)),
        description: json["description"],
        address: json["address"],
        city: json["city"],
        country: countryValues.map[json["country"]]!,
        facilities: json["facilities"] == null ? null : Facilities.fromJson(json["facilities"]),
        eventRules: json["eventRules"] == null ? null : EventRules.fromJson(json["eventRules"]),
        rating: json["rating"],
        datumCreatedAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        totalArea: json["totalArea"],
        areaUnit: areaUnitValues.map[json["areaUnit"]]!,
        numberOfRooms: json["numberOfRooms"],
        amenities: json["amenities"] == null ? [] : List<String>.from(json["amenities"]!.map((x) => x)),
        contactEmail: json["contactEmail"],
        contactPhone: json["contactPhone"],
        unavailableDates: json["unavailableDates"] == null ? [] : List<DateTime>.from(json["unavailableDates"]!.map((x) => DateTime.parse(x))),
        addons: json["addons"] == null ? [] : List<Addon>.from(json["addons"]!.map((x) => Addon.fromJson(x))),
        defaultAvailability: json["defaultAvailability"] == null ? null : DefaultAvailability.fromJson(json["defaultAvailability"]),
        depositRequired: json["depositRequired"],
        houseRules: json["houseRules"] == null ? [] : List<String>.from(json["houseRules"]!.map((x) => x)),
        maximumCapacity: json["maximumCapacity"],
        minimumBookingHours: json["minimumBookingHours"],
        minimumCapacity: json["minimumCapacity"],
        parking: json["parking"] == null ? null : DatumParking.fromJson(json["parking"]),
        pricingModel: json["pricingModel"],
        pricingTiers: json["pricingTiers"] == null ? [] : List<Addon>.from(json["pricingTiers"]!.map((x) => Addon.fromJson(x))),
        responseTime: json["responseTime"],
        taxRate: json["taxRate"],
        termsAccepted: json["termsAccepted"],
        website: json["website"],
        currency: json["currency"],
        fleetInformation: json["fleetInformation"] == null ? null : FleetInformation.fromJson(json["fleetInformation"]),
        driverCompliance: json["driverCompliance"] == null ? null : DriverCompliance.fromJson(json["driverCompliance"]),
        services: json["services"] == null ? null : Services.fromJson(json["services"]),
        environmental: json["environmental"] == null ? null : Environmental.fromJson(json["environmental"]),
        listingPreferences: json["listingPreferences"] == null ? null : ListingPreferences.fromJson(json["listingPreferences"]),
        legalDeclaration: json["legalDeclaration"] == null ? null : LegalDeclaration.fromJson(json["legalDeclaration"]),
        status: json["status"],
        metrics: json["metrics"] == null ? null : Metrics.fromJson(json["metrics"]),
        isActive: json["isActive"],
        listingViews: json["listingViews"],
        isDraft: json["isDraft"],
        submittedAt: json["submittedAt"] == null ? null : DateTime.parse(json["submittedAt"]),
        complianceScore: json["complianceScore"],
        companyName: json["companyName"],
        contactDetails: json["contactDetails"] == null ? null : Contact.fromJson(json["contactDetails"]),
        coverage: json["coverage"] == null ? null : Coverage.fromJson(json["coverage"]),
        specialPriceDays: json["specialPriceDays"] == null ? [] : List<SpecialPriceDay>.from(json["specialPriceDays"]!.map((x) => SpecialPriceDay.fromJson(x))),
        primaryImage: json["primary_image"],
        listingReference: json["listingReference"],
        slug: json["slug"],
        featured: json["featured"],
        membershipTier: membershipTierValues.map[json["membershipTier"]]!,
        businessInfo: json["businessInfo"] == null ? null : BusinessInfo.fromJson(json["businessInfo"]),
        equipmentSelection: json["equipmentSelection"] == null ? null : EquipmentSelection.fromJson(json["equipmentSelection"]),
        dimensionsSpecifications: json["dimensionsSpecifications"] == null ? null : DimensionsSpecifications.fromJson(json["dimensionsSpecifications"]),
        setupRequirements: json["setupRequirements"] == null ? null : SetupRequirements.fromJson(json["setupRequirements"]),
        safetyCertification: json["safetyCertification"] == null ? null : SafetyCertification.fromJson(json["safetyCertification"]),
        photosMedia: json["photosMedia"] == null ? null : PhotosMedia.fromJson(json["photosMedia"]),
        availabilityBooking: json["availabilityBooking"] == null ? null : AvailabilityBooking.fromJson(json["availabilityBooking"]),
        locationCoverage: json["locationCoverage"] == null ? null : LocationCoverage.fromJson(json["locationCoverage"]),
        policies: json["policies"] == null ? null : Policies.fromJson(json["policies"]),
        stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "categoryId": categoryId?.toJson(),
        "subcategoryId": subcategoryId?.toJson(),
        "vendorId": vendorId?.toJson(),
        "service_type": serviceType,
        "booking_date_from": bookingDateFrom?.toIso8601String(),
        "booking_date_to": bookingDateTo?.toIso8601String(),
        "special_price_days": datumSpecialPriceDays == null ? [] : List<dynamic>.from(datumSpecialPriceDays!.map((x) => x.toJson())),
        "offering_price": offeringPrice,
        "listingTitle": listingTitle,
        "basePostcode": basePostcode,
        "locationRadius": locationRadius,
        "areasCovered": areasCovered == null ? [] : List<dynamic>.from(areasCovered!.map((x) => x)),
        "fleetInfo": fleetInfo?.toJson(),
        "miniBusRates": miniBusRates?.toJson(),
        "features": features?.toJson(),
        "documents": documents?.toJson(),
        "service_image": serviceImage == null ? [] : List<dynamic>.from(serviceImage!.map((x) => x)),
        "cancellation_policy_type": cancellationPolicyType,
        "service_status": serviceStatus,
        "service_approve_status": serviceApproveStatus,
        "coupons": coupons == null ? [] : List<dynamic>.from(coupons!.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "_sourceModel": sourceModel,
        "averageRating": averageRating,
        "tier_badge": tierBadge,
        "visibility_scope": visibilityScopeValues.reverse[visibilityScope],
        "ranking_position": rankingPosition,
        "service_name": serviceName,
        "baseLocationPostcode": baseLocationPostcode,
        "pricingDetails": pricingDetails?.toJson(),
        "accessibilityAndSpecialServices": accessibilityAndSpecialServices == null ? [] : List<dynamic>.from(accessibilityAndSpecialServices!.map((x) => x)),
        "funeralPackageOptions": funeralPackageOptions?.toJson(),
        "funeralVehicleTypes": funeralVehicleTypes?.toJson(),
        "availability": availability,
        "booking_availability_date_from": bookingAvailabilityDateFrom?.toIso8601String(),
        "booking_availability_date_to": bookingAvailabilityDateTo?.toIso8601String(),
        "fleetDetails": fleetDetails?.toJson(),
        "service_detail": serviceDetail?.toJson(),
        "coordinateWithDirectors": coordinateWithDirectors,
        "supportReligious": supportReligious,
        "funeralServiceType": funeralServiceType,
        "additionalSupportServices": additionalSupportServices == null ? [] : List<dynamic>.from(additionalSupportServices!.map((x) => x)),
        "uploaded_Documents": uploadedDocuments?.toJson(),
        "serviceImages": serviceImages == null ? [] : List<dynamic>.from(serviceImages!.map((x) => x)),
        "businessProfile": businessProfile?.toJson(),
        "uniqueFeatures": uniqueFeatures,
        "promotionalDescription": promotionalDescription,
        "standardPackage": standardPackage,
        "vipExecutivePackage": vipExecutivePackage,
        "driversUniformed": driversUniformed,
        "driversDBSChecked": driversDbsChecked,
        "approvalStatus": approvalStatus,
        "comfort": comfort?.toJson(),
        "events": events?.toJson(),
        "accessibility": accessibility,
        "security": security?.toJson(),
        "serviceTypes": serviceTypes == null ? [] : List<dynamic>.from(serviceTypes!.map((x) => x)),
        "otherServiceType": otherServiceType,
        "carriageDetails": carriageDetails?.toJson(),
        "marketing": marketing?.toJson(),
        "pricing": pricing?.toJson(),
        "equipmentSafety": equipmentSafety?.toJson(),
        "licensing": licensing?.toJson(),
        "listing_data": listingData?.toJson(),
        "numberOfLimousines": numberOfLimousines,
        "fleetType": fleetType,
        "wheelchairAccessibleVehicles": wheelchairAccessibleVehicles,
        "fleetFeatures": fleetFeatures == null ? [] : List<dynamic>.from(fleetFeatures!.map((x) => x)),
        "otherFleetFeature": otherFleetFeature,
        "occasionsCovered": occasionsCovered == null ? [] : List<dynamic>.from(occasionsCovered!.map((x) => x)),
        "bookingOptions": bookingOptions == null ? [] : List<dynamic>.from(bookingOptions!.map((x) => x)),
        "is24x7": is24X7,
        "operatingHours": operatingHours?.toJson(),
        "operatorLicenceNumber": operatorLicenceNumber,
        "licensingAuthority": licensingAuthority,
        "insuranceProvider": insuranceProvider,
        "policyNumber": policyNumber,
        "policyExpiry": policyExpiry,
        "marketingHighlights": marketingHighlights?.toJson(),
        "availableDays": availableDays == null ? [] : List<dynamic>.from(availableDays!.map((x) => x)),
        "photos": photos?.toJson(),
        "boatType": boatType,
        "makeAndModel": makeAndModel,
        "firstRegistered": firstRegistered?.toIso8601String(),
        "luggageCapacity": luggageCapacity?.toJson(),
        "seats": seats,
        "hireType": hireType,
        "departurePoint": departurePoint,
        "postcode": postcode,
        "serviceCoverage": serviceCoverage == null ? [] : List<dynamic>.from(serviceCoverage!.map((x) => x)),
        "mileageRadius": mileageRadius,
        "boatRates": boatRates?.toJson(),
        "hireTypes": hireTypes == null ? [] : List<dynamic>.from(hireTypes!.map((x) => x)),
        "otherHireType": otherHireType,
        "packageDeals": packageDeals == null ? [] : List<dynamic>.from(packageDeals!.map((x) => x.toJson())),
        "venueName": venueName,
        "venueType": venueType == null ? [] : List<dynamic>.from(venueType!.map((x) => x)),
        "description": description,
        "address": address,
        "city": city,
        "country": countryValues.reverse[country],
        "facilities": facilities?.toJson(),
        "eventRules": eventRules?.toJson(),
        "rating": rating,
        "created_at": datumCreatedAt?.toIso8601String(),
        "totalArea": totalArea,
        "areaUnit": areaUnitValues.reverse[areaUnit],
        "numberOfRooms": numberOfRooms,
        "amenities": amenities == null ? [] : List<dynamic>.from(amenities!.map((x) => x)),
        "contactEmail": contactEmail,
        "contactPhone": contactPhone,
        "unavailableDates": unavailableDates == null ? [] : List<dynamic>.from(unavailableDates!.map((x) => x.toIso8601String())),
        "addons": addons == null ? [] : List<dynamic>.from(addons!.map((x) => x.toJson())),
        "defaultAvailability": defaultAvailability?.toJson(),
        "depositRequired": depositRequired,
        "houseRules": houseRules == null ? [] : List<dynamic>.from(houseRules!.map((x) => x)),
        "maximumCapacity": maximumCapacity,
        "minimumBookingHours": minimumBookingHours,
        "minimumCapacity": minimumCapacity,
        "parking": parking?.toJson(),
        "pricingModel": pricingModel,
        "pricingTiers": pricingTiers == null ? [] : List<dynamic>.from(pricingTiers!.map((x) => x.toJson())),
        "responseTime": responseTime,
        "taxRate": taxRate,
        "termsAccepted": termsAccepted,
        "website": website,
        "currency": currency,
        "fleetInformation": fleetInformation?.toJson(),
        "driverCompliance": driverCompliance?.toJson(),
        "services": services?.toJson(),
        "environmental": environmental?.toJson(),
        "listingPreferences": listingPreferences?.toJson(),
        "legalDeclaration": legalDeclaration?.toJson(),
        "status": status,
        "metrics": metrics?.toJson(),
        "isActive": isActive,
        "listingViews": listingViews,
        "isDraft": isDraft,
        "submittedAt": submittedAt?.toIso8601String(),
        "complianceScore": complianceScore,
        "companyName": companyName,
        "contactDetails": contactDetails?.toJson(),
        "coverage": coverage?.toJson(),
        "specialPriceDays": specialPriceDays == null ? [] : List<dynamic>.from(specialPriceDays!.map((x) => x.toJson())),
        "primary_image": primaryImage,
        "listingReference": listingReference,
        "slug": slug,
        "featured": featured,
        "membershipTier": membershipTierValues.reverse[membershipTier],
        "businessInfo": businessInfo?.toJson(),
        "equipmentSelection": equipmentSelection?.toJson(),
        "dimensionsSpecifications": dimensionsSpecifications?.toJson(),
        "setupRequirements": setupRequirements?.toJson(),
        "safetyCertification": safetyCertification?.toJson(),
        "photosMedia": photosMedia?.toJson(),
        "availabilityBooking": availabilityBooking?.toJson(),
        "locationCoverage": locationCoverage?.toJson(),
        "policies": policies?.toJson(),
        "stats": stats?.toJson(),
    };
}

class AccessibilityClass {
    bool wheelchairAccessVehicle;
    int wheelchairAccessPrice;
    bool childCarSeats;
    int childCarSeatsPrice;
    bool petFriendlyService;
    int petFriendlyPrice;
    bool disabledAccessRamp;
    int disabledAccessRampPrice;
    bool seniorFriendlyAssistance;
    int seniorAssistancePrice;
    bool? strollerBuggyStorage;
    int? strollerStoragePrice;

    AccessibilityClass({
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
        this.strollerBuggyStorage,
        this.strollerStoragePrice,
    });

    factory AccessibilityClass.fromJson(Map<String, dynamic> json) => AccessibilityClass(
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

class Addon {
    String name;
    int price;
    String description;
    bool? isRequired;

    Addon({
        required this.name,
        required this.price,
        required this.description,
        this.isRequired,
    });

    factory Addon.fromJson(Map<String, dynamic> json) => Addon(
        name: json["name"],
        price: json["price"],
        description: json["description"],
        isRequired: json["isRequired"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "description": description,
        "isRequired": isRequired,
    };
}

class ApprovalStatusClass {
    DateTime approvedAt;

    ApprovalStatusClass({
        required this.approvedAt,
    });

    factory ApprovalStatusClass.fromJson(Map<String, dynamic> json) => ApprovalStatusClass(
        approvedAt: DateTime.parse(json["approvedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "approvedAt": approvedAt.toIso8601String(),
    };
}

enum AreaUnit {
    SQFT,
    SQM
}

final areaUnitValues = EnumValues({
    "sqft": AreaUnit.SQFT,
    "sqm": AreaUnit.SQM
});

class AvailabilityClass {
    DateTime bookingDateFrom;
    DateTime bookingDateTo;
    Options options;

    AvailabilityClass({
        required this.bookingDateFrom,
        required this.bookingDateTo,
        required this.options,
    });

    factory AvailabilityClass.fromJson(Map<String, dynamic> json) => AvailabilityClass(
        bookingDateFrom: DateTime.parse(json["bookingDateFrom"]),
        bookingDateTo: DateTime.parse(json["bookingDateTo"]),
        options: Options.fromJson(json["options"]),
    );

    Map<String, dynamic> toJson() => {
        "bookingDateFrom": bookingDateFrom.toIso8601String(),
        "bookingDateTo": bookingDateTo.toIso8601String(),
        "options": options.toJson(),
    };
}

class Options {
    bool twentyFourSeven;
    bool weekdays;
    bool weekends;

    Options({
        required this.twentyFourSeven,
        required this.weekdays,
        required this.weekends,
    });

    factory Options.fromJson(Map<String, dynamic> json) => Options(
        twentyFourSeven: json["twentyFourSeven"],
        weekdays: json["weekdays"],
        weekends: json["weekends"],
    );

    Map<String, dynamic> toJson() => {
        "twentyFourSeven": twentyFourSeven,
        "weekdays": weekdays,
        "weekends": weekends,
    };
}

class AvailabilityBooking {
    AvailabilityCalendar availabilityCalendar;
    AdvanceBookingMinimum minimumBookingDuration;
    AdvanceBookingMinimum maximumBookingDuration;
    AdvanceBookingMinimum advanceBookingMinimum;
    bool instantBooking;
    AdvanceBookingMinimum bufferTimeBetweenBookings;

    AvailabilityBooking({
        required this.availabilityCalendar,
        required this.minimumBookingDuration,
        required this.maximumBookingDuration,
        required this.advanceBookingMinimum,
        required this.instantBooking,
        required this.bufferTimeBetweenBookings,
    });

    factory AvailabilityBooking.fromJson(Map<String, dynamic> json) => AvailabilityBooking(
        availabilityCalendar: AvailabilityCalendar.fromJson(json["availabilityCalendar"]),
        minimumBookingDuration: AdvanceBookingMinimum.fromJson(json["minimumBookingDuration"]),
        maximumBookingDuration: AdvanceBookingMinimum.fromJson(json["maximumBookingDuration"]),
        advanceBookingMinimum: AdvanceBookingMinimum.fromJson(json["advanceBookingMinimum"]),
        instantBooking: json["instantBooking"],
        bufferTimeBetweenBookings: AdvanceBookingMinimum.fromJson(json["bufferTimeBetweenBookings"]),
    );

    Map<String, dynamic> toJson() => {
        "availabilityCalendar": availabilityCalendar.toJson(),
        "minimumBookingDuration": minimumBookingDuration.toJson(),
        "maximumBookingDuration": maximumBookingDuration.toJson(),
        "advanceBookingMinimum": advanceBookingMinimum.toJson(),
        "instantBooking": instantBooking,
        "bufferTimeBetweenBookings": bufferTimeBetweenBookings.toJson(),
    };
}

class AdvanceBookingMinimum {
    int value;
    RadiusUnitEnum unit;

    AdvanceBookingMinimum({
        required this.value,
        required this.unit,
    });

    factory AdvanceBookingMinimum.fromJson(Map<String, dynamic> json) => AdvanceBookingMinimum(
        value: json["value"],
        unit: radiusUnitEnumValues.map[json["unit"]]!,
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "unit": radiusUnitEnumValues.reverse[unit],
    };
}

enum RadiusUnitEnum {
    HOURS,
    MILES
}

final radiusUnitEnumValues = EnumValues({
    "HOURS": RadiusUnitEnum.HOURS,
    "MILES": RadiusUnitEnum.MILES
});

class AvailabilityCalendar {
    List<dynamic> blockedDates;
    List<RecurringAvailability> recurringAvailability;

    AvailabilityCalendar({
        required this.blockedDates,
        required this.recurringAvailability,
    });

    factory AvailabilityCalendar.fromJson(Map<String, dynamic> json) => AvailabilityCalendar(
        blockedDates: List<dynamic>.from(json["blockedDates"].map((x) => x)),
        recurringAvailability: List<RecurringAvailability>.from(json["recurringAvailability"].map((x) => RecurringAvailability.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "blockedDates": List<dynamic>.from(blockedDates.map((x) => x)),
        "recurringAvailability": List<dynamic>.from(recurringAvailability.map((x) => x.toJson())),
    };
}

class RecurringAvailability {
    int dayOfWeek;
    bool available;
    String id;

    RecurringAvailability({
        required this.dayOfWeek,
        required this.available,
        required this.id,
    });

    factory RecurringAvailability.fromJson(Map<String, dynamic> json) => RecurringAvailability(
        dayOfWeek: json["dayOfWeek"],
        available: json["available"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "dayOfWeek": dayOfWeek,
        "available": available,
        "_id": id,
    };
}

class BoatRates {
    int fullDayRate;
    int halfDayRate;
    int threeHourRate;

    BoatRates({
        required this.fullDayRate,
        required this.halfDayRate,
        required this.threeHourRate,
    });

    factory BoatRates.fromJson(Map<String, dynamic> json) => BoatRates(
        fullDayRate: json["fullDayRate"],
        halfDayRate: json["halfDayRate"],
        threeHourRate: json["threeHourRate"],
    );

    Map<String, dynamic> toJson() => {
        "fullDayRate": fullDayRate,
        "halfDayRate": halfDayRate,
        "threeHourRate": threeHourRate,
    };
}

class BusinessInfo {
    String businessName;
    String baseLocationPostcode;
    int serviceRadius;
    int yearsInOperation;
    Contact contactPerson;
    BusinessInfoCoordinates coordinates;

    BusinessInfo({
        required this.businessName,
        required this.baseLocationPostcode,
        required this.serviceRadius,
        required this.yearsInOperation,
        required this.contactPerson,
        required this.coordinates,
    });

    factory BusinessInfo.fromJson(Map<String, dynamic> json) => BusinessInfo(
        businessName: json["businessName"],
        baseLocationPostcode: json["baseLocationPostcode"],
        serviceRadius: json["serviceRadius"],
        yearsInOperation: json["yearsInOperation"],
        contactPerson: Contact.fromJson(json["contactPerson"]),
        coordinates: BusinessInfoCoordinates.fromJson(json["coordinates"]),
    );

    Map<String, dynamic> toJson() => {
        "businessName": businessName,
        "baseLocationPostcode": baseLocationPostcode,
        "serviceRadius": serviceRadius,
        "yearsInOperation": yearsInOperation,
        "contactPerson": contactPerson.toJson(),
        "coordinates": coordinates.toJson(),
    };
}

class Contact {
    String name;
    String email;
    String phone;
    String? address;

    Contact({
        required this.name,
        required this.email,
        required this.phone,
        this.address,
    });

    factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
    };
}

class BusinessInfoCoordinates {
    String type;
    List<int> coordinates;

    BusinessInfoCoordinates({
        required this.type,
        required this.coordinates,
    });

    factory BusinessInfoCoordinates.fromJson(Map<String, dynamic> json) => BusinessInfoCoordinates(
        type: json["type"],
        coordinates: List<int>.from(json["coordinates"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
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
    BOUNCY_CASTLE_HIRE,
    HAULAGE_TRUCK_HIRE,
    PASSENGER_TRANSPORT,
    VENUE_HIRE
}

final categoryNameValues = EnumValues({
    "Bouncy Castle Hire": CategoryName.BOUNCY_CASTLE_HIRE,
    "Haulage Truck Hire": CategoryName.HAULAGE_TRUCK_HIRE,
    "Passenger Transport": CategoryName.PASSENGER_TRANSPORT,
    "Venue Hire": CategoryName.VENUE_HIRE
});

enum Id {
    THE_676_AC544234968_D45_B494992,
    THE_676_AC666234968_D45_B49499_C,
    THE_6777_CD2_EE5_C72875_FA12_C1_BB,
    THE_67864272093_AF0365_C00_F3_CE
}

final idValues = EnumValues({
    "676ac544234968d45b494992": Id.THE_676_AC544234968_D45_B494992,
    "676ac666234968d45b49499c": Id.THE_676_AC666234968_D45_B49499_C,
    "6777cd2ee5c72875fa12c1bb": Id.THE_6777_CD2_EE5_C72875_FA12_C1_BB,
    "67864272093af0365c00f3ce": Id.THE_67864272093_AF0365_C00_F3_CE
});

class DatumComfort {
    bool leatherInterior;
    bool wifiAccess;
    bool airConditioning;
    PurpleComplimentaryDrinks complimentaryDrinks;
    bool inCarEntertainment;
    bool bluetoothUsb;
    bool redCarpetService;
    bool? chauffeurInUniform;
    bool? recliningSeats;
    bool? starlights;
    bool? massagingSeats;
    bool onboardRestroom;

    DatumComfort({
        required this.leatherInterior,
        required this.wifiAccess,
        required this.airConditioning,
        required this.complimentaryDrinks,
        required this.inCarEntertainment,
        required this.bluetoothUsb,
        required this.redCarpetService,
        this.chauffeurInUniform,
        this.recliningSeats,
        this.starlights,
        this.massagingSeats,
        required this.onboardRestroom,
    });

    factory DatumComfort.fromJson(Map<String, dynamic> json) => DatumComfort(
        leatherInterior: json["leatherInterior"],
        wifiAccess: json["wifiAccess"],
        airConditioning: json["airConditioning"],
        complimentaryDrinks: PurpleComplimentaryDrinks.fromJson(json["complimentaryDrinks"]),
        inCarEntertainment: json["inCarEntertainment"],
        bluetoothUsb: json["bluetoothUsb"],
        redCarpetService: json["redCarpetService"],
        chauffeurInUniform: json["chauffeurInUniform"],
        recliningSeats: json["recliningSeats"],
        starlights: json["starlights"],
        massagingSeats: json["massagingSeats"],
        onboardRestroom: json["onboardRestroom"],
    );

    Map<String, dynamic> toJson() => {
        "leatherInterior": leatherInterior,
        "wifiAccess": wifiAccess,
        "airConditioning": airConditioning,
        "complimentaryDrinks": complimentaryDrinks.toJson(),
        "inCarEntertainment": inCarEntertainment,
        "bluetoothUsb": bluetoothUsb,
        "redCarpetService": redCarpetService,
        "chauffeurInUniform": chauffeurInUniform,
        "recliningSeats": recliningSeats,
        "starlights": starlights,
        "massagingSeats": massagingSeats,
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

enum Country {
    UNITED_KINGDOM
}

final countryValues = EnumValues({
    "United Kingdom": Country.UNITED_KINGDOM
});

class Coupon {
    String couponCode;
    DiscountType discountType;
    int discountValue;
    int usageLimit;
    int? currentUsageCount;
    dynamic expiryDate;
    bool isGlobal;
    String? id;
    int? minimumDays;
    int? minimumVehicles;
    String? description;
    int? usageCount;
    bool? isActive;

    Coupon({
        required this.couponCode,
        required this.discountType,
        required this.discountValue,
        required this.usageLimit,
        this.currentUsageCount,
        required this.expiryDate,
        required this.isGlobal,
        this.id,
        this.minimumDays,
        this.minimumVehicles,
        this.description,
        this.usageCount,
        this.isActive,
    });

    factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        couponCode: json["coupon_code"],
        discountType: discountTypeValues.map[json["discount_type"]]!,
        discountValue: json["discount_value"],
        usageLimit: json["usage_limit"],
        currentUsageCount: json["current_usage_count"],
        expiryDate: json["expiry_date"],
        isGlobal: json["is_global"],
        id: json["_id"],
        minimumDays: json["minimum_days"],
        minimumVehicles: json["minimum_vehicles"],
        description: json["description"],
        usageCount: json["usage_count"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "coupon_code": couponCode,
        "discount_type": discountTypeValues.reverse[discountType],
        "discount_value": discountValue,
        "usage_limit": usageLimit,
        "current_usage_count": currentUsageCount,
        "expiry_date": expiryDate,
        "is_global": isGlobal,
        "_id": id,
        "minimum_days": minimumDays,
        "minimum_vehicles": minimumVehicles,
        "description": description,
        "usage_count": usageCount,
        "is_active": isActive,
    };
}

enum DiscountType {
    FIXED_AMOUNT,
    PERCENTAGE
}

final discountTypeValues = EnumValues({
    "FIXED_AMOUNT": DiscountType.FIXED_AMOUNT,
    "PERCENTAGE": DiscountType.PERCENTAGE
});

class Coverage {
    CoverageBaseLocation baseLocation;
    List<ServiceArea> serviceAreas;
    AdvanceBookingMinimum maxDeliveryDistance;

    Coverage({
        required this.baseLocation,
        required this.serviceAreas,
        required this.maxDeliveryDistance,
    });

    factory Coverage.fromJson(Map<String, dynamic> json) => Coverage(
        baseLocation: CoverageBaseLocation.fromJson(json["baseLocation"]),
        serviceAreas: List<ServiceArea>.from(json["serviceAreas"].map((x) => ServiceArea.fromJson(x))),
        maxDeliveryDistance: AdvanceBookingMinimum.fromJson(json["maxDeliveryDistance"]),
    );

    Map<String, dynamic> toJson() => {
        "baseLocation": baseLocation.toJson(),
        "serviceAreas": List<dynamic>.from(serviceAreas.map((x) => x.toJson())),
        "maxDeliveryDistance": maxDeliveryDistance.toJson(),
    };
}

class CoverageBaseLocation {
    String postcode;

    CoverageBaseLocation({
        required this.postcode,
    });

    factory CoverageBaseLocation.fromJson(Map<String, dynamic> json) => CoverageBaseLocation(
        postcode: json["postcode"],
    );

    Map<String, dynamic> toJson() => {
        "postcode": postcode,
    };
}

class ServiceArea {
    String areaName;
    int radius;
    RadiusUnitEnum radiusUnit;
    String? id;

    ServiceArea({
        required this.areaName,
        required this.radius,
        required this.radiusUnit,
        this.id,
    });

    factory ServiceArea.fromJson(Map<String, dynamic> json) => ServiceArea(
        areaName: json["areaName"],
        radius: json["radius"],
        radiusUnit: radiusUnitEnumValues.map[json["radiusUnit"]]!,
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "areaName": areaName,
        "radius": radius,
        "radiusUnit": radiusUnitEnumValues.reverse[radiusUnit],
        "_id": id,
    };
}

class SpecialPriceDayElement {
    DateTime date;
    int price;
    String? id;

    SpecialPriceDayElement({
        required this.date,
        required this.price,
        this.id,
    });

    factory SpecialPriceDayElement.fromJson(Map<String, dynamic> json) => SpecialPriceDayElement(
        date: DateTime.parse(json["date"]),
        price: json["price"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "price": price,
        "_id": id,
    };
}

class DefaultAvailability {
    Day monday;
    Day tuesday;
    Day wednesday;
    Day thursday;
    Day friday;
    Day saturday;
    Day sunday;

    DefaultAvailability({
        required this.monday,
        required this.tuesday,
        required this.wednesday,
        required this.thursday,
        required this.friday,
        required this.saturday,
        required this.sunday,
    });

    factory DefaultAvailability.fromJson(Map<String, dynamic> json) => DefaultAvailability(
        monday: Day.fromJson(json["monday"]),
        tuesday: Day.fromJson(json["tuesday"]),
        wednesday: Day.fromJson(json["wednesday"]),
        thursday: Day.fromJson(json["thursday"]),
        friday: Day.fromJson(json["friday"]),
        saturday: Day.fromJson(json["saturday"]),
        sunday: Day.fromJson(json["sunday"]),
    );

    Map<String, dynamic> toJson() => {
        "monday": monday.toJson(),
        "tuesday": tuesday.toJson(),
        "wednesday": wednesday.toJson(),
        "thursday": thursday.toJson(),
        "friday": friday.toJson(),
        "saturday": saturday.toJson(),
        "sunday": sunday.toJson(),
    };
}

class Day {
    bool available;
    StartTime startTime;
    EndTime endTime;

    Day({
        required this.available,
        required this.startTime,
        required this.endTime,
    });

    factory Day.fromJson(Map<String, dynamic> json) => Day(
        available: json["available"],
        startTime: startTimeValues.map[json["startTime"]]!,
        endTime: endTimeValues.map[json["endTime"]]!,
    );

    Map<String, dynamic> toJson() => {
        "available": available,
        "startTime": startTimeValues.reverse[startTime],
        "endTime": endTimeValues.reverse[endTime],
    };
}

enum EndTime {
    THE_1700,
    THE_1900,
    THE_2200,
    THE_2300
}

final endTimeValues = EnumValues({
    "17:00": EndTime.THE_1700,
    "19:00": EndTime.THE_1900,
    "22:00": EndTime.THE_2200,
    "23:00": EndTime.THE_2300
});

enum StartTime {
    THE_0500,
    THE_0900
}

final startTimeValues = EnumValues({
    "05:00": StartTime.THE_0500,
    "09:00": StartTime.THE_0900
});

class DimensionsSpecifications {
    Dimensions dimensions;
    SetupSpace setupSpace;
    String conditionRating;

    DimensionsSpecifications({
        required this.dimensions,
        required this.setupSpace,
        required this.conditionRating,
    });

    factory DimensionsSpecifications.fromJson(Map<String, dynamic> json) => DimensionsSpecifications(
        dimensions: Dimensions.fromJson(json["dimensions"]),
        setupSpace: SetupSpace.fromJson(json["setupSpace"]),
        conditionRating: json["conditionRating"],
    );

    Map<String, dynamic> toJson() => {
        "dimensions": dimensions.toJson(),
        "setupSpace": setupSpace.toJson(),
        "conditionRating": conditionRating,
    };
}

class Dimensions {
    SetupSpace inflated;
    SetupSpace deflated;

    Dimensions({
        required this.inflated,
        required this.deflated,
    });

    factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        inflated: SetupSpace.fromJson(json["inflated"]),
        deflated: SetupSpace.fromJson(json["deflated"]),
    );

    Map<String, dynamic> toJson() => {
        "inflated": inflated.toJson(),
        "deflated": deflated.toJson(),
    };
}

class SetupSpace {
    double length;
    double width;
    double height;
    SetupSpaceUnit? unit;

    SetupSpace({
        required this.length,
        required this.width,
        required this.height,
        this.unit,
    });

    factory SetupSpace.fromJson(Map<String, dynamic> json) => SetupSpace(
        length: json["length"]?.toDouble(),
        width: json["width"]?.toDouble(),
        height: json["height"]?.toDouble(),
        unit: setupSpaceUnitValues.map[json["unit"]]!,
    );

    Map<String, dynamic> toJson() => {
        "length": length,
        "width": width,
        "height": height,
        "unit": setupSpaceUnitValues.reverse[unit],
    };
}

enum SetupSpaceUnit {
    METERS
}

final setupSpaceUnitValues = EnumValues({
    "METERS": SetupSpaceUnit.METERS
});

class DatumDocuments {
    Nce? operatorLicence;
    DbsCertificates? driverLicences;
    Nce? publicLiabilityInsurance;
    DbsCertificates? vehicleInsuranceAndMoTs;
    DbsCertificates? dbsCertificates;
    InsuranceCertificate? insuranceCertificate;
    PsvOperatorLicence? psvOperatorLicence;
    DbsCertificates? driverLicencesAndDbs;
    DbsCertificates? vehicleMotAndInsurance;
    BoatMasterLicence? boatMasterLicence;
    BoatMasterLicence? skipperCredentials;
    BoatMasterLicence? boatSafetyCertificate;
    BoatMasterLicence? vesselInsurance;
    BoatMasterLicence? localAuthorityLicence;
    VenueDocs? venueDocs;
    List<DriverLicence>? motCertificates;
    DriverLicence? goodsInTransitInsurance;
    DriverLicence? driverLicence;
    DriverLicence? vehicleLogbook;
    DriverLicence? forsCertificate;

    DatumDocuments({
        this.operatorLicence,
        this.driverLicences,
        this.publicLiabilityInsurance,
        this.vehicleInsuranceAndMoTs,
        this.dbsCertificates,
        this.insuranceCertificate,
        this.psvOperatorLicence,
        this.driverLicencesAndDbs,
        this.vehicleMotAndInsurance,
        this.boatMasterLicence,
        this.skipperCredentials,
        this.boatSafetyCertificate,
        this.vesselInsurance,
        this.localAuthorityLicence,
        this.venueDocs,
        this.motCertificates,
        this.goodsInTransitInsurance,
        this.driverLicence,
        this.vehicleLogbook,
        this.forsCertificate,
    });

    factory DatumDocuments.fromJson(Map<String, dynamic> json) => DatumDocuments(
        operatorLicence: json["operatorLicence"] == null ? null : Nce.fromJson(json["operatorLicence"]),
        driverLicences: json["driverLicences"] == null ? null : DbsCertificates.fromJson(json["driverLicences"]),
        publicLiabilityInsurance: json["publicLiabilityInsurance"] == null ? null : Nce.fromJson(json["publicLiabilityInsurance"]),
        vehicleInsuranceAndMoTs: json["vehicleInsuranceAndMOTs"] == null ? null : DbsCertificates.fromJson(json["vehicleInsuranceAndMOTs"]),
        dbsCertificates: json["dbsCertificates"] == null ? null : DbsCertificates.fromJson(json["dbsCertificates"]),
        insuranceCertificate: json["insuranceCertificate"] == null ? null : InsuranceCertificate.fromJson(json["insuranceCertificate"]),
        psvOperatorLicence: json["psvOperatorLicence"] == null ? null : PsvOperatorLicence.fromJson(json["psvOperatorLicence"]),
        driverLicencesAndDbs: json["driverLicencesAndDBS"] == null ? null : DbsCertificates.fromJson(json["driverLicencesAndDBS"]),
        vehicleMotAndInsurance: json["vehicleMOTAndInsurance"] == null ? null : DbsCertificates.fromJson(json["vehicleMOTAndInsurance"]),
        boatMasterLicence: json["boatMasterLicence"] == null ? null : BoatMasterLicence.fromJson(json["boatMasterLicence"]),
        skipperCredentials: json["skipperCredentials"] == null ? null : BoatMasterLicence.fromJson(json["skipperCredentials"]),
        boatSafetyCertificate: json["boatSafetyCertificate"] == null ? null : BoatMasterLicence.fromJson(json["boatSafetyCertificate"]),
        vesselInsurance: json["vesselInsurance"] == null ? null : BoatMasterLicence.fromJson(json["vesselInsurance"]),
        localAuthorityLicence: json["localAuthorityLicence"] == null ? null : BoatMasterLicence.fromJson(json["localAuthorityLicence"]),
        venueDocs: json["venueDocs"] == null ? null : VenueDocs.fromJson(json["venueDocs"]),
        motCertificates: json["motCertificates"] == null ? [] : List<DriverLicence>.from(json["motCertificates"]!.map((x) => DriverLicence.fromJson(x))),
        goodsInTransitInsurance: json["goodsInTransitInsurance"] == null ? null : DriverLicence.fromJson(json["goodsInTransitInsurance"]),
        driverLicence: json["driverLicence"] == null ? null : DriverLicence.fromJson(json["driverLicence"]),
        vehicleLogbook: json["vehicleLogbook"] == null ? null : DriverLicence.fromJson(json["vehicleLogbook"]),
        forsCertificate: json["forsCertificate"] == null ? null : DriverLicence.fromJson(json["forsCertificate"]),
    );

    Map<String, dynamic> toJson() => {
        "operatorLicence": operatorLicence?.toJson(),
        "driverLicences": driverLicences?.toJson(),
        "publicLiabilityInsurance": publicLiabilityInsurance?.toJson(),
        "vehicleInsuranceAndMOTs": vehicleInsuranceAndMoTs?.toJson(),
        "dbsCertificates": dbsCertificates?.toJson(),
        "insuranceCertificate": insuranceCertificate?.toJson(),
        "psvOperatorLicence": psvOperatorLicence?.toJson(),
        "driverLicencesAndDBS": driverLicencesAndDbs?.toJson(),
        "vehicleMOTAndInsurance": vehicleMotAndInsurance?.toJson(),
        "boatMasterLicence": boatMasterLicence?.toJson(),
        "skipperCredentials": skipperCredentials?.toJson(),
        "boatSafetyCertificate": boatSafetyCertificate?.toJson(),
        "vesselInsurance": vesselInsurance?.toJson(),
        "localAuthorityLicence": localAuthorityLicence?.toJson(),
        "venueDocs": venueDocs?.toJson(),
        "motCertificates": motCertificates == null ? [] : List<dynamic>.from(motCertificates!.map((x) => x.toJson())),
        "goodsInTransitInsurance": goodsInTransitInsurance?.toJson(),
        "driverLicence": driverLicence?.toJson(),
        "vehicleLogbook": vehicleLogbook?.toJson(),
        "forsCertificate": forsCertificate?.toJson(),
    };
}

class BoatMasterLicence {
    bool isAttached;
    String image;
    String id;

    BoatMasterLicence({
        required this.isAttached,
        required this.image,
        required this.id,
    });

    factory BoatMasterLicence.fromJson(Map<String, dynamic> json) => BoatMasterLicence(
        isAttached: json["isAttached"],
        image: json["image"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "isAttached": isAttached,
        "image": image,
        "_id": id,
    };
}

class DbsCertificates {
    bool isAttached;

    DbsCertificates({
        required this.isAttached,
    });

    factory DbsCertificates.fromJson(Map<String, dynamic> json) => DbsCertificates(
        isAttached: json["isAttached"],
    );

    Map<String, dynamic> toJson() => {
        "isAttached": isAttached,
    };
}

class DriverLicence {
    String type;
    String originalFilename;
    String url;
    String verificationStatus;

    DriverLicence({
        required this.type,
        required this.originalFilename,
        required this.url,
        required this.verificationStatus,
    });

    factory DriverLicence.fromJson(Map<String, dynamic> json) => DriverLicence(
        type: json["type"],
        originalFilename: json["originalFilename"],
        url: json["url"],
        verificationStatus: json["verificationStatus"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "originalFilename": originalFilename,
        "url": url,
        "verificationStatus": verificationStatus,
    };
}

class InsuranceCertificate {
    bool isAttached;
    String image;
    String fileName;
    String fileType;
    DateTime uploadedAt;

    InsuranceCertificate({
        required this.isAttached,
        required this.image,
        required this.fileName,
        required this.fileType,
        required this.uploadedAt,
    });

    factory InsuranceCertificate.fromJson(Map<String, dynamic> json) => InsuranceCertificate(
        isAttached: json["isAttached"],
        image: json["image"],
        fileName: json["fileName"],
        fileType: json["fileType"],
        uploadedAt: DateTime.parse(json["uploadedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "isAttached": isAttached,
        "image": image,
        "fileName": fileName,
        "fileType": fileType,
        "uploadedAt": uploadedAt.toIso8601String(),
    };
}

class Nce {
    bool? isAttached;
    String? image;
    String? fileName;
    String? fileType;
    DateTime? uploadedAt;
    String? id;
    String? type;
    String? originalFilename;
    String? url;
    String? verificationStatus;

    Nce({
        this.isAttached,
        this.image,
        this.fileName,
        this.fileType,
        this.uploadedAt,
        this.id,
        this.type,
        this.originalFilename,
        this.url,
        this.verificationStatus,
    });

    factory Nce.fromJson(Map<String, dynamic> json) => Nce(
        isAttached: json["isAttached"],
        image: json["image"],
        fileName: json["fileName"],
        fileType: json["fileType"],
        uploadedAt: json["uploadedAt"] == null ? null : DateTime.parse(json["uploadedAt"]),
        id: json["_id"],
        type: json["type"],
        originalFilename: json["originalFilename"],
        url: json["url"],
        verificationStatus: json["verificationStatus"],
    );

    Map<String, dynamic> toJson() => {
        "isAttached": isAttached,
        "image": image,
        "fileName": fileName,
        "fileType": fileType,
        "uploadedAt": uploadedAt?.toIso8601String(),
        "_id": id,
        "type": type,
        "originalFilename": originalFilename,
        "url": url,
        "verificationStatus": verificationStatus,
    };
}

class PsvOperatorLicence {
    bool isAttached;
    String image;

    PsvOperatorLicence({
        required this.isAttached,
        required this.image,
    });

    factory PsvOperatorLicence.fromJson(Map<String, dynamic> json) => PsvOperatorLicence(
        isAttached: json["isAttached"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "isAttached": isAttached,
        "image": image,
    };
}

class VenueDocs {
    PsvOperatorLicence publicLiability;
    PsvOperatorLicence? fireSafety;
    AlcoholLicence? alcoholLicence;
    FoodHygiene? foodHygiene;
    AlcoholLicence? vatRegistration;

    VenueDocs({
        required this.publicLiability,
        this.fireSafety,
        this.alcoholLicence,
        this.foodHygiene,
        this.vatRegistration,
    });

    factory VenueDocs.fromJson(Map<String, dynamic> json) => VenueDocs(
        publicLiability: PsvOperatorLicence.fromJson(json["publicLiability"]),
        fireSafety: json["fireSafety"] == null ? null : PsvOperatorLicence.fromJson(json["fireSafety"]),
        alcoholLicence: json["alcoholLicence"] == null ? null : AlcoholLicence.fromJson(json["alcoholLicence"]),
        foodHygiene: json["foodHygiene"] == null ? null : FoodHygiene.fromJson(json["foodHygiene"]),
        vatRegistration: json["vatRegistration"] == null ? null : AlcoholLicence.fromJson(json["vatRegistration"]),
    );

    Map<String, dynamic> toJson() => {
        "publicLiability": publicLiability.toJson(),
        "fireSafety": fireSafety?.toJson(),
        "alcoholLicence": alcoholLicence?.toJson(),
        "foodHygiene": foodHygiene?.toJson(),
        "vatRegistration": vatRegistration?.toJson(),
    };
}

class AlcoholLicence {
    String number;

    AlcoholLicence({
        required this.number,
    });

    factory AlcoholLicence.fromJson(Map<String, dynamic> json) => AlcoholLicence(
        number: json["number"],
    );

    Map<String, dynamic> toJson() => {
        "number": number,
    };
}

class FoodHygiene {
    String rating;

    FoodHygiene({
        required this.rating,
    });

    factory FoodHygiene.fromJson(Map<String, dynamic> json) => FoodHygiene(
        rating: json["rating"],
    );

    Map<String, dynamic> toJson() => {
        "rating": rating,
    };
}

class DriverCompliance {
    String licenceType;
    String licenceNumber;
    DateTime licenceExpiry;
    bool cpcCardHolder;
    List<dynamic> adrCategories;
    String tachographType;
    List<dynamic> safetyEquipment;
    DateTime motValidUntil;
    DateTime lastServiceDate;
    String? cpcCardNumber;
    DateTime? cpcExpiry;
    bool? adrCertified;

    DriverCompliance({
        required this.licenceType,
        required this.licenceNumber,
        required this.licenceExpiry,
        required this.cpcCardHolder,
        required this.adrCategories,
        required this.tachographType,
        required this.safetyEquipment,
        required this.motValidUntil,
        required this.lastServiceDate,
        this.cpcCardNumber,
        this.cpcExpiry,
        this.adrCertified,
    });

    factory DriverCompliance.fromJson(Map<String, dynamic> json) => DriverCompliance(
        licenceType: json["licenceType"],
        licenceNumber: json["licenceNumber"],
        licenceExpiry: DateTime.parse(json["licenceExpiry"]),
        cpcCardHolder: json["cpcCardHolder"],
        adrCategories: List<dynamic>.from(json["adrCategories"].map((x) => x)),
        tachographType: json["tachographType"],
        safetyEquipment: List<dynamic>.from(json["safetyEquipment"].map((x) => x)),
        motValidUntil: DateTime.parse(json["motValidUntil"]),
        lastServiceDate: DateTime.parse(json["lastServiceDate"]),
        cpcCardNumber: json["cpcCardNumber"],
        cpcExpiry: json["cpcExpiry"] == null ? null : DateTime.parse(json["cpcExpiry"]),
        adrCertified: json["adrCertified"],
    );

    Map<String, dynamic> toJson() => {
        "licenceType": licenceType,
        "licenceNumber": licenceNumber,
        "licenceExpiry": licenceExpiry.toIso8601String(),
        "cpcCardHolder": cpcCardHolder,
        "adrCategories": List<dynamic>.from(adrCategories.map((x) => x)),
        "tachographType": tachographType,
        "safetyEquipment": List<dynamic>.from(safetyEquipment.map((x) => x)),
        "motValidUntil": motValidUntil.toIso8601String(),
        "lastServiceDate": lastServiceDate.toIso8601String(),
        "cpcCardNumber": cpcCardNumber,
        "cpcExpiry": cpcExpiry?.toIso8601String(),
        "adrCertified": adrCertified,
    };
}

class Environmental {
    String emissionStandard;
    List<String> sustainabilityPractices;
    FleetAccreditation fleetAccreditation;
    List<String> cleanAirZoneCompliance;
    bool lowEmissionZoneCompliant;

    Environmental({
        required this.emissionStandard,
        required this.sustainabilityPractices,
        required this.fleetAccreditation,
        required this.cleanAirZoneCompliance,
        required this.lowEmissionZoneCompliant,
    });

    factory Environmental.fromJson(Map<String, dynamic> json) => Environmental(
        emissionStandard: json["emissionStandard"],
        sustainabilityPractices: List<String>.from(json["sustainabilityPractices"].map((x) => x)),
        fleetAccreditation: FleetAccreditation.fromJson(json["fleetAccreditation"]),
        cleanAirZoneCompliance: List<String>.from(json["cleanAirZoneCompliance"].map((x) => x)),
        lowEmissionZoneCompliant: json["lowEmissionZoneCompliant"],
    );

    Map<String, dynamic> toJson() => {
        "emissionStandard": emissionStandard,
        "sustainabilityPractices": List<dynamic>.from(sustainabilityPractices.map((x) => x)),
        "fleetAccreditation": fleetAccreditation.toJson(),
        "cleanAirZoneCompliance": List<dynamic>.from(cleanAirZoneCompliance.map((x) => x)),
        "lowEmissionZoneCompliant": lowEmissionZoneCompliant,
    };
}

class FleetAccreditation {
    String forsLevel;

    FleetAccreditation({
        required this.forsLevel,
    });

    factory FleetAccreditation.fromJson(Map<String, dynamic> json) => FleetAccreditation(
        forsLevel: json["forsLevel"],
    );

    Map<String, dynamic> toJson() => {
        "forsLevel": forsLevel,
    };
}

class EquipmentSafety {
    List<dynamic> safetyChecks;
    bool isMaintained;
    String uniformType;
    bool offersRouteInspection;
    List<String> animalWelfareStandards;

    EquipmentSafety({
        required this.safetyChecks,
        required this.isMaintained,
        required this.uniformType,
        required this.offersRouteInspection,
        required this.animalWelfareStandards,
    });

    factory EquipmentSafety.fromJson(Map<String, dynamic> json) => EquipmentSafety(
        safetyChecks: List<dynamic>.from(json["safetyChecks"].map((x) => x)),
        isMaintained: json["isMaintained"],
        uniformType: json["uniformType"],
        offersRouteInspection: json["offersRouteInspection"],
        animalWelfareStandards: List<String>.from(json["animalWelfareStandards"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "safetyChecks": List<dynamic>.from(safetyChecks.map((x) => x)),
        "isMaintained": isMaintained,
        "uniformType": uniformType,
        "offersRouteInspection": offersRouteInspection,
        "animalWelfareStandards": List<dynamic>.from(animalWelfareStandards.map((x) => x)),
    };
}

class EquipmentSelection {
    String inflatableType;
    String name;
    String description;
    String ageGroup;
    EquipmentSelectionCapacity capacity;
    int minAge;
    int maxAge;
    String theme;

    EquipmentSelection({
        required this.inflatableType,
        required this.name,
        required this.description,
        required this.ageGroup,
        required this.capacity,
        required this.minAge,
        required this.maxAge,
        required this.theme,
    });

    factory EquipmentSelection.fromJson(Map<String, dynamic> json) => EquipmentSelection(
        inflatableType: json["inflatableType"],
        name: json["name"],
        description: json["description"],
        ageGroup: json["ageGroup"],
        capacity: EquipmentSelectionCapacity.fromJson(json["capacity"]),
        minAge: json["minAge"],
        maxAge: json["maxAge"],
        theme: json["theme"],
    );

    Map<String, dynamic> toJson() => {
        "inflatableType": inflatableType,
        "name": name,
        "description": description,
        "ageGroup": ageGroup,
        "capacity": capacity.toJson(),
        "minAge": minAge,
        "maxAge": maxAge,
        "theme": theme,
    };
}

class EquipmentSelectionCapacity {
    int maximum;
    int recommended;

    EquipmentSelectionCapacity({
        required this.maximum,
        required this.recommended,
    });

    factory EquipmentSelectionCapacity.fromJson(Map<String, dynamic> json) => EquipmentSelectionCapacity(
        maximum: json["maximum"],
        recommended: json["recommended"],
    );

    Map<String, dynamic> toJson() => {
        "maximum": maximum,
        "recommended": recommended,
    };
}

class EventRules {
    String promotedEvents;
    String ageRestrictions;
    String curfewTime;
    String noiseRestrictions;
    String noiseRestrictionsDetails;
    DamageDepositRequired securityRequired;
    SecurityProvidedByVenue securityProvidedByVenue;
    List<String> decorationsAllowed;
    String otherDecorations;
    DamageDepositRequired damageDepositRequired;
    int damageDepositAmount;

    EventRules({
        required this.promotedEvents,
        required this.ageRestrictions,
        required this.curfewTime,
        required this.noiseRestrictions,
        required this.noiseRestrictionsDetails,
        required this.securityRequired,
        required this.securityProvidedByVenue,
        required this.decorationsAllowed,
        required this.otherDecorations,
        required this.damageDepositRequired,
        required this.damageDepositAmount,
    });

    factory EventRules.fromJson(Map<String, dynamic> json) => EventRules(
        promotedEvents: json["promotedEvents"],
        ageRestrictions: json["ageRestrictions"],
        curfewTime: json["curfewTime"],
        noiseRestrictions: json["noiseRestrictions"],
        noiseRestrictionsDetails: json["noiseRestrictionsDetails"],
        securityRequired: damageDepositRequiredValues.map[json["securityRequired"]]!,
        securityProvidedByVenue: securityProvidedByVenueValues.map[json["securityProvidedByVenue"]]!,
        decorationsAllowed: List<String>.from(json["decorationsAllowed"].map((x) => x)),
        otherDecorations: json["otherDecorations"],
        damageDepositRequired: damageDepositRequiredValues.map[json["damageDepositRequired"]]!,
        damageDepositAmount: json["damageDepositAmount"],
    );

    Map<String, dynamic> toJson() => {
        "promotedEvents": promotedEvents,
        "ageRestrictions": ageRestrictions,
        "curfewTime": curfewTime,
        "noiseRestrictions": noiseRestrictions,
        "noiseRestrictionsDetails": noiseRestrictionsDetails,
        "securityRequired": damageDepositRequiredValues.reverse[securityRequired],
        "securityProvidedByVenue": securityProvidedByVenueValues.reverse[securityProvidedByVenue],
        "decorationsAllowed": List<dynamic>.from(decorationsAllowed.map((x) => x)),
        "otherDecorations": otherDecorations,
        "damageDepositRequired": damageDepositRequiredValues.reverse[damageDepositRequired],
        "damageDepositAmount": damageDepositAmount,
    };
}

enum DamageDepositRequired {
    NO,
    YES
}

final damageDepositRequiredValues = EnumValues({
    "no": DamageDepositRequired.NO,
    "yes": DamageDepositRequired.YES
});

enum SecurityProvidedByVenue {
    CLIENT_MUST,
    EMPTY,
    NYPD
}

final securityProvidedByVenueValues = EnumValues({
    "client must": SecurityProvidedByVenue.CLIENT_MUST,
    "": SecurityProvidedByVenue.EMPTY,
    "NYPD": SecurityProvidedByVenue.NYPD
});

class Events {
    bool? weddingDecor;
    int? weddingDecorPrice;
    bool partyLightingSystem;
    int? partyLightingPrice;
    bool champagnePackages;
    int? champagnePackagePrice;
    String? champagnePackageDetails;
    bool photographyPackages;
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
        required this.partyLightingSystem,
        required this.partyLightingPrice,
        required this.champagnePackages,
        required this.champagnePackagePrice,
        this.champagnePackageDetails,
        required this.photographyPackages,
        required this.photographyPackagePrice,
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

class Facilities {
    Catering catering;
    FacilitiesParking parking;
    FacilitiesCapacity capacity;
    Amenities amenities;

    Facilities({
        required this.catering,
        required this.parking,
        required this.capacity,
        required this.amenities,
    });

    factory Facilities.fromJson(Map<String, dynamic> json) => Facilities(
        catering: Catering.fromJson(json["catering"]),
        parking: FacilitiesParking.fromJson(json["parking"]),
        capacity: FacilitiesCapacity.fromJson(json["capacity"]),
        amenities: Amenities.fromJson(json["amenities"]),
    );

    Map<String, dynamic> toJson() => {
        "catering": catering.toJson(),
        "parking": parking.toJson(),
        "capacity": capacity.toJson(),
        "amenities": amenities.toJson(),
    };
}

class Amenities {
    DamageDepositRequired wifi;
    int wifiPrice;
    DamageDepositRequired projectorAv;
    int projectorAvPrice;
    DamageDepositRequired stageDanceFloor;
    DamageDepositRequired soundLighting;
    DamageDepositRequired wheelchairAccessible;
    int wheelchairAccessiblePrice;
    DamageDepositRequired toilets;
    DamageDepositRequired stepFreeAccess;

    Amenities({
        required this.wifi,
        required this.wifiPrice,
        required this.projectorAv,
        required this.projectorAvPrice,
        required this.stageDanceFloor,
        required this.soundLighting,
        required this.wheelchairAccessible,
        required this.wheelchairAccessiblePrice,
        required this.toilets,
        required this.stepFreeAccess,
    });

    factory Amenities.fromJson(Map<String, dynamic> json) => Amenities(
        wifi: damageDepositRequiredValues.map[json["wifi"]]!,
        wifiPrice: json["wifiPrice"],
        projectorAv: damageDepositRequiredValues.map[json["projectorAV"]]!,
        projectorAvPrice: json["projectorAVPrice"],
        stageDanceFloor: damageDepositRequiredValues.map[json["stageDanceFloor"]]!,
        soundLighting: damageDepositRequiredValues.map[json["soundLighting"]]!,
        wheelchairAccessible: damageDepositRequiredValues.map[json["wheelchairAccessible"]]!,
        wheelchairAccessiblePrice: json["wheelchairAccessiblePrice"],
        toilets: damageDepositRequiredValues.map[json["toilets"]]!,
        stepFreeAccess: damageDepositRequiredValues.map[json["stepFreeAccess"]]!,
    );

    Map<String, dynamic> toJson() => {
        "wifi": damageDepositRequiredValues.reverse[wifi],
        "wifiPrice": wifiPrice,
        "projectorAV": damageDepositRequiredValues.reverse[projectorAv],
        "projectorAVPrice": projectorAvPrice,
        "stageDanceFloor": damageDepositRequiredValues.reverse[stageDanceFloor],
        "soundLighting": damageDepositRequiredValues.reverse[soundLighting],
        "wheelchairAccessible": damageDepositRequiredValues.reverse[wheelchairAccessible],
        "wheelchairAccessiblePrice": wheelchairAccessiblePrice,
        "toilets": damageDepositRequiredValues.reverse[toilets],
        "stepFreeAccess": damageDepositRequiredValues.reverse[stepFreeAccess],
    };
}

class FacilitiesCapacity {
    int dining;
    int standing;
    int theatre;

    FacilitiesCapacity({
        required this.dining,
        required this.standing,
        required this.theatre,
    });

    factory FacilitiesCapacity.fromJson(Map<String, dynamic> json) => FacilitiesCapacity(
        dining: json["dining"],
        standing: json["standing"],
        theatre: json["theatre"],
    );

    Map<String, dynamic> toJson() => {
        "dining": dining,
        "standing": standing,
        "theatre": theatre,
    };
}

class Catering {
    DamageDepositRequired inHouseCatering;
    DamageDepositRequired externalCaterersOnly;
    DamageDepositRequired byoFoodAllowed;
    DamageDepositRequired alcoholProvided;
    DamageDepositRequired byoAlcoholAllowed;
    int corkageFee;

    Catering({
        required this.inHouseCatering,
        required this.externalCaterersOnly,
        required this.byoFoodAllowed,
        required this.alcoholProvided,
        required this.byoAlcoholAllowed,
        required this.corkageFee,
    });

    factory Catering.fromJson(Map<String, dynamic> json) => Catering(
        inHouseCatering: damageDepositRequiredValues.map[json["inHouseCatering"]]!,
        externalCaterersOnly: damageDepositRequiredValues.map[json["externalCaterersOnly"]]!,
        byoFoodAllowed: damageDepositRequiredValues.map[json["byoFoodAllowed"]]!,
        alcoholProvided: damageDepositRequiredValues.map[json["alcoholProvided"]]!,
        byoAlcoholAllowed: damageDepositRequiredValues.map[json["byoAlcoholAllowed"]]!,
        corkageFee: json["corkageFee"],
    );

    Map<String, dynamic> toJson() => {
        "inHouseCatering": damageDepositRequiredValues.reverse[inHouseCatering],
        "externalCaterersOnly": damageDepositRequiredValues.reverse[externalCaterersOnly],
        "byoFoodAllowed": damageDepositRequiredValues.reverse[byoFoodAllowed],
        "alcoholProvided": damageDepositRequiredValues.reverse[alcoholProvided],
        "byoAlcoholAllowed": damageDepositRequiredValues.reverse[byoAlcoholAllowed],
        "corkageFee": corkageFee,
    };
}

class FacilitiesParking {
    DamageDepositRequired freeParkingOnPremises;
    DamageDepositRequired paidParkingNearby;
    DamageDepositRequired onsiteAccommodation;

    FacilitiesParking({
        required this.freeParkingOnPremises,
        required this.paidParkingNearby,
        required this.onsiteAccommodation,
    });

    factory FacilitiesParking.fromJson(Map<String, dynamic> json) => FacilitiesParking(
        freeParkingOnPremises: damageDepositRequiredValues.map[json["freeParkingOnPremises"]]!,
        paidParkingNearby: damageDepositRequiredValues.map[json["paidParkingNearby"]]!,
        onsiteAccommodation: damageDepositRequiredValues.map[json["onsiteAccommodation"]]!,
    );

    Map<String, dynamic> toJson() => {
        "freeParkingOnPremises": damageDepositRequiredValues.reverse[freeParkingOnPremises],
        "paidParkingNearby": damageDepositRequiredValues.reverse[paidParkingNearby],
        "onsiteAccommodation": damageDepositRequiredValues.reverse[onsiteAccommodation],
    };
}

class Features {
    FeaturesComfort? comfort;
    Events? events;
    AccessibilityClass? accessibility;
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
        accessibility: json["accessibility"] == null ? null : AccessibilityClass.fromJson(json["accessibility"]),
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
    bool leatherInterior;
    bool wifiAccess;
    bool airConditioning;
    FluffyComplimentaryDrinks complimentaryDrinks;
    bool inCarEntertainment;
    bool bluetoothUsb;
    bool redCarpetService;
    bool chauffeurInUniform;
    bool? recliningSeats;
    bool? starlights;
    bool? massagingSeats;
    bool? onboardRestroom;

    FeaturesComfort({
        required this.leatherInterior,
        required this.wifiAccess,
        required this.airConditioning,
        required this.complimentaryDrinks,
        required this.inCarEntertainment,
        required this.bluetoothUsb,
        required this.redCarpetService,
        required this.chauffeurInUniform,
        this.recliningSeats,
        this.starlights,
        this.massagingSeats,
        this.onboardRestroom,
    });

    factory FeaturesComfort.fromJson(Map<String, dynamic> json) => FeaturesComfort(
        leatherInterior: json["leatherInterior"],
        wifiAccess: json["wifiAccess"],
        airConditioning: json["airConditioning"],
        complimentaryDrinks: FluffyComplimentaryDrinks.fromJson(json["complimentaryDrinks"]),
        inCarEntertainment: json["inCarEntertainment"],
        bluetoothUsb: json["bluetoothUsb"],
        redCarpetService: json["redCarpetService"],
        chauffeurInUniform: json["chauffeurInUniform"],
        recliningSeats: json["recliningSeats"],
        starlights: json["starlights"],
        massagingSeats: json["massagingSeats"],
        onboardRestroom: json["onboardRestroom"],
    );

    Map<String, dynamic> toJson() => {
        "leatherInterior": leatherInterior,
        "wifiAccess": wifiAccess,
        "airConditioning": airConditioning,
        "complimentaryDrinks": complimentaryDrinks.toJson(),
        "inCarEntertainment": inCarEntertainment,
        "bluetoothUsb": bluetoothUsb,
        "redCarpetService": redCarpetService,
        "chauffeurInUniform": chauffeurInUniform,
        "recliningSeats": recliningSeats,
        "starlights": starlights,
        "massagingSeats": massagingSeats,
        "onboardRestroom": onboardRestroom,
    };
}

class FluffyComplimentaryDrinks {
    bool available;
    int? price;
    String details;

    FluffyComplimentaryDrinks({
        required this.available,
        this.price,
        required this.details,
    });

    factory FluffyComplimentaryDrinks.fromJson(Map<String, dynamic> json) => FluffyComplimentaryDrinks(
        available: json["available"],
        price: json["price"],
        details: json["details"],
    );

    Map<String, dynamic> toJson() => {
        "available": available,
        "price": price,
        "details": details,
    };
}

class Security {
    bool vehicleTrackingGps;
    bool cctvFitted;
    bool publicLiabilityInsurance;
    bool? dbsCheckedDrivers;
    bool? safetyCertifiedDrivers;

    Security({
        required this.vehicleTrackingGps,
        required this.cctvFitted,
        required this.publicLiabilityInsurance,
        this.dbsCheckedDrivers,
        this.safetyCertifiedDrivers,
    });

    factory Security.fromJson(Map<String, dynamic> json) => Security(
        vehicleTrackingGps: json["vehicleTrackingGps"],
        cctvFitted: json["cctvFitted"],
        publicLiabilityInsurance: json["publicLiabilityInsurance"],
        dbsCheckedDrivers: json["dbsCheckedDrivers"],
        safetyCertifiedDrivers: json["safetyCertifiedDrivers"],
    );

    Map<String, dynamic> toJson() => {
        "vehicleTrackingGps": vehicleTrackingGps,
        "cctvFitted": cctvFitted,
        "publicLiabilityInsurance": publicLiabilityInsurance,
        "dbsCheckedDrivers": dbsCheckedDrivers,
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
    int? luggageCapacity;
    int largeSuitcases;
    int mediumSuitcases;
    int smallSuitcases;
    int seats;
    DateTime? firstRegistered;
    bool? wheelchairAccessible;
    bool? airConditioning;
    bool? luggageSpace;
    int? wheelchairAccessiblePrice;
    DateTime? firstRegistration;
    String? colour;

    FleetInfo({
        required this.makeAndModel,
        this.luggageCapacity,
        required this.largeSuitcases,
        required this.mediumSuitcases,
        required this.smallSuitcases,
        required this.seats,
        this.firstRegistered,
        this.wheelchairAccessible,
        this.airConditioning,
        this.luggageSpace,
        this.wheelchairAccessiblePrice,
        this.firstRegistration,
        this.colour,
    });

    factory FleetInfo.fromJson(Map<String, dynamic> json) => FleetInfo(
        makeAndModel: json["makeAndModel"],
        luggageCapacity: json["luggageCapacity"],
        largeSuitcases: json["largeSuitcases"],
        mediumSuitcases: json["mediumSuitcases"],
        smallSuitcases: json["smallSuitcases"],
        seats: json["seats"],
        firstRegistered: json["firstRegistered"] == null ? null : DateTime.parse(json["firstRegistered"]),
        wheelchairAccessible: json["wheelchairAccessible"],
        airConditioning: json["airConditioning"],
        luggageSpace: json["luggageSpace"],
        wheelchairAccessiblePrice: json["wheelchairAccessiblePrice"],
        firstRegistration: json["firstRegistration"] == null ? null : DateTime.parse(json["firstRegistration"]),
        colour: json["colour"],
    );

    Map<String, dynamic> toJson() => {
        "makeAndModel": makeAndModel,
        "luggageCapacity": luggageCapacity,
        "largeSuitcases": largeSuitcases,
        "mediumSuitcases": mediumSuitcases,
        "smallSuitcases": smallSuitcases,
        "seats": seats,
        "firstRegistered": firstRegistered?.toIso8601String(),
        "wheelchairAccessible": wheelchairAccessible,
        "airConditioning": airConditioning,
        "luggageSpace": luggageSpace,
        "wheelchairAccessiblePrice": wheelchairAccessiblePrice,
        "firstRegistration": firstRegistration?.toIso8601String(),
        "colour": colour,
    };
}

class FleetInformation {
    List<String> vehicleTypes;
    String vehicleRegistration;
    String make;
    String model;
    int year;
    double gvw;
    int loadCapacity;
    SetupSpace dimensions;
    String? fuelType;
    int? mileage;
    String? trailerType;
    String? trailerSize;

    FleetInformation({
        required this.vehicleTypes,
        required this.vehicleRegistration,
        required this.make,
        required this.model,
        required this.year,
        required this.gvw,
        required this.loadCapacity,
        required this.dimensions,
        this.fuelType,
        this.mileage,
        this.trailerType,
        this.trailerSize,
    });

    factory FleetInformation.fromJson(Map<String, dynamic> json) => FleetInformation(
        vehicleTypes: List<String>.from(json["vehicleTypes"].map((x) => x)),
        vehicleRegistration: json["vehicleRegistration"],
        make: json["make"],
        model: json["model"],
        year: json["year"],
        gvw: json["gvw"]?.toDouble(),
        loadCapacity: json["loadCapacity"],
        dimensions: SetupSpace.fromJson(json["dimensions"]),
        fuelType: json["fuelType"],
        mileage: json["mileage"],
        trailerType: json["trailerType"],
        trailerSize: json["trailerSize"],
    );

    Map<String, dynamic> toJson() => {
        "vehicleTypes": List<dynamic>.from(vehicleTypes.map((x) => x)),
        "vehicleRegistration": vehicleRegistration,
        "make": make,
        "model": model,
        "year": year,
        "gvw": gvw,
        "loadCapacity": loadCapacity,
        "dimensions": dimensions.toJson(),
        "fuelType": fuelType,
        "mileage": mileage,
        "trailerType": trailerType,
        "trailerSize": trailerSize,
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

class FuneralVehicleTypes {
    bool traditionalHearse;
    int traditionalHearsePrice;
    bool horseDrawnHearse;
    int horseDrawnHearsePrice;
    bool limousine;
    int limousinePrice;
    bool alternativeVehicle;
    int alternativeVehiclePrice;
    int otherVehicleTypePrice;
    String otherVehicleDescription;
    bool otherVehiclType;

    FuneralVehicleTypes({
        required this.traditionalHearse,
        required this.traditionalHearsePrice,
        required this.horseDrawnHearse,
        required this.horseDrawnHearsePrice,
        required this.limousine,
        required this.limousinePrice,
        required this.alternativeVehicle,
        required this.alternativeVehiclePrice,
        required this.otherVehicleTypePrice,
        required this.otherVehicleDescription,
        required this.otherVehiclType,
    });

    factory FuneralVehicleTypes.fromJson(Map<String, dynamic> json) => FuneralVehicleTypes(
        traditionalHearse: json["traditionalHearse"],
        traditionalHearsePrice: json["traditionalHearsePrice"],
        horseDrawnHearse: json["horseDrawnHearse"],
        horseDrawnHearsePrice: json["horseDrawnHearsePrice"],
        limousine: json["limousine"],
        limousinePrice: json["limousinePrice"],
        alternativeVehicle: json["alternativeVehicle"],
        alternativeVehiclePrice: json["alternativeVehiclePrice"],
        otherVehicleTypePrice: json["otherVehicleTypePrice"],
        otherVehicleDescription: json["otherVehicleDescription"],
        otherVehiclType: json["otherVehiclType"],
    );

    Map<String, dynamic> toJson() => {
        "traditionalHearse": traditionalHearse,
        "traditionalHearsePrice": traditionalHearsePrice,
        "horseDrawnHearse": horseDrawnHearse,
        "horseDrawnHearsePrice": horseDrawnHearsePrice,
        "limousine": limousine,
        "limousinePrice": limousinePrice,
        "alternativeVehicle": alternativeVehicle,
        "alternativeVehiclePrice": alternativeVehiclePrice,
        "otherVehicleTypePrice": otherVehicleTypePrice,
        "otherVehicleDescription": otherVehicleDescription,
        "otherVehiclType": otherVehiclType,
    };
}

class LegalDeclaration {
    bool termsAndConditionsAccepted;
    bool privacyPolicyAccepted;
    bool dataProcessingConsent;
    bool accuracyDeclaration;
    bool insuranceConfirmation;
    bool licenceValidityConfirmation;
    bool rightToWorkConfirmation;
    String fullLegalName;
    String digitalSignature;
    DateTime signatureDate;
    bool? marketingConsent;
    bool? thirdPartyDataSharing;

    LegalDeclaration({
        required this.termsAndConditionsAccepted,
        required this.privacyPolicyAccepted,
        required this.dataProcessingConsent,
        required this.accuracyDeclaration,
        required this.insuranceConfirmation,
        required this.licenceValidityConfirmation,
        required this.rightToWorkConfirmation,
        required this.fullLegalName,
        required this.digitalSignature,
        required this.signatureDate,
        this.marketingConsent,
        this.thirdPartyDataSharing,
    });

    factory LegalDeclaration.fromJson(Map<String, dynamic> json) => LegalDeclaration(
        termsAndConditionsAccepted: json["termsAndConditionsAccepted"],
        privacyPolicyAccepted: json["privacyPolicyAccepted"],
        dataProcessingConsent: json["dataProcessingConsent"],
        accuracyDeclaration: json["accuracyDeclaration"],
        insuranceConfirmation: json["insuranceConfirmation"],
        licenceValidityConfirmation: json["licenceValidityConfirmation"],
        rightToWorkConfirmation: json["rightToWorkConfirmation"],
        fullLegalName: json["fullLegalName"],
        digitalSignature: json["digitalSignature"],
        signatureDate: DateTime.parse(json["signatureDate"]),
        marketingConsent: json["marketingConsent"],
        thirdPartyDataSharing: json["thirdPartyDataSharing"],
    );

    Map<String, dynamic> toJson() => {
        "termsAndConditionsAccepted": termsAndConditionsAccepted,
        "privacyPolicyAccepted": privacyPolicyAccepted,
        "dataProcessingConsent": dataProcessingConsent,
        "accuracyDeclaration": accuracyDeclaration,
        "insuranceConfirmation": insuranceConfirmation,
        "licenceValidityConfirmation": licenceValidityConfirmation,
        "rightToWorkConfirmation": rightToWorkConfirmation,
        "fullLegalName": fullLegalName,
        "digitalSignature": digitalSignature,
        "signatureDate": signatureDate.toIso8601String(),
        "marketingConsent": marketingConsent,
        "thirdPartyDataSharing": thirdPartyDataSharing,
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
    PsvOperatorLicence operatorLicence;
    PsvOperatorLicence vehicleInsurance;
    PsvOperatorLicence publicLiabilityInsurance;
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
        operatorLicence: PsvOperatorLicence.fromJson(json["operatorLicence"]),
        vehicleInsurance: PsvOperatorLicence.fromJson(json["vehicleInsurance"]),
        publicLiabilityInsurance: PsvOperatorLicence.fromJson(json["publicLiabilityInsurance"]),
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

class ListingData {
    List<dynamic> features;
    List<dynamic> areasCovered;

    ListingData({
        required this.features,
        required this.areasCovered,
    });

    factory ListingData.fromJson(Map<String, dynamic> json) => ListingData(
        features: List<dynamic>.from(json["features"].map((x) => x)),
        areasCovered: List<dynamic>.from(json["areasCovered"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "features": List<dynamic>.from(features.map((x) => x)),
        "areasCovered": List<dynamic>.from(areasCovered.map((x) => x)),
    };
}

class ListingPreferences {
    List<String> subcategories;
    List<String> promotionalAddons;
    List<PhotoGallery> photoGallery;
    List<dynamic> seasonalAvailability;
    String? businessDescription;

    ListingPreferences({
        required this.subcategories,
        required this.promotionalAddons,
        required this.photoGallery,
        required this.seasonalAvailability,
        this.businessDescription,
    });

    factory ListingPreferences.fromJson(Map<String, dynamic> json) => ListingPreferences(
        subcategories: List<String>.from(json["subcategories"].map((x) => x)),
        promotionalAddons: List<String>.from(json["promotionalAddons"].map((x) => x)),
        photoGallery: List<PhotoGallery>.from(json["photoGallery"].map((x) => PhotoGallery.fromJson(x))),
        seasonalAvailability: List<dynamic>.from(json["seasonalAvailability"].map((x) => x)),
        businessDescription: json["businessDescription"],
    );

    Map<String, dynamic> toJson() => {
        "subcategories": List<dynamic>.from(subcategories.map((x) => x)),
        "promotionalAddons": List<dynamic>.from(promotionalAddons.map((x) => x)),
        "photoGallery": List<dynamic>.from(photoGallery.map((x) => x.toJson())),
        "seasonalAvailability": List<dynamic>.from(seasonalAvailability.map((x) => x)),
        "businessDescription": businessDescription,
    };
}

class PhotoGallery {
    String id;
    String url;
    String caption;
    int order;
    bool isPrimary;

    PhotoGallery({
        required this.id,
        required this.url,
        required this.caption,
        required this.order,
        required this.isPrimary,
    });

    factory PhotoGallery.fromJson(Map<String, dynamic> json) => PhotoGallery(
        id: json["id"],
        url: json["url"],
        caption: json["caption"],
        order: json["order"],
        isPrimary: json["isPrimary"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "caption": caption,
        "order": order,
        "isPrimary": isPrimary,
    };
}

class LocationCoverage {
    LocationCoverageBaseLocation baseLocation;
    List<ServiceArea> serviceAreas;
    AdvanceBookingMinimum maxDeliveryDistance;

    LocationCoverage({
        required this.baseLocation,
        required this.serviceAreas,
        required this.maxDeliveryDistance,
    });

    factory LocationCoverage.fromJson(Map<String, dynamic> json) => LocationCoverage(
        baseLocation: LocationCoverageBaseLocation.fromJson(json["baseLocation"]),
        serviceAreas: List<ServiceArea>.from(json["serviceAreas"].map((x) => ServiceArea.fromJson(x))),
        maxDeliveryDistance: AdvanceBookingMinimum.fromJson(json["maxDeliveryDistance"]),
    );

    Map<String, dynamic> toJson() => {
        "baseLocation": baseLocation.toJson(),
        "serviceAreas": List<dynamic>.from(serviceAreas.map((x) => x.toJson())),
        "maxDeliveryDistance": maxDeliveryDistance.toJson(),
    };
}

class LocationCoverageBaseLocation {
    String address;
    String city;
    String county;
    String postcode;
    Country country;
    BaseLocationCoordinates coordinates;

    LocationCoverageBaseLocation({
        required this.address,
        required this.city,
        required this.county,
        required this.postcode,
        required this.country,
        required this.coordinates,
    });

    factory LocationCoverageBaseLocation.fromJson(Map<String, dynamic> json) => LocationCoverageBaseLocation(
        address: json["address"],
        city: json["city"],
        county: json["county"],
        postcode: json["postcode"],
        country: countryValues.map[json["country"]]!,
        coordinates: BaseLocationCoordinates.fromJson(json["coordinates"]),
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "city": city,
        "county": county,
        "postcode": postcode,
        "country": countryValues.reverse[country],
        "coordinates": coordinates.toJson(),
    };
}

class BaseLocationCoordinates {
    int latitude;
    int longitude;

    BaseLocationCoordinates({
        required this.latitude,
        required this.longitude,
    });

    factory BaseLocationCoordinates.fromJson(Map<String, dynamic> json) => BaseLocationCoordinates(
        latitude: json["latitude"],
        longitude: json["longitude"],
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
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
        largeSuitcases: json["largeSuitcases"],
        mediumSuitcases: json["mediumSuitcases"],
        smallSuitcases: json["smallSuitcases"],
    );

    Map<String, dynamic> toJson() => {
        "largeSuitcases": largeSuitcases,
        "mediumSuitcases": mediumSuitcases,
        "smallSuitcases": smallSuitcases,
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

class MarketingHighlights {
    String highlights;
    String shortDescription;

    MarketingHighlights({
        required this.highlights,
        required this.shortDescription,
    });

    factory MarketingHighlights.fromJson(Map<String, dynamic> json) => MarketingHighlights(
        highlights: json["highlights"],
        shortDescription: json["shortDescription"],
    );

    Map<String, dynamic> toJson() => {
        "highlights": highlights,
        "shortDescription": shortDescription,
    };
}

enum MembershipTier {
    FREE
}

final membershipTierValues = EnumValues({
    "free": MembershipTier.FREE
});

class Metrics {
    int totalBookings;
    int completedBookings;
    int cancelledBookings;
    int averageRating;
    int totalReviews;

    Metrics({
        required this.totalBookings,
        required this.completedBookings,
        required this.cancelledBookings,
        required this.averageRating,
        required this.totalReviews,
    });

    factory Metrics.fromJson(Map<String, dynamic> json) => Metrics(
        totalBookings: json["totalBookings"],
        completedBookings: json["completedBookings"],
        cancelledBookings: json["cancelledBookings"],
        averageRating: json["averageRating"],
        totalReviews: json["totalReviews"],
    );

    Map<String, dynamic> toJson() => {
        "totalBookings": totalBookings,
        "completedBookings": completedBookings,
        "cancelledBookings": cancelledBookings,
        "averageRating": averageRating,
        "totalReviews": totalReviews,
    };
}

class MiniBusRates {
    int hourlyRate;
    int halfDayRate;
    int fullDayRate;
    int additionalMileageFee;
    int mileageLimit;

    MiniBusRates({
        required this.hourlyRate,
        required this.halfDayRate,
        required this.fullDayRate,
        required this.additionalMileageFee,
        required this.mileageLimit,
    });

    factory MiniBusRates.fromJson(Map<String, dynamic> json) => MiniBusRates(
        hourlyRate: json["hourlyRate"],
        halfDayRate: json["halfDayRate"],
        fullDayRate: json["fullDayRate"],
        additionalMileageFee: json["additionalMileageFee"],
        mileageLimit: json["mileageLimit"],
    );

    Map<String, dynamic> toJson() => {
        "hourlyRate": hourlyRate,
        "halfDayRate": halfDayRate,
        "fullDayRate": fullDayRate,
        "additionalMileageFee": additionalMileageFee,
        "mileageLimit": mileageLimit,
    };
}

class OperatingHours {
    String? start;
    String? end;
    String seasonalClosures;

    OperatingHours({
        this.start,
        this.end,
        required this.seasonalClosures,
    });

    factory OperatingHours.fromJson(Map<String, dynamic> json) => OperatingHours(
        start: json["start"],
        end: json["end"],
        seasonalClosures: json["seasonalClosures"],
    );

    Map<String, dynamic> toJson() => {
        "start": start,
        "end": end,
        "seasonalClosures": seasonalClosures,
    };
}

class PackageDeal {
    String packageName;
    String packageDescription;
    double packageRate;
    List<String>? inclusions;
    String id;

    PackageDeal({
        required this.packageName,
        required this.packageDescription,
        required this.packageRate,
        this.inclusions,
        required this.id,
    });

    factory PackageDeal.fromJson(Map<String, dynamic> json) => PackageDeal(
        packageName: json["packageName"],
        packageDescription: json["packageDescription"],
        packageRate: json["packageRate"]?.toDouble(),
        inclusions: json["inclusions"] == null ? [] : List<String>.from(json["inclusions"]!.map((x) => x)),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "packageName": packageName,
        "packageDescription": packageDescription,
        "packageRate": packageRate,
        "inclusions": inclusions == null ? [] : List<dynamic>.from(inclusions!.map((x) => x)),
        "_id": id,
    };
}

class DatumParking {
    bool available;
    int spaces;
    String type;

    DatumParking({
        required this.available,
        required this.spaces,
        required this.type,
    });

    factory DatumParking.fromJson(Map<String, dynamic> json) => DatumParking(
        available: json["available"],
        spaces: json["spaces"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "available": available,
        "spaces": spaces,
        "type": type,
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

class PhotosMedia {
    List<Photo> photos;
    String virtualTourUrl;

    PhotosMedia({
        required this.photos,
        required this.virtualTourUrl,
    });

    factory PhotosMedia.fromJson(Map<String, dynamic> json) => PhotosMedia(
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        virtualTourUrl: json["virtualTourUrl"],
    );

    Map<String, dynamic> toJson() => {
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
        "virtualTourUrl": virtualTourUrl,
    };
}

class Photo {
    String url;
    String caption;
    bool isPrimary;
    int order;
    String id;
    DateTime uploadedAt;

    Photo({
        required this.url,
        required this.caption,
        required this.isPrimary,
        required this.order,
        required this.id,
        required this.uploadedAt,
    });

    factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        url: json["url"],
        caption: json["caption"],
        isPrimary: json["isPrimary"],
        order: json["order"],
        id: json["_id"],
        uploadedAt: DateTime.parse(json["uploadedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "caption": caption,
        "isPrimary": isPrimary,
        "order": order,
        "_id": id,
        "uploadedAt": uploadedAt.toIso8601String(),
    };
}

class Policies {
    String supervisionRequirement;
    String ageRestrictions;
    String weatherPolicy;
    String damagePolicy;
    String lateReturnPolicy;
    String additionalTerms;

    Policies({
        required this.supervisionRequirement,
        required this.ageRestrictions,
        required this.weatherPolicy,
        required this.damagePolicy,
        required this.lateReturnPolicy,
        required this.additionalTerms,
    });

    factory Policies.fromJson(Map<String, dynamic> json) => Policies(
        supervisionRequirement: json["supervisionRequirement"],
        ageRestrictions: json["ageRestrictions"],
        weatherPolicy: json["weatherPolicy"],
        damagePolicy: json["damagePolicy"],
        lateReturnPolicy: json["lateReturnPolicy"],
        additionalTerms: json["additionalTerms"],
    );

    Map<String, dynamic> toJson() => {
        "supervisionRequirement": supervisionRequirement,
        "ageRestrictions": ageRestrictions,
        "weatherPolicy": weatherPolicy,
        "damagePolicy": damagePolicy,
        "lateReturnPolicy": lateReturnPolicy,
        "additionalTerms": additionalTerms,
    };
}

class Pricing {
    int? hourlyRate;
    int? halfDayRate;
    int? fullDayRate;
    List<PackageDeal>? fixedPackages;
    int? dailyRate;
    int? minimumBookingDuration;
    String? fuelPolicy;
    List<dynamic>? paymentMethods;
    String? cancellationPolicy;
    bool? depositRequired;
    bool? vatRegistered;
    int? perMileRate;
    int? fuelSurcharge;
    int? waitingTimeCharge;
    int? overtimeCharge;
    int? weekendRate;
    int? depositAmount;
    String? depositType;
    String? vatNumber;
    int? basePrice;
    String? currency;
    int? weekendSurcharge;
    int? securityDeposit;
    int? cleaningFee;
    int? deliveryFee;
    int? setupFee;
    RefundPolicy? refundPolicy;

    Pricing({
        this.hourlyRate,
        this.halfDayRate,
        this.fullDayRate,
        this.fixedPackages,
        this.dailyRate,
        this.minimumBookingDuration,
        this.fuelPolicy,
        this.paymentMethods,
        this.cancellationPolicy,
        this.depositRequired,
        this.vatRegistered,
        this.perMileRate,
        this.fuelSurcharge,
        this.waitingTimeCharge,
        this.overtimeCharge,
        this.weekendRate,
        this.depositAmount,
        this.depositType,
        this.vatNumber,
        this.basePrice,
        this.currency,
        this.weekendSurcharge,
        this.securityDeposit,
        this.cleaningFee,
        this.deliveryFee,
        this.setupFee,
        this.refundPolicy,
    });

    factory Pricing.fromJson(Map<String, dynamic> json) => Pricing(
        hourlyRate: json["hourlyRate"],
        halfDayRate: json["halfDayRate"],
        fullDayRate: json["fullDayRate"],
        fixedPackages: json["fixedPackages"] == null ? [] : List<PackageDeal>.from(json["fixedPackages"]!.map((x) => PackageDeal.fromJson(x))),
        dailyRate: json["dailyRate"],
        minimumBookingDuration: json["minimumBookingDuration"],
        fuelPolicy: json["fuelPolicy"],
        paymentMethods: json["paymentMethods"] == null ? [] : List<dynamic>.from(json["paymentMethods"]!.map((x) => x)),
        cancellationPolicy: json["cancellationPolicy"],
        depositRequired: json["depositRequired"],
        vatRegistered: json["vatRegistered"],
        perMileRate: json["perMileRate"],
        fuelSurcharge: json["fuelSurcharge"],
        waitingTimeCharge: json["waitingTimeCharge"],
        overtimeCharge: json["overtimeCharge"],
        weekendRate: json["weekendRate"],
        depositAmount: json["depositAmount"],
        depositType: json["depositType"],
        vatNumber: json["vatNumber"],
        basePrice: json["basePrice"],
        currency: json["currency"],
        weekendSurcharge: json["weekendSurcharge"],
        securityDeposit: json["securityDeposit"],
        cleaningFee: json["cleaningFee"],
        deliveryFee: json["deliveryFee"],
        setupFee: json["setupFee"],
        refundPolicy: json["refundPolicy"] == null ? null : RefundPolicy.fromJson(json["refundPolicy"]),
    );

    Map<String, dynamic> toJson() => {
        "hourlyRate": hourlyRate,
        "halfDayRate": halfDayRate,
        "fullDayRate": fullDayRate,
        "fixedPackages": fixedPackages == null ? [] : List<dynamic>.from(fixedPackages!.map((x) => x.toJson())),
        "dailyRate": dailyRate,
        "minimumBookingDuration": minimumBookingDuration,
        "fuelPolicy": fuelPolicy,
        "paymentMethods": paymentMethods == null ? [] : List<dynamic>.from(paymentMethods!.map((x) => x)),
        "cancellationPolicy": cancellationPolicy,
        "depositRequired": depositRequired,
        "vatRegistered": vatRegistered,
        "perMileRate": perMileRate,
        "fuelSurcharge": fuelSurcharge,
        "waitingTimeCharge": waitingTimeCharge,
        "overtimeCharge": overtimeCharge,
        "weekendRate": weekendRate,
        "depositAmount": depositAmount,
        "depositType": depositType,
        "vatNumber": vatNumber,
        "basePrice": basePrice,
        "currency": currency,
        "weekendSurcharge": weekendSurcharge,
        "securityDeposit": securityDeposit,
        "cleaningFee": cleaningFee,
        "deliveryFee": deliveryFee,
        "setupFee": setupFee,
        "refundPolicy": refundPolicy?.toJson(),
    };
}

class RefundPolicy {
    int fullRefundDays;
    int partialRefundDays;
    int noRefundDays;

    RefundPolicy({
        required this.fullRefundDays,
        required this.partialRefundDays,
        required this.noRefundDays,
    });

    factory RefundPolicy.fromJson(Map<String, dynamic> json) => RefundPolicy(
        fullRefundDays: json["fullRefundDays"],
        partialRefundDays: json["partialRefundDays"],
        noRefundDays: json["noRefundDays"],
    );

    Map<String, dynamic> toJson() => {
        "fullRefundDays": fullRefundDays,
        "partialRefundDays": partialRefundDays,
        "noRefundDays": noRefundDays,
    };
}

class PricingDetails {
    int? dayRate;
    int mileageLimit;
    int? extraMileageCharge;
    int hourlyRate;
    double halfDayRate;
    int? fullDayRate;
    int? additionalMileageFee;

    PricingDetails({
        this.dayRate,
        required this.mileageLimit,
        this.extraMileageCharge,
        required this.hourlyRate,
        required this.halfDayRate,
        this.fullDayRate,
        this.additionalMileageFee,
    });

    factory PricingDetails.fromJson(Map<String, dynamic> json) => PricingDetails(
        dayRate: json["dayRate"],
        mileageLimit: json["mileageLimit"],
        extraMileageCharge: json["extraMileageCharge"],
        hourlyRate: json["hourlyRate"],
        halfDayRate: json["halfDayRate"]?.toDouble(),
        fullDayRate: json["fullDayRate"],
        additionalMileageFee: json["additionalMileageFee"],
    );

    Map<String, dynamic> toJson() => {
        "dayRate": dayRate,
        "mileageLimit": mileageLimit,
        "extraMileageCharge": extraMileageCharge,
        "hourlyRate": hourlyRate,
        "halfDayRate": halfDayRate,
        "fullDayRate": fullDayRate,
        "additionalMileageFee": additionalMileageFee,
    };
}

class SafetyCertification {
    bool bsEn14960Compliant;
    String certificationNumber;
    String certificationBody;
    bool pipaRpiiCertified;
    String pipaRpiiNumber;
    PublicLiabilityInsurance publicLiabilityInsurance;
    DateTime patTestingDate;
    String safetyInstructions;

    SafetyCertification({
        required this.bsEn14960Compliant,
        required this.certificationNumber,
        required this.certificationBody,
        required this.pipaRpiiCertified,
        required this.pipaRpiiNumber,
        required this.publicLiabilityInsurance,
        required this.patTestingDate,
        required this.safetyInstructions,
    });

    factory SafetyCertification.fromJson(Map<String, dynamic> json) => SafetyCertification(
        bsEn14960Compliant: json["bsEn14960Compliant"],
        certificationNumber: json["certificationNumber"],
        certificationBody: json["certificationBody"],
        pipaRpiiCertified: json["pipaRpiiCertified"],
        pipaRpiiNumber: json["pipaRpiiNumber"],
        publicLiabilityInsurance: PublicLiabilityInsurance.fromJson(json["publicLiabilityInsurance"]),
        patTestingDate: DateTime.parse(json["patTestingDate"]),
        safetyInstructions: json["safetyInstructions"],
    );

    Map<String, dynamic> toJson() => {
        "bsEn14960Compliant": bsEn14960Compliant,
        "certificationNumber": certificationNumber,
        "certificationBody": certificationBody,
        "pipaRpiiCertified": pipaRpiiCertified,
        "pipaRpiiNumber": pipaRpiiNumber,
        "publicLiabilityInsurance": publicLiabilityInsurance.toJson(),
        "patTestingDate": patTestingDate.toIso8601String(),
        "safetyInstructions": safetyInstructions,
    };
}

class PublicLiabilityInsurance {
    String provider;
    String policyNumber;
    int coverageAmount;
    DateTime expiryDate;
    Document document;

    PublicLiabilityInsurance({
        required this.provider,
        required this.policyNumber,
        required this.coverageAmount,
        required this.expiryDate,
        required this.document,
    });

    factory PublicLiabilityInsurance.fromJson(Map<String, dynamic> json) => PublicLiabilityInsurance(
        provider: json["provider"],
        policyNumber: json["policyNumber"],
        coverageAmount: json["coverageAmount"],
        expiryDate: DateTime.parse(json["expiryDate"]),
        document: Document.fromJson(json["document"]),
    );

    Map<String, dynamic> toJson() => {
        "provider": provider,
        "policyNumber": policyNumber,
        "coverageAmount": coverageAmount,
        "expiryDate": expiryDate.toIso8601String(),
        "document": document.toJson(),
    };
}

class Document {
    String type;
    String name;
    String url;
    DateTime uploadedAt;
    bool isVerified;

    Document({
        required this.type,
        required this.name,
        required this.url,
        required this.uploadedAt,
        required this.isVerified,
    });

    factory Document.fromJson(Map<String, dynamic> json) => Document(
        type: json["type"],
        name: json["name"],
        url: json["url"],
        uploadedAt: DateTime.parse(json["uploadedAt"]),
        isVerified: json["isVerified"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "url": url,
        "uploadedAt": uploadedAt.toIso8601String(),
        "isVerified": isVerified,
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

class Services {
    List<String> serviceTypes;
    String serviceDetails;
    TemperatureRange temperatureRange;
    bool? temperatureMonitoring;
    List<dynamic> machineryEquipment;
    List<String> loadingUnloadingAssistance;
    bool highValueCargoInsurance;
    int maxInsuranceCoverage;
    String insuranceProvider;
    int standardLiabilityCoverage;
    String? otherServices;
    int? maxLoadWeight;
    bool? escortVehicleAvailable;
    bool? abnormalLoadPermits;
    int? loadingAssistanceCharge;

    Services({
        required this.serviceTypes,
        required this.serviceDetails,
        required this.temperatureRange,
        this.temperatureMonitoring,
        required this.machineryEquipment,
        required this.loadingUnloadingAssistance,
        required this.highValueCargoInsurance,
        required this.maxInsuranceCoverage,
        required this.insuranceProvider,
        required this.standardLiabilityCoverage,
        this.otherServices,
        this.maxLoadWeight,
        this.escortVehicleAvailable,
        this.abnormalLoadPermits,
        this.loadingAssistanceCharge,
    });

    factory Services.fromJson(Map<String, dynamic> json) => Services(
        serviceTypes: List<String>.from(json["serviceTypes"].map((x) => x)),
        serviceDetails: json["serviceDetails"],
        temperatureRange: TemperatureRange.fromJson(json["temperatureRange"]),
        temperatureMonitoring: json["temperatureMonitoring"],
        machineryEquipment: List<dynamic>.from(json["machineryEquipment"].map((x) => x)),
        loadingUnloadingAssistance: List<String>.from(json["loadingUnloadingAssistance"].map((x) => x)),
        highValueCargoInsurance: json["highValueCargoInsurance"],
        maxInsuranceCoverage: json["maxInsuranceCoverage"],
        insuranceProvider: json["insuranceProvider"],
        standardLiabilityCoverage: json["standardLiabilityCoverage"],
        otherServices: json["otherServices"],
        maxLoadWeight: json["maxLoadWeight"],
        escortVehicleAvailable: json["escortVehicleAvailable"],
        abnormalLoadPermits: json["abnormalLoadPermits"],
        loadingAssistanceCharge: json["loadingAssistanceCharge"],
    );

    Map<String, dynamic> toJson() => {
        "serviceTypes": List<dynamic>.from(serviceTypes.map((x) => x)),
        "serviceDetails": serviceDetails,
        "temperatureRange": temperatureRange.toJson(),
        "temperatureMonitoring": temperatureMonitoring,
        "machineryEquipment": List<dynamic>.from(machineryEquipment.map((x) => x)),
        "loadingUnloadingAssistance": List<dynamic>.from(loadingUnloadingAssistance.map((x) => x)),
        "highValueCargoInsurance": highValueCargoInsurance,
        "maxInsuranceCoverage": maxInsuranceCoverage,
        "insuranceProvider": insuranceProvider,
        "standardLiabilityCoverage": standardLiabilityCoverage,
        "otherServices": otherServices,
        "maxLoadWeight": maxLoadWeight,
        "escortVehicleAvailable": escortVehicleAvailable,
        "abnormalLoadPermits": abnormalLoadPermits,
        "loadingAssistanceCharge": loadingAssistanceCharge,
    };
}

class TemperatureRange {
    int min;
    int max;

    TemperatureRange({
        required this.min,
        required this.max,
    });

    factory TemperatureRange.fromJson(Map<String, dynamic> json) => TemperatureRange(
        min: json["min"],
        max: json["max"],
    );

    Map<String, dynamic> toJson() => {
        "min": min,
        "max": max,
    };
}

class SetupRequirements {
    bool powerRequired;
    int powerVoltage;
    bool waterSupplyRequired;
    String weatherRestrictions;
    bool indoorSuitable;
    bool outdoorSuitable;
    int setupTimeMinutes;
    int takedownTimeMinutes;
    String accessRequirements;
    List<String> groundRequirements;
    String anchoringMethod;

    SetupRequirements({
        required this.powerRequired,
        required this.powerVoltage,
        required this.waterSupplyRequired,
        required this.weatherRestrictions,
        required this.indoorSuitable,
        required this.outdoorSuitable,
        required this.setupTimeMinutes,
        required this.takedownTimeMinutes,
        required this.accessRequirements,
        required this.groundRequirements,
        required this.anchoringMethod,
    });

    factory SetupRequirements.fromJson(Map<String, dynamic> json) => SetupRequirements(
        powerRequired: json["powerRequired"],
        powerVoltage: json["powerVoltage"],
        waterSupplyRequired: json["waterSupplyRequired"],
        weatherRestrictions: json["weatherRestrictions"],
        indoorSuitable: json["indoorSuitable"],
        outdoorSuitable: json["outdoorSuitable"],
        setupTimeMinutes: json["setupTimeMinutes"],
        takedownTimeMinutes: json["takedownTimeMinutes"],
        accessRequirements: json["accessRequirements"],
        groundRequirements: List<String>.from(json["groundRequirements"].map((x) => x)),
        anchoringMethod: json["anchoringMethod"],
    );

    Map<String, dynamic> toJson() => {
        "powerRequired": powerRequired,
        "powerVoltage": powerVoltage,
        "waterSupplyRequired": waterSupplyRequired,
        "weatherRestrictions": weatherRestrictions,
        "indoorSuitable": indoorSuitable,
        "outdoorSuitable": outdoorSuitable,
        "setupTimeMinutes": setupTimeMinutes,
        "takedownTimeMinutes": takedownTimeMinutes,
        "accessRequirements": accessRequirements,
        "groundRequirements": List<dynamic>.from(groundRequirements.map((x) => x)),
        "anchoringMethod": anchoringMethod,
    };
}

class SpecialPriceDay {
    DateTime date;
    int price;

    SpecialPriceDay({
        required this.date,
        required this.price,
    });

    factory SpecialPriceDay.fromJson(Map<String, dynamic> json) => SpecialPriceDay(
        date: DateTime.parse(json["date"]),
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "price": price,
    };
}

class Stats {
    int totalViews;
    int uniqueViews;
    int bookingRequests;
    int confirmedBookings;
    int totalRevenue;
    int averageRating;
    int reviewCount;

    Stats({
        required this.totalViews,
        required this.uniqueViews,
        required this.bookingRequests,
        required this.confirmedBookings,
        required this.totalRevenue,
        required this.averageRating,
        required this.reviewCount,
    });

    factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        totalViews: json["totalViews"],
        uniqueViews: json["uniqueViews"],
        bookingRequests: json["bookingRequests"],
        confirmedBookings: json["confirmedBookings"],
        totalRevenue: json["totalRevenue"],
        averageRating: json["averageRating"],
        reviewCount: json["reviewCount"],
    );

    Map<String, dynamic> toJson() => {
        "totalViews": totalViews,
        "uniqueViews": uniqueViews,
        "bookingRequests": bookingRequests,
        "confirmedBookings": confirmedBookings,
        "totalRevenue": totalRevenue,
        "averageRating": averageRating,
        "reviewCount": reviewCount,
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

class VendorId {
    String id;
    String? companyName;
    GeoLocation geoLocation;
    Membership membership;
    int visibilityScore;
    VisibilitySettings visibilitySettings;

    VendorId({
        required this.id,
        this.companyName,
        required this.geoLocation,
        required this.membership,
        required this.visibilityScore,
        required this.visibilitySettings,
    });

    factory VendorId.fromJson(Map<String, dynamic> json) => VendorId(
        id: json["_id"],
        companyName: json["company_name"],
        geoLocation: GeoLocation.fromJson(json["geo_location"]),
        membership: Membership.fromJson(json["membership"]),
        visibilityScore: json["visibility_score"],
        visibilitySettings: VisibilitySettings.fromJson(json["visibility_settings"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "company_name": companyName,
        "geo_location": geoLocation.toJson(),
        "membership": membership.toJson(),
        "visibility_score": visibilityScore,
        "visibility_settings": visibilitySettings.toJson(),
    };
}

class GeoLocation {
    List<dynamic> coordinates;

    GeoLocation({
        required this.coordinates,
    });

    factory GeoLocation.fromJson(Map<String, dynamic> json) => GeoLocation(
        coordinates: List<dynamic>.from(json["coordinates"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
    };
}

class Membership {
    AddOns addOns;
    BannerSlots bannerSlots;
    int tierLevel;
    MembershipTier tierName;
    SubscriptionStatus subscriptionStatus;
    int chatCountMonthly;
    int chatLimit;
    DateTime lastChatReset;

    Membership({
        required this.addOns,
        required this.bannerSlots,
        required this.tierLevel,
        required this.tierName,
        required this.subscriptionStatus,
        required this.chatCountMonthly,
        required this.chatLimit,
        required this.lastChatReset,
    });

    factory Membership.fromJson(Map<String, dynamic> json) => Membership(
        addOns: AddOns.fromJson(json["add_ons"]),
        bannerSlots: BannerSlots.fromJson(json["banner_slots"]),
        tierLevel: json["tier_level"],
        tierName: membershipTierValues.map[json["tier_name"]]!,
        subscriptionStatus: subscriptionStatusValues.map[json["subscription_status"]]!,
        chatCountMonthly: json["chat_count_monthly"],
        chatLimit: json["chat_limit"],
        lastChatReset: DateTime.parse(json["last_chat_reset"]),
    );

    Map<String, dynamic> toJson() => {
        "add_ons": addOns.toJson(),
        "banner_slots": bannerSlots.toJson(),
        "tier_level": tierLevel,
        "tier_name": membershipTierValues.reverse[tierName],
        "subscription_status": subscriptionStatusValues.reverse[subscriptionStatus],
        "chat_count_monthly": chatCountMonthly,
        "chat_limit": chatLimit,
        "last_chat_reset": lastChatReset.toIso8601String(),
    };
}

class AddOns {
    bool homepageBanner;
    bool competitorListing;
    bool socialMediaBoost;
    bool verifiedReviewCampaign;
    bool premiumSupport;

    AddOns({
        required this.homepageBanner,
        required this.competitorListing,
        required this.socialMediaBoost,
        required this.verifiedReviewCampaign,
        required this.premiumSupport,
    });

    factory AddOns.fromJson(Map<String, dynamic> json) => AddOns(
        homepageBanner: json["homepage_banner"],
        competitorListing: json["competitor_listing"],
        socialMediaBoost: json["social_media_boost"],
        verifiedReviewCampaign: json["verified_review_campaign"],
        premiumSupport: json["premium_support"],
    );

    Map<String, dynamic> toJson() => {
        "homepage_banner": homepageBanner,
        "competitor_listing": competitorListing,
        "social_media_boost": socialMediaBoost,
        "verified_review_campaign": verifiedReviewCampaign,
        "premium_support": premiumSupport,
    };
}

class BannerSlots {
    CompetitorListing homepageBanner;
    CompetitorListing competitorListing;
    CompetitorListing socialMediaBoost;
    CompetitorListing verifiedReviewCampaign;

    BannerSlots({
        required this.homepageBanner,
        required this.competitorListing,
        required this.socialMediaBoost,
        required this.verifiedReviewCampaign,
    });

    factory BannerSlots.fromJson(Map<String, dynamic> json) => BannerSlots(
        homepageBanner: CompetitorListing.fromJson(json["homepage_banner"]),
        competitorListing: CompetitorListing.fromJson(json["competitor_listing"]),
        socialMediaBoost: CompetitorListing.fromJson(json["social_media_boost"]),
        verifiedReviewCampaign: CompetitorListing.fromJson(json["verified_review_campaign"]),
    );

    Map<String, dynamic> toJson() => {
        "homepage_banner": homepageBanner.toJson(),
        "competitor_listing": competitorListing.toJson(),
        "social_media_boost": socialMediaBoost.toJson(),
        "verified_review_campaign": verifiedReviewCampaign.toJson(),
    };
}

class CompetitorListing {
    bool purchased;
    int used;
    int available;
    dynamic expiresAt;

    CompetitorListing({
        required this.purchased,
        required this.used,
        required this.available,
        required this.expiresAt,
    });

    factory CompetitorListing.fromJson(Map<String, dynamic> json) => CompetitorListing(
        purchased: json["purchased"],
        used: json["used"],
        available: json["available"],
        expiresAt: json["expires_at"],
    );

    Map<String, dynamic> toJson() => {
        "purchased": purchased,
        "used": used,
        "available": available,
        "expires_at": expiresAt,
    };
}

enum SubscriptionStatus {
    NONE
}

final subscriptionStatusValues = EnumValues({
    "none": SubscriptionStatus.NONE
});

class VisibilitySettings {
    List<dynamic> serviceAreas;
    SubscriptionStatus scope;
    int serviceRadiusKm;

    VisibilitySettings({
        required this.serviceAreas,
        required this.scope,
        required this.serviceRadiusKm,
    });

    factory VisibilitySettings.fromJson(Map<String, dynamic> json) => VisibilitySettings(
        serviceAreas: List<dynamic>.from(json["service_areas"].map((x) => x)),
        scope: subscriptionStatusValues.map[json["scope"]]!,
        serviceRadiusKm: json["service_radius_km"],
    );

    Map<String, dynamic> toJson() => {
        "service_areas": List<dynamic>.from(serviceAreas.map((x) => x)),
        "scope": subscriptionStatusValues.reverse[scope],
        "service_radius_km": serviceRadiusKm,
    };
}

enum VisibilityScope {
    LISTED
}

final visibilityScopeValues = EnumValues({
    "Listed": VisibilityScope.LISTED
});

class Pagination {
    int total;
    int page;
    int limit;
    int offset;
    bool hasMore;
    dynamic nextOffset;

    Pagination({
        required this.total,
        required this.page,
        required this.limit,
        required this.offset,
        required this.hasMore,
        required this.nextOffset,
    });

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        page: json["page"],
        limit: json["limit"],
        offset: json["offset"],
        hasMore: json["hasMore"],
        nextOffset: json["nextOffset"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "page": page,
        "limit": limit,
        "offset": offset,
        "hasMore": hasMore,
        "nextOffset": nextOffset,
    };
}

class ResolvedFilters {
    dynamic categoryName;
    dynamic subCategoryName;
    dynamic resolvedCategoryId;
    dynamic resolvedSubCategoryId;

    ResolvedFilters({
        required this.categoryName,
        required this.subCategoryName,
        required this.resolvedCategoryId,
        required this.resolvedSubCategoryId,
    });

    factory ResolvedFilters.fromJson(Map<String, dynamic> json) => ResolvedFilters(
        categoryName: json["categoryName"],
        subCategoryName: json["subCategoryName"],
        resolvedCategoryId: json["resolvedCategoryId"],
        resolvedSubCategoryId: json["resolvedSubCategoryId"],
    );

    Map<String, dynamic> toJson() => {
        "categoryName": categoryName,
        "subCategoryName": subCategoryName,
        "resolvedCategoryId": resolvedCategoryId,
        "resolvedSubCategoryId": resolvedSubCategoryId,
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
