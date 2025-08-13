// // To parse this JSON data, do
// //
// //     final services = servicesFromJson(jsonString);

// import 'dart:convert';

// Services servicesFromJson(String str) => Services.fromJson(json.decode(str));

// String servicesToJson(Services data) => json.encode(data.toJson());

// class Services {
//     bool success;
//     String message;
//     Data data;
//     bool fromCache;
//     String processingTime;

//     Services({
//         required this.success,
//         required this.message,
//         required this.data,
//         required this.fromCache,
//         required this.processingTime,
//     });

//     factory Services.fromJson(Map<String, dynamic> json) => Services(
//         success: json["success"],
//         message: json["message"],
//         data: Data.fromJson(json["data"]),
//         fromCache: json["fromCache"],
//         processingTime: json["processingTime"],
//     );

//     Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "data": data.toJson(),
//         "fromCache": fromCache,
//         "processingTime": processingTime,
//     };
// }

// class Data {
//     List<Service> services;
//     int totalServices;
//     ServiceStats serviceStats;
//     String vendorId;

//     Data({
//         required this.services,
//         required this.totalServices,
//         required this.serviceStats,
//         required this.vendorId,
//     });

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
//         totalServices: json["totalServices"],
//         serviceStats: ServiceStats.fromJson(json["serviceStats"]),
//         vendorId: json["vendorId"],
//     );

//     Map<String, dynamic> toJson() => {
//         "services": List<dynamic>.from(services.map((x) => x.toJson())),
//         "totalServices": totalServices,
//         "serviceStats": serviceStats.toJson(),
//         "vendorId": vendorId,
//     };
// }

// class ServiceStats {
//     int passengerTransport;

//     ServiceStats({
//         required this.passengerTransport,
//     });

//     factory ServiceStats.fromJson(Map<String, dynamic> json) => ServiceStats(
//         passengerTransport: json["Passenger Transport"],
//     );

//     Map<String, dynamic> toJson() => {
//         "Passenger Transport": passengerTransport,
//     };
// }

// class Service {
//     String id;
//     CategoryId categoryId;
//     SubcategoryId subcategoryId;
//     String? vendorId;
//     String? serviceBookingDateFrom;
//     String? serviceBookingDateTo;
//     List<SpecialPriceDay>? serviceSpecialPriceDays;
//     int? offeringPrice;
//     String? listingTitle;
//     String? basePostcode;
//     int? locationRadius;
//     List<String>? areasCovered;
//     FleetInfo? fleetInfo;
//     MiniBusRates? miniBusRates;
//     List<String>? serviceImage;
//     CancellationPolicyType? cancellationPolicyType;
//     String serviceStatus;
//     dynamic serviceApproveStatus;
//     List<Coupon>? coupons;
//     DateTime createdAt;
//     DateTime? updatedAt;
//     int? v;
//     String serviceType;
//     String? makeAndModel;
//     DateTime? firstRegistered;
//     Features? features;
//     FeaturePricing? featurePricing;
//     int? fullDayRate;
//     int? hourlyRate;
//     int? halfDayRate;
//     int? mileageCapLimit;
//     double? mileageCapExcessCharge;
//     List<String>? images;
//     DateTime? bookingDateFrom;
//     DateTime? bookingDateTo;
//     List<SpecialPriceDay>? specialPriceDays;
//     String? serviceName;
//     String? emergencyContactNumber;
//     PricingDetails? pricingDetails;
//     List<AccessibilityAndSpecialService>? accessibilityAndSpecialServices;
//     FuneralPackageOptions? funeralPackageOptions;
//     DateTime? bookingAvailabilityDateFrom;
//     DateTime? bookingAvailabilityDateTo;
//     FleetDetails? fleetDetails;
//     DriverDetail? driverDetail;
//     ServiceDetail? serviceDetail;
//     LicensingDetails? licensingDetails;
//     InsuranceDetails? insuranceDetails;
//     UploadedDocuments? uploadedDocuments;
//     List<String>? serviceImages;
//     BusinessProfile? businessProfile;
//     String? approvalStatus;
//     ServiceComfort? comfort;
//     Events? events;
//     Accessibility? accessibility;
//     Security? security;
//     ServiceDocuments? documents;
//     VehicleDetails? vehicleDetails;
//     EquipmentSafety? equipmentSafety;
//     Marketing? marketing;
//     List<String>? serviceAreas;
//     Pricing? pricing;
//     List<String>? eventsExtras;
//     List<String>? accessibilityServices;
//     AvailabilityPeriod? availabilityPeriod;
//     String? baseLocationPostcode;
//     Licensing? licensing;
//     String? serviceHighlights;
//     Documentation? documentation;
//     String? boatType;
//     BoatRates? boatRates;
//     List<String>? navigableRoutes;
//     ServicesOffered? servicesOffered;
//     OperatingHours? operatingHours;
//     int? radiusCovered;
//     BookingTypes? bookingTypes;
//     int? availableMinibuses;
//     bool? seatBeltsInAllVehicles;
//     String? foodDrinksAllowed;
//     DriverInformation? driverInformation;
//     String? uniqueFeatures;

//     Service({
//         required this.id,
//         required this.categoryId,
//         required this.subcategoryId,
//         this.vendorId,
//         this.serviceBookingDateFrom,
//         this.serviceBookingDateTo,
//         this.serviceSpecialPriceDays,
//         this.offeringPrice,
//         this.listingTitle,
//         this.basePostcode,
//         this.locationRadius,
//         this.areasCovered,
//         this.fleetInfo,
//         this.miniBusRates,
//         this.serviceImage,
//         this.cancellationPolicyType,
//         required this.serviceStatus,
//         this.serviceApproveStatus,
//         this.coupons,
//         required this.createdAt,
//         this.updatedAt,
//         this.v,
//         required this.serviceType,
//         this.makeAndModel,
//         this.firstRegistered,
//         this.features,
//         this.featurePricing,
//         this.fullDayRate,
//         this.hourlyRate,
//         this.halfDayRate,
//         this.mileageCapLimit,
//         this.mileageCapExcessCharge,
//         this.images,
//         this.bookingDateFrom,
//         this.bookingDateTo,
//         this.specialPriceDays,
//         this.serviceName,
//         this.emergencyContactNumber,
//         this.pricingDetails,
//         this.accessibilityAndSpecialServices,
//         this.funeralPackageOptions,
//         this.bookingAvailabilityDateFrom,
//         this.bookingAvailabilityDateTo,
//         this.fleetDetails,
//         this.driverDetail,
//         this.serviceDetail,
//         this.licensingDetails,
//         this.insuranceDetails,
//         this.uploadedDocuments,
//         this.serviceImages,
//         this.businessProfile,
//         this.approvalStatus,
//         this.comfort,
//         this.events,
//         this.accessibility,
//         this.security,
//         this.documents,
//         this.vehicleDetails,
//         this.equipmentSafety,
//         this.marketing,
//         this.serviceAreas,
//         this.pricing,
//         this.eventsExtras,
//         this.accessibilityServices,
//         this.availabilityPeriod,
//         this.baseLocationPostcode,
//         this.licensing,
//         this.serviceHighlights,
//         this.documentation,
//         this.boatType,
//         this.boatRates,
//         this.navigableRoutes,
//         this.servicesOffered,
//         this.operatingHours,
//         this.radiusCovered,
//         this.bookingTypes,
//         this.availableMinibuses,
//         this.seatBeltsInAllVehicles,
//         this.foodDrinksAllowed,
//         this.driverInformation,
//         this.uniqueFeatures,
//     });

//     factory Service.fromJson(Map<String, dynamic> json) => Service(
//         id: json["_id"],
//         categoryId: CategoryId.fromJson(json["categoryId"]),
//         subcategoryId: SubcategoryId.fromJson(json["subcategoryId"]),
//         vendorId: json["vendorId"],
//         serviceBookingDateFrom: json["booking_date_from"],
//         serviceBookingDateTo: json["booking_date_to"],
//         serviceSpecialPriceDays: json["special_price_days"] == null ? [] : List<SpecialPriceDay>.from(json["special_price_days"]!.map((x) => SpecialPriceDay.fromJson(x))),
//         offeringPrice: json["offering_price"],
//         listingTitle: json["listingTitle"],
//         basePostcode: json["basePostcode"],
//         locationRadius: json["locationRadius"],
//         areasCovered: json["areasCovered"] == null ? [] : List<String>.from(json["areasCovered"]!.map((x) => x)),
//         fleetInfo: json["fleetInfo"] == null ? null : FleetInfo.fromJson(json["fleetInfo"]),
//         miniBusRates: json["miniBusRates"] == null ? null : MiniBusRates.fromJson(json["miniBusRates"]),
//         serviceImage: json["service_image"] == null ? [] : List<String>.from(json["service_image"]!.map((x) => x)),
//         cancellationPolicyType: cancellationPolicyTypeValues.map[json["cancellation_policy_type"]]!,
//         serviceStatus: json["service_status"],
//         serviceApproveStatus: json["service_approve_status"],
//         coupons: json["coupons"] == null ? [] : List<Coupon>.from(json["coupons"]!.map((x) => Coupon.fromJson(x))),
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//         serviceType: json["serviceType"],
//         makeAndModel: json["makeAndModel"],
//         firstRegistered: json["firstRegistered"] == null ? null : DateTime.parse(json["firstRegistered"]),
//         features: json["features"] == null ? null : Features.fromJson(json["features"]),
//         featurePricing: json["featurePricing"] == null ? null : FeaturePricing.fromJson(json["featurePricing"]),
//         fullDayRate: json["fullDayRate"],
//         hourlyRate: json["hourlyRate"],
//         halfDayRate: json["halfDayRate"],
//         mileageCapLimit: json["mileageCapLimit"],
//         mileageCapExcessCharge: json["mileageCapExcessCharge"]?.toDouble(),
//         images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
//         bookingDateFrom: json["bookingDateFrom"] == null ? null : DateTime.parse(json["bookingDateFrom"]),
//         bookingDateTo: json["bookingDateTo"] == null ? null : DateTime.parse(json["bookingDateTo"]),
//         specialPriceDays: json["specialPriceDays"] == null ? [] : List<SpecialPriceDay>.from(json["specialPriceDays"]!.map((x) => SpecialPriceDay.fromJson(x))),
//         serviceName: json["service_name"],
//         emergencyContactNumber: json["emergencyContactNumber"],
//         pricingDetails: json["pricingDetails"] == null ? null : PricingDetails.fromJson(json["pricingDetails"]),
//         accessibilityAndSpecialServices: json["accessibilityAndSpecialServices"] == null ? [] : List<AccessibilityAndSpecialService>.from(json["accessibilityAndSpecialServices"]!.map((x) => AccessibilityAndSpecialService.fromJson(x))),
//         funeralPackageOptions: json["funeralPackageOptions"] == null ? null : FuneralPackageOptions.fromJson(json["funeralPackageOptions"]),
//         bookingAvailabilityDateFrom: json["booking_availability_date_from"] == null ? null : DateTime.parse(json["booking_availability_date_from"]),
//         bookingAvailabilityDateTo: json["booking_availability_date_to"] == null ? null : DateTime.parse(json["booking_availability_date_to"]),
//         fleetDetails: json["fleetDetails"] == null ? null : FleetDetails.fromJson(json["fleetDetails"]),
//         driverDetail: json["driver_detail"] == null ? null : DriverDetail.fromJson(json["driver_detail"]),
//         serviceDetail: json["service_detail"] == null ? null : ServiceDetail.fromJson(json["service_detail"]),
//         licensingDetails: json["licensingDetails"] == null ? null : LicensingDetails.fromJson(json["licensingDetails"]),
//         insuranceDetails: json["insuranceDetails"] == null ? null : InsuranceDetails.fromJson(json["insuranceDetails"]),
//         uploadedDocuments: json["uploaded_Documents"] == null ? null : UploadedDocuments.fromJson(json["uploaded_Documents"]),
//         serviceImages: json["serviceImages"] == null ? [] : List<String>.from(json["serviceImages"]!.map((x) => x)),
//         businessProfile: json["businessProfile"] == null ? null : BusinessProfile.fromJson(json["businessProfile"]),
//         approvalStatus: json["approvalStatus"],
//         comfort: json["comfort"] == null ? null : ServiceComfort.fromJson(json["comfort"]),
//         events: json["events"] == null ? null : Events.fromJson(json["events"]),
//         accessibility: json["accessibility"] == null ? null : Accessibility.fromJson(json["accessibility"]),
//         security: json["security"] == null ? null : Security.fromJson(json["security"]),
//         documents: json["documents"] == null ? null : ServiceDocuments.fromJson(json["documents"]),
//         vehicleDetails: json["vehicleDetails"] == null ? null : VehicleDetails.fromJson(json["vehicleDetails"]),
//         equipmentSafety: json["equipmentSafety"] == null ? null : EquipmentSafety.fromJson(json["equipmentSafety"]),
//         marketing: json["marketing"] == null ? null : Marketing.fromJson(json["marketing"]),
//         serviceAreas: json["serviceAreas"] == null ? [] : List<String>.from(json["serviceAreas"]!.map((x) => x)),
//         pricing: json["pricing"] == null ? null : Pricing.fromJson(json["pricing"]),
//         eventsExtras: json["eventsExtras"] == null ? [] : List<String>.from(json["eventsExtras"]!.map((x) => x)),
//         accessibilityServices: json["accessibilityServices"] == null ? [] : List<String>.from(json["accessibilityServices"]!.map((x) => x)),
//         availabilityPeriod: json["availabilityPeriod"] == null ? null : AvailabilityPeriod.fromJson(json["availabilityPeriod"]),
//         baseLocationPostcode: json["baseLocationPostcode"],
//         licensing: json["licensing"] == null ? null : Licensing.fromJson(json["licensing"]),
//         serviceHighlights: json["serviceHighlights"],
//         documentation: json["documentation"] == null ? null : Documentation.fromJson(json["documentation"]),
//         boatType: json["boatType"],
//         boatRates: json["boatRates"] == null ? null : BoatRates.fromJson(json["boatRates"]),
//         navigableRoutes: json["navigableRoutes"] == null ? [] : List<String>.from(json["navigableRoutes"]!.map((x) => x)),
//         servicesOffered: json["servicesOffered"] == null ? null : ServicesOffered.fromJson(json["servicesOffered"]),
//         operatingHours: json["operatingHours"] == null ? null : OperatingHours.fromJson(json["operatingHours"]),
//         radiusCovered: json["radiusCovered"],
//         bookingTypes: json["bookingTypes"] == null ? null : BookingTypes.fromJson(json["bookingTypes"]),
//         availableMinibuses: json["availableMinibuses"],
//         seatBeltsInAllVehicles: json["seatBeltsInAllVehicles"],
//         foodDrinksAllowed: json["foodDrinksAllowed"],
//         driverInformation: json["driverInformation"] == null ? null : DriverInformation.fromJson(json["driverInformation"]),
//         uniqueFeatures: json["uniqueFeatures"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "categoryId": categoryId.toJson(),
//         "subcategoryId": subcategoryId.toJson(),
//         "vendorId": vendorId,
//         "booking_date_from": serviceBookingDateFrom,
//         "booking_date_to": serviceBookingDateTo,
//         "special_price_days": serviceSpecialPriceDays == null ? [] : List<dynamic>.from(serviceSpecialPriceDays!.map((x) => x.toJson())),
//         "offering_price": offeringPrice,
//         "listingTitle": listingTitle,
//         "basePostcode": basePostcode,
//         "locationRadius": locationRadius,
//         "areasCovered": areasCovered == null ? [] : List<dynamic>.from(areasCovered!.map((x) => x)),
//         "fleetInfo": fleetInfo?.toJson(),
//         "miniBusRates": miniBusRates?.toJson(),
//         "service_image": serviceImage == null ? [] : List<dynamic>.from(serviceImage!.map((x) => x)),
//         "cancellation_policy_type": cancellationPolicyTypeValues.reverse[cancellationPolicyType],
//         "service_status": serviceStatus,
//         "service_approve_status": serviceApproveStatus,
//         "coupons": coupons == null ? [] : List<dynamic>.from(coupons!.map((x) => x.toJson())),
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//         "serviceType": serviceType,
//         "makeAndModel": makeAndModel,
//         "firstRegistered": firstRegistered?.toIso8601String(),
//         "features": features?.toJson(),
//         "featurePricing": featurePricing?.toJson(),
//         "fullDayRate": fullDayRate,
//         "hourlyRate": hourlyRate,
//         "halfDayRate": halfDayRate,
//         "mileageCapLimit": mileageCapLimit,
//         "mileageCapExcessCharge": mileageCapExcessCharge,
//         "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
//         "bookingDateFrom": bookingDateFrom?.toIso8601String(),
//         "bookingDateTo": bookingDateTo?.toIso8601String(),
//         "specialPriceDays": specialPriceDays == null ? [] : List<dynamic>.from(specialPriceDays!.map((x) => x.toJson())),
//         "service_name": serviceName,
//         "emergencyContactNumber": emergencyContactNumber,
//         "pricingDetails": pricingDetails?.toJson(),
//         "accessibilityAndSpecialServices": accessibilityAndSpecialServices == null ? [] : List<dynamic>.from(accessibilityAndSpecialServices!.map((x) => x.toJson())),
//         "funeralPackageOptions": funeralPackageOptions?.toJson(),
//         "booking_availability_date_from": bookingAvailabilityDateFrom?.toIso8601String(),
//         "booking_availability_date_to": bookingAvailabilityDateTo?.toIso8601String(),
//         "fleetDetails": fleetDetails?.toJson(),
//         "driver_detail": driverDetail?.toJson(),
//         "service_detail": serviceDetail?.toJson(),
//         "licensingDetails": licensingDetails?.toJson(),
//         "insuranceDetails": insuranceDetails?.toJson(),
//         "uploaded_Documents": uploadedDocuments?.toJson(),
//         "serviceImages": serviceImages == null ? [] : List<dynamic>.from(serviceImages!.map((x) => x)),
//         "businessProfile": businessProfile?.toJson(),
//         "approvalStatus": approvalStatus,
//         "comfort": comfort?.toJson(),
//         "events": events?.toJson(),
//         "accessibility": accessibility?.toJson(),
//         "security": security?.toJson(),
//         "documents": documents?.toJson(),
//         "vehicleDetails": vehicleDetails?.toJson(),
//         "equipmentSafety": equipmentSafety?.toJson(),
//         "marketing": marketing?.toJson(),
//         "serviceAreas": serviceAreas == null ? [] : List<dynamic>.from(serviceAreas!.map((x) => x)),
//         "pricing": pricing?.toJson(),
//         "eventsExtras": eventsExtras == null ? [] : List<dynamic>.from(eventsExtras!.map((x) => x)),
//         "accessibilityServices": accessibilityServices == null ? [] : List<dynamic>.from(accessibilityServices!.map((x) => x)),
//         "availabilityPeriod": availabilityPeriod?.toJson(),
//         "baseLocationPostcode": baseLocationPostcode,
//         "licensing": licensing?.toJson(),
//         "serviceHighlights": serviceHighlights,
//         "documentation": documentation?.toJson(),
//         "boatType": boatType,
//         "boatRates": boatRates?.toJson(),
//         "navigableRoutes": navigableRoutes == null ? [] : List<dynamic>.from(navigableRoutes!.map((x) => x)),
//         "servicesOffered": servicesOffered?.toJson(),
//         "operatingHours": operatingHours?.toJson(),
//         "radiusCovered": radiusCovered,
//         "bookingTypes": bookingTypes?.toJson(),
//         "availableMinibuses": availableMinibuses,
//         "seatBeltsInAllVehicles": seatBeltsInAllVehicles,
//         "foodDrinksAllowed": foodDrinksAllowed,
//         "driverInformation": driverInformation?.toJson(),
//         "uniqueFeatures": uniqueFeatures,
//     };
// }

// class Accessibility {
//     bool wheelchairAccessVehicle;
//     int? wheelchairAccessPrice;
//     bool childCarSeats;
//     int? childCarSeatsPrice;
//     bool petFriendlyService;
//     int? petFriendlyPrice;
//     bool disabledAccessRamp;
//     int? disabledAccessRampPrice;
//     bool seniorFriendlyAssistance;
//     int? seniorAssistancePrice;
//     bool strollerBuggyStorage;
//     int? strollerStoragePrice;

//     Accessibility({
//         required this.wheelchairAccessVehicle,
//         this.wheelchairAccessPrice,
//         required this.childCarSeats,
//         this.childCarSeatsPrice,
//         required this.petFriendlyService,
//         this.petFriendlyPrice,
//         required this.disabledAccessRamp,
//         this.disabledAccessRampPrice,
//         required this.seniorFriendlyAssistance,
//         this.seniorAssistancePrice,
//         required this.strollerBuggyStorage,
//         this.strollerStoragePrice,
//     });

//     factory Accessibility.fromJson(Map<String, dynamic> json) => Accessibility(
//         wheelchairAccessVehicle: json["wheelchairAccessVehicle"],
//         wheelchairAccessPrice: json["wheelchairAccessPrice"],
//         childCarSeats: json["childCarSeats"],
//         childCarSeatsPrice: json["childCarSeatsPrice"],
//         petFriendlyService: json["petFriendlyService"],
//         petFriendlyPrice: json["petFriendlyPrice"],
//         disabledAccessRamp: json["disabledAccessRamp"],
//         disabledAccessRampPrice: json["disabledAccessRampPrice"],
//         seniorFriendlyAssistance: json["seniorFriendlyAssistance"],
//         seniorAssistancePrice: json["seniorAssistancePrice"],
//         strollerBuggyStorage: json["strollerBuggyStorage"],
//         strollerStoragePrice: json["strollerStoragePrice"],
//     );

//     Map<String, dynamic> toJson() => {
//         "wheelchairAccessVehicle": wheelchairAccessVehicle,
//         "wheelchairAccessPrice": wheelchairAccessPrice,
//         "childCarSeats": childCarSeats,
//         "childCarSeatsPrice": childCarSeatsPrice,
//         "petFriendlyService": petFriendlyService,
//         "petFriendlyPrice": petFriendlyPrice,
//         "disabledAccessRamp": disabledAccessRamp,
//         "disabledAccessRampPrice": disabledAccessRampPrice,
//         "seniorFriendlyAssistance": seniorFriendlyAssistance,
//         "seniorAssistancePrice": seniorAssistancePrice,
//         "strollerBuggyStorage": strollerBuggyStorage,
//         "strollerStoragePrice": strollerStoragePrice,
//     };
// }

// class AccessibilityAndSpecialService {
//     String serviceType;
//     int additionalPrice;
//     String id;

//     AccessibilityAndSpecialService({
//         required this.serviceType,
//         required this.additionalPrice,
//         required this.id,
//     });

//     factory AccessibilityAndSpecialService.fromJson(Map<String, dynamic> json) => AccessibilityAndSpecialService(
//         serviceType: json["serviceType"],
//         additionalPrice: json["additionalPrice"],
//         id: json["_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "serviceType": serviceType,
//         "additionalPrice": additionalPrice,
//         "_id": id,
//     };
// }

// class AvailabilityPeriod {
//     DateTime from;
//     DateTime to;

//     AvailabilityPeriod({
//         required this.from,
//         required this.to,
//     });

//     factory AvailabilityPeriod.fromJson(Map<String, dynamic> json) => AvailabilityPeriod(
//         from: DateTime.parse(json["from"]),
//         to: DateTime.parse(json["to"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "from": from.toIso8601String(),
//         "to": to.toIso8601String(),
//     };
// }

// class BoatRates {
//     int hourlyRate;
//     int? perMileRate;
//     int? tenHourDayHire;
//     int? halfDayHire;
//     int? halfDayRate;
//     int? fullDayRate;
//     int? overnightCharterRate;
//     String? packageDealsDescription;

//     BoatRates({
//         required this.hourlyRate,
//         this.perMileRate,
//         this.tenHourDayHire,
//         this.halfDayHire,
//         this.halfDayRate,
//         this.fullDayRate,
//         this.overnightCharterRate,
//         this.packageDealsDescription,
//     });

//     factory BoatRates.fromJson(Map<String, dynamic> json) => BoatRates(
//         hourlyRate: json["hourlyRate"],
//         perMileRate: json["perMileRate"],
//         tenHourDayHire: json["tenHourDayHire"],
//         halfDayHire: json["halfDayHire"],
//         halfDayRate: json["halfDayRate"],
//         fullDayRate: json["fullDayRate"],
//         overnightCharterRate: json["overnightCharterRate"],
//         packageDealsDescription: json["packageDealsDescription"],
//     );

//     Map<String, dynamic> toJson() => {
//         "hourlyRate": hourlyRate,
//         "perMileRate": perMileRate,
//         "tenHourDayHire": tenHourDayHire,
//         "halfDayHire": halfDayHire,
//         "halfDayRate": halfDayRate,
//         "fullDayRate": fullDayRate,
//         "overnightCharterRate": overnightCharterRate,
//         "packageDealsDescription": packageDealsDescription,
//     };
// }

// class BookingTypes {
//     bool oneWay;
//     bool bookingTypesReturn;
//     bool hourlyHire;
//     bool dailyLongTermHire;
//     bool contractualServices;

//     BookingTypes({
//         required this.oneWay,
//         required this.bookingTypesReturn,
//         required this.hourlyHire,
//         required this.dailyLongTermHire,
//         required this.contractualServices,
//     });

//     factory BookingTypes.fromJson(Map<String, dynamic> json) => BookingTypes(
//         oneWay: json["oneWay"],
//         bookingTypesReturn: json["return"],
//         hourlyHire: json["hourlyHire"],
//         dailyLongTermHire: json["dailyLongTermHire"],
//         contractualServices: json["contractualServices"],
//     );

//     Map<String, dynamic> toJson() => {
//         "oneWay": oneWay,
//         "return": bookingTypesReturn,
//         "hourlyHire": hourlyHire,
//         "dailyLongTermHire": dailyLongTermHire,
//         "contractualServices": contractualServices,
//     };
// }

// class BusinessProfile {
//     String businessHighlights;
//     String promotionalDescription;

//     BusinessProfile({
//         required this.businessHighlights,
//         required this.promotionalDescription,
//     });

//     factory BusinessProfile.fromJson(Map<String, dynamic> json) => BusinessProfile(
//         businessHighlights: json["businessHighlights"],
//         promotionalDescription: json["promotionalDescription"],
//     );

//     Map<String, dynamic> toJson() => {
//         "businessHighlights": businessHighlights,
//         "promotionalDescription": promotionalDescription,
//     };
// }

// enum CancellationPolicyType {
//     FLEXIBLE,
//     MODERATE,
//     STRICT
// }

// final cancellationPolicyTypeValues = EnumValues({
//     "FLEXIBLE": CancellationPolicyType.FLEXIBLE,
//     "MODERATE": CancellationPolicyType.MODERATE,
//     "STRICT": CancellationPolicyType.STRICT
// });

// class CategoryId {
//     Id id;
//     CategoryName categoryName;

//     CategoryId({
//         required this.id,
//         required this.categoryName,
//     });

//     factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
//         id: idValues.map[json["_id"]]!,
//         categoryName: categoryNameValues.map[json["category_name"]]!,
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": idValues.reverse[id],
//         "category_name": categoryNameValues.reverse[categoryName],
//     };
// }

// enum CategoryName {
//     PASSENGER_TRANSPORT
// }

// final categoryNameValues = EnumValues({
//     "Passenger Transport": CategoryName.PASSENGER_TRANSPORT
// });

// enum Id {
//     THE_676_AC544234968_D45_B494992
// }

// final idValues = EnumValues({
//     "676ac544234968d45b494992": Id.THE_676_AC544234968_D45_B494992
// });

// class ServiceComfort {
//     bool leatherInterior;
//     bool wifiAccess;
//     bool airConditioning;
//     ComplimentaryDrinks complimentaryDrinks;
//     bool inCarEntertainment;
//     bool bluetoothUsb;
//     bool redCarpetService;
//     bool onboardRestroom;

//     ServiceComfort({
//         required this.leatherInterior,
//         required this.wifiAccess,
//         required this.airConditioning,
//         required this.complimentaryDrinks,
//         required this.inCarEntertainment,
//         required this.bluetoothUsb,
//         required this.redCarpetService,
//         required this.onboardRestroom,
//     });

//     factory ServiceComfort.fromJson(Map<String, dynamic> json) => ServiceComfort(
//         leatherInterior: json["leatherInterior"],
//         wifiAccess: json["wifiAccess"],
//         airConditioning: json["airConditioning"],
//         complimentaryDrinks: ComplimentaryDrinks.fromJson(json["complimentaryDrinks"]),
//         inCarEntertainment: json["inCarEntertainment"],
//         bluetoothUsb: json["bluetoothUsb"],
//         redCarpetService: json["redCarpetService"],
//         onboardRestroom: json["onboardRestroom"],
//     );

//     Map<String, dynamic> toJson() => {
//         "leatherInterior": leatherInterior,
//         "wifiAccess": wifiAccess,
//         "airConditioning": airConditioning,
//         "complimentaryDrinks": complimentaryDrinks.toJson(),
//         "inCarEntertainment": inCarEntertainment,
//         "bluetoothUsb": bluetoothUsb,
//         "redCarpetService": redCarpetService,
//         "onboardRestroom": onboardRestroom,
//     };
// }

// class ComplimentaryDrinks {
//     bool available;
//     String? details;

//     ComplimentaryDrinks({
//         required this.available,
//         this.details,
//     });

//     factory ComplimentaryDrinks.fromJson(Map<String, dynamic> json) => ComplimentaryDrinks(
//         available: json["available"],
//         details: json["details"],
//     );

//     Map<String, dynamic> toJson() => {
//         "available": available,
//         "details": details,
//     };
// }

// class Coupon {
//     String couponCode;
//     DiscountType discountType;
//     int discountValue;
//     int usageLimit;
//     int currentUsageCount;
//     DateTime expiryDate;
//     bool isGlobal;
//     String id;

//     Coupon({
//         required this.couponCode,
//         required this.discountType,
//         required this.discountValue,
//         required this.usageLimit,
//         required this.currentUsageCount,
//         required this.expiryDate,
//         required this.isGlobal,
//         required this.id,
//     });

//     factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
//         couponCode: json["coupon_code"],
//         discountType: discountTypeValues.map[json["discount_type"]]!,
//         discountValue: json["discount_value"],
//         usageLimit: json["usage_limit"],
//         currentUsageCount: json["current_usage_count"],
//         expiryDate: DateTime.parse(json["expiry_date"]),
//         isGlobal: json["is_global"],
//         id: json["_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "coupon_code": couponCode,
//         "discount_type": discountTypeValues.reverse[discountType],
//         "discount_value": discountValue,
//         "usage_limit": usageLimit,
//         "current_usage_count": currentUsageCount,
//         "expiry_date": expiryDate.toIso8601String(),
//         "is_global": isGlobal,
//         "_id": id,
//     };
// }

// enum DiscountType {
//     PERCENTAGE
// }

// final discountTypeValues = EnumValues({
//     "PERCENTAGE": DiscountType.PERCENTAGE
// });

// class Documentation {
//     Documentation();

//     factory Documentation.fromJson(Map<String, dynamic> json) => Documentation(
//     );

//     Map<String, dynamic> toJson() => {
//     };
// }

// class ServiceDocuments {
//     DriverLicencesAndDbs? psvOperatorLicence;
//     dynamic publicLiabilityInsurance;
//     DriverLicencesAndDbs? driverLicencesAndDbs;
//     DriverLicencesAndDbs? vehicleMotAndInsurance;
//     String? animalLicense;
//     String? riskAssessment;
//     DbsCertificates? operatorLicence;
//     DbsCertificates? driverLicences;
//     DbsCertificates? vehicleInsuranceAndMoTs;
//     DbsCertificates? dbsCertificates;

//     ServiceDocuments({
//         this.psvOperatorLicence,
//         required this.publicLiabilityInsurance,
//         this.driverLicencesAndDbs,
//         this.vehicleMotAndInsurance,
//         this.animalLicense,
//         this.riskAssessment,
//         this.operatorLicence,
//         this.driverLicences,
//         this.vehicleInsuranceAndMoTs,
//         this.dbsCertificates,
//     });

//     factory ServiceDocuments.fromJson(Map<String, dynamic> json) => ServiceDocuments(
//         psvOperatorLicence: json["psvOperatorLicence"] == null ? null : DriverLicencesAndDbs.fromJson(json["psvOperatorLicence"]),
//         publicLiabilityInsurance: json["publicLiabilityInsurance"],
//         driverLicencesAndDbs: json["driverLicencesAndDBS"] == null ? null : DriverLicencesAndDbs.fromJson(json["driverLicencesAndDBS"]),
//         vehicleMotAndInsurance: json["vehicleMOTAndInsurance"] == null ? null : DriverLicencesAndDbs.fromJson(json["vehicleMOTAndInsurance"]),
//         animalLicense: json["animalLicense"],
//         riskAssessment: json["riskAssessment"],
//         operatorLicence: json["operatorLicence"] == null ? null : DbsCertificates.fromJson(json["operatorLicence"]),
//         driverLicences: json["driverLicences"] == null ? null : DbsCertificates.fromJson(json["driverLicences"]),
//         vehicleInsuranceAndMoTs: json["vehicleInsuranceAndMOTs"] == null ? null : DbsCertificates.fromJson(json["vehicleInsuranceAndMOTs"]),
//         dbsCertificates: json["dbsCertificates"] == null ? null : DbsCertificates.fromJson(json["dbsCertificates"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "psvOperatorLicence": psvOperatorLicence?.toJson(),
//         "publicLiabilityInsurance": publicLiabilityInsurance,
//         "driverLicencesAndDBS": driverLicencesAndDbs?.toJson(),
//         "vehicleMOTAndInsurance": vehicleMotAndInsurance?.toJson(),
//         "animalLicense": animalLicense,
//         "riskAssessment": riskAssessment,
//         "operatorLicence": operatorLicence?.toJson(),
//         "driverLicences": driverLicences?.toJson(),
//         "vehicleInsuranceAndMOTs": vehicleInsuranceAndMoTs?.toJson(),
//         "dbsCertificates": dbsCertificates?.toJson(),
//     };
// }

// class DbsCertificates {
//     bool isAttached;
//     String? image;

//     DbsCertificates({
//         required this.isAttached,
//         this.image,
//     });

//     factory DbsCertificates.fromJson(Map<String, dynamic> json) => DbsCertificates(
//         isAttached: json["isAttached"],
//         image: json["image"],
//     );

//     Map<String, dynamic> toJson() => {
//         "isAttached": isAttached,
//         "image": image,
//     };
// }

// class DriverLicencesAndDbs {
//     bool isAttached;

//     DriverLicencesAndDbs({
//         required this.isAttached,
//     });

//     factory DriverLicencesAndDbs.fromJson(Map<String, dynamic> json) => DriverLicencesAndDbs(
//         isAttached: json["isAttached"],
//     );

//     Map<String, dynamic> toJson() => {
//         "isAttached": isAttached,
//     };
// }

// class DriverDetail {
//     bool driversUniformed;
//     bool driversDbsChecked;

//     DriverDetail({
//         required this.driversUniformed,
//         required this.driversDbsChecked,
//     });

//     factory DriverDetail.fromJson(Map<String, dynamic> json) => DriverDetail(
//         driversUniformed: json["driversUniformed"],
//         driversDbsChecked: json["driversDBSChecked"],
//     );

//     Map<String, dynamic> toJson() => {
//         "driversUniformed": driversUniformed,
//         "driversDBSChecked": driversDbsChecked,
//     };
// }

// class DriverInformation {
//     bool fullyLicensedAndInsured;
//     bool dbsChecked;
//     String dressCode;

//     DriverInformation({
//         required this.fullyLicensedAndInsured,
//         required this.dbsChecked,
//         required this.dressCode,
//     });

//     factory DriverInformation.fromJson(Map<String, dynamic> json) => DriverInformation(
//         fullyLicensedAndInsured: json["fullyLicensedAndInsured"],
//         dbsChecked: json["dbsChecked"],
//         dressCode: json["dressCode"],
//     );

//     Map<String, dynamic> toJson() => {
//         "fullyLicensedAndInsured": fullyLicensedAndInsured,
//         "dbsChecked": dbsChecked,
//         "dressCode": dressCode,
//     };
// }

// class EquipmentSafety {
//     String? maintenanceFrequency;
//     List<String> safetyChecks;
//     List<String> animalWelfareStandards;
//     bool? isMaintained;
//     String? uniformType;
//     bool? offersRouteInspection;
//     String? otherMaintenanceFrequency;

//     EquipmentSafety({
//         this.maintenanceFrequency,
//         required this.safetyChecks,
//         required this.animalWelfareStandards,
//         this.isMaintained,
//         this.uniformType,
//         this.offersRouteInspection,
//         this.otherMaintenanceFrequency,
//     });

//     factory EquipmentSafety.fromJson(Map<String, dynamic> json) => EquipmentSafety(
//         maintenanceFrequency: json["maintenanceFrequency"],
//         safetyChecks: List<String>.from(json["safetyChecks"].map((x) => x)),
//         animalWelfareStandards: List<String>.from(json["animalWelfareStandards"].map((x) => x)),
//         isMaintained: json["isMaintained"],
//         uniformType: json["uniformType"],
//         offersRouteInspection: json["offersRouteInspection"],
//         otherMaintenanceFrequency: json["otherMaintenanceFrequency"],
//     );

//     Map<String, dynamic> toJson() => {
//         "maintenanceFrequency": maintenanceFrequency,
//         "safetyChecks": List<dynamic>.from(safetyChecks.map((x) => x)),
//         "animalWelfareStandards": List<dynamic>.from(animalWelfareStandards.map((x) => x)),
//         "isMaintained": isMaintained,
//         "uniformType": uniformType,
//         "offersRouteInspection": offersRouteInspection,
//         "otherMaintenanceFrequency": otherMaintenanceFrequency,
//     };
// }

// class Events {
//     bool weddingDecor;
//     int? weddingDecorPrice;
//     bool partyLightingSystem;
//     int? partyLightingPrice;
//     bool champagnePackages;
//     int? champagnePackagePrice;
//     bool photographyPackages;
//     int? photographyPackagePrice;

//     Events({
//         required this.weddingDecor,
//         this.weddingDecorPrice,
//         required this.partyLightingSystem,
//         this.partyLightingPrice,
//         required this.champagnePackages,
//         this.champagnePackagePrice,
//         required this.photographyPackages,
//         this.photographyPackagePrice,
//     });

//     factory Events.fromJson(Map<String, dynamic> json) => Events(
//         weddingDecor: json["weddingDecor"],
//         weddingDecorPrice: json["weddingDecorPrice"],
//         partyLightingSystem: json["partyLightingSystem"],
//         partyLightingPrice: json["partyLightingPrice"],
//         champagnePackages: json["champagnePackages"],
//         champagnePackagePrice: json["champagnePackagePrice"],
//         photographyPackages: json["photographyPackages"],
//         photographyPackagePrice: json["photographyPackagePrice"],
//     );

//     Map<String, dynamic> toJson() => {
//         "weddingDecor": weddingDecor,
//         "weddingDecorPrice": weddingDecorPrice,
//         "partyLightingSystem": partyLightingSystem,
//         "partyLightingPrice": partyLightingPrice,
//         "champagnePackages": champagnePackages,
//         "champagnePackagePrice": champagnePackagePrice,
//         "photographyPackages": photographyPackages,
//         "photographyPackagePrice": photographyPackagePrice,
//     };
// }

// class FeaturePricing {
//     EventsAndCustomization? eventsAndCustomization;
//     AccessibilityServices accessibilityServices;
//     EventsExtras? eventsExtras;

//     FeaturePricing({
//         this.eventsAndCustomization,
//         required this.accessibilityServices,
//         this.eventsExtras,
//     });

//     factory FeaturePricing.fromJson(Map<String, dynamic> json) => FeaturePricing(
//         eventsAndCustomization: json["eventsAndCustomization"] == null ? null : EventsAndCustomization.fromJson(json["eventsAndCustomization"]),
//         accessibilityServices: AccessibilityServices.fromJson(json["accessibilityServices"]),
//         eventsExtras: json["eventsExtras"] == null ? null : EventsExtras.fromJson(json["eventsExtras"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "eventsAndCustomization": eventsAndCustomization?.toJson(),
//         "accessibilityServices": accessibilityServices.toJson(),
//         "eventsExtras": eventsExtras?.toJson(),
//     };
// }

// class AccessibilityServices {
//     int? wheelchairAccess;
//     int? wheelchairAccessVehicle;
//     int? childCarSeats;
//     int? petFriendlyService;
//     int? disabledAccessRamp;
//     int? seniorFriendlyAssistance;
//     int? strollerBuggyStorage;

//     AccessibilityServices({
//         this.wheelchairAccess,
//         this.wheelchairAccessVehicle,
//         this.childCarSeats,
//         this.petFriendlyService,
//         this.disabledAccessRamp,
//         this.seniorFriendlyAssistance,
//         this.strollerBuggyStorage,
//     });

//     factory AccessibilityServices.fromJson(Map<String, dynamic> json) => AccessibilityServices(
//         wheelchairAccess: json["Wheelchair Access"],
//         wheelchairAccessVehicle: json["WheelchairAccessVehicle"],
//         childCarSeats: json["ChildCarSeats"],
//         petFriendlyService: json["Pet-FriendlyService"],
//         disabledAccessRamp: json["Disabled-AccessRamp"],
//         seniorFriendlyAssistance: json["Senior-FriendlyAssistance"],
//         strollerBuggyStorage: json["Stroller/BuggyStorage"],
//     );

//     Map<String, dynamic> toJson() => {
//         "Wheelchair Access": wheelchairAccess,
//         "WheelchairAccessVehicle": wheelchairAccessVehicle,
//         "ChildCarSeats": childCarSeats,
//         "Pet-FriendlyService": petFriendlyService,
//         "Disabled-AccessRamp": disabledAccessRamp,
//         "Senior-FriendlyAssistance": seniorFriendlyAssistance,
//         "Stroller/BuggyStorage": strollerBuggyStorage,
//     };
// }

// class EventsAndCustomization {
//     int? redCarpetService;

//     EventsAndCustomization({
//         this.redCarpetService,
//     });

//     factory EventsAndCustomization.fromJson(Map<String, dynamic> json) => EventsAndCustomization(
//         redCarpetService: json["Red Carpet Service"],
//     );

//     Map<String, dynamic> toJson() => {
//         "Red Carpet Service": redCarpetService,
//     };
// }

// class EventsExtras {
//     int? weddingDcorribbonsFlowers;
//     int? partyLightingSystem;
//     int? champagnePackages;
//     int? photographyPackages;

//     EventsExtras({
//         this.weddingDcorribbonsFlowers,
//         this.partyLightingSystem,
//         this.champagnePackages,
//         this.photographyPackages,
//     });

//     factory EventsExtras.fromJson(Map<String, dynamic> json) => EventsExtras(
//         weddingDcorribbonsFlowers: json["WeddingDécorribbons,flowers"],
//         partyLightingSystem: json["PartyLightingSystem"],
//         champagnePackages: json["ChampagnePackages"],
//         photographyPackages: json["PhotographyPackages"],
//     );

//     Map<String, dynamic> toJson() => {
//         "WeddingDécorribbons,flowers": weddingDcorribbonsFlowers,
//         "PartyLightingSystem": partyLightingSystem,
//         "ChampagnePackages": champagnePackages,
//         "PhotographyPackages": photographyPackages,
//     };
// }

// class Features {
//     List<String>? comfortAndLuxury;
//     List<String>? eventsAndCustomization;
//     List<String>? accessibilityServices;
//     List<String>? safetyAndCompliance;
//     FeaturesComfort? comfort;
//     Events? events;
//     Accessibility? accessibility;
//     Security? security;
//     bool? wifi;
//     bool? airConditioning;
//     bool? tv;
//     bool? toilet;
//     bool? musicSystem;
//     bool? cateringFacilities;
//     bool? sunDeck;
//     bool? overnightStayCabins;
//     bool? other;
//     String? otherFeature;

//     Features({
//         this.comfortAndLuxury,
//         this.eventsAndCustomization,
//         this.accessibilityServices,
//         this.safetyAndCompliance,
//         this.comfort,
//         this.events,
//         this.accessibility,
//         this.security,
//         this.wifi,
//         this.airConditioning,
//         this.tv,
//         this.toilet,
//         this.musicSystem,
//         this.cateringFacilities,
//         this.sunDeck,
//         this.overnightStayCabins,
//         this.other,
//         this.otherFeature,
//     });

//     factory Features.fromJson(Map<String, dynamic> json) => Features(
//         comfortAndLuxury: json["comfortAndLuxury"] == null ? [] : List<String>.from(json["comfortAndLuxury"]!.map((x) => x)),
//         eventsAndCustomization: json["eventsAndCustomization"] == null ? [] : List<String>.from(json["eventsAndCustomization"]!.map((x) => x)),
//         accessibilityServices: json["accessibilityServices"] == null ? [] : List<String>.from(json["accessibilityServices"]!.map((x) => x)),
//         safetyAndCompliance: json["safetyAndCompliance"] == null ? [] : List<String>.from(json["safetyAndCompliance"]!.map((x) => x)),
//         comfort: json["comfort"] == null ? null : FeaturesComfort.fromJson(json["comfort"]),
//         events: json["events"] == null ? null : Events.fromJson(json["events"]),
//         accessibility: json["accessibility"] == null ? null : Accessibility.fromJson(json["accessibility"]),
//         security: json["security"] == null ? null : Security.fromJson(json["security"]),
//         wifi: json["wifi"],
//         airConditioning: json["airConditioning"],
//         tv: json["tv"],
//         toilet: json["toilet"],
//         musicSystem: json["musicSystem"],
//         cateringFacilities: json["cateringFacilities"],
//         sunDeck: json["sunDeck"],
//         overnightStayCabins: json["overnightStayCabins"],
//         other: json["other"],
//         otherFeature: json["otherFeature"],
//     );

//     Map<String, dynamic> toJson() => {
//         "comfortAndLuxury": comfortAndLuxury == null ? [] : List<dynamic>.from(comfortAndLuxury!.map((x) => x)),
//         "eventsAndCustomization": eventsAndCustomization == null ? [] : List<dynamic>.from(eventsAndCustomization!.map((x) => x)),
//         "accessibilityServices": accessibilityServices == null ? [] : List<dynamic>.from(accessibilityServices!.map((x) => x)),
//         "safetyAndCompliance": safetyAndCompliance == null ? [] : List<dynamic>.from(safetyAndCompliance!.map((x) => x)),
//         "comfort": comfort?.toJson(),
//         "events": events?.toJson(),
//         "accessibility": accessibility?.toJson(),
//         "security": security?.toJson(),
//         "wifi": wifi,
//         "airConditioning": airConditioning,
//         "tv": tv,
//         "toilet": toilet,
//         "musicSystem": musicSystem,
//         "cateringFacilities": cateringFacilities,
//         "sunDeck": sunDeck,
//         "overnightStayCabins": overnightStayCabins,
//         "other": other,
//         "otherFeature": otherFeature,
//     };
// }

// class FeaturesComfort {
//     bool leatherInterior;
//     bool wifiAccess;
//     bool airConditioning;
//     ComplimentaryDrinks complimentaryDrinks;
//     bool inCarEntertainment;
//     bool bluetoothUsb;
//     bool redCarpetService;
//     bool chauffeurInUniform;
//     bool onboardRestroom;

//     FeaturesComfort({
//         required this.leatherInterior,
//         required this.wifiAccess,
//         required this.airConditioning,
//         required this.complimentaryDrinks,
//         required this.inCarEntertainment,
//         required this.bluetoothUsb,
//         required this.redCarpetService,
//         required this.chauffeurInUniform,
//         required this.onboardRestroom,
//     });

//     factory FeaturesComfort.fromJson(Map<String, dynamic> json) => FeaturesComfort(
//         leatherInterior: json["leatherInterior"],
//         wifiAccess: json["wifiAccess"],
//         airConditioning: json["airConditioning"],
//         complimentaryDrinks: ComplimentaryDrinks.fromJson(json["complimentaryDrinks"]),
//         inCarEntertainment: json["inCarEntertainment"],
//         bluetoothUsb: json["bluetoothUsb"],
//         redCarpetService: json["redCarpetService"],
//         chauffeurInUniform: json["chauffeurInUniform"],
//         onboardRestroom: json["onboardRestroom"],
//     );

//     Map<String, dynamic> toJson() => {
//         "leatherInterior": leatherInterior,
//         "wifiAccess": wifiAccess,
//         "airConditioning": airConditioning,
//         "complimentaryDrinks": complimentaryDrinks.toJson(),
//         "inCarEntertainment": inCarEntertainment,
//         "bluetoothUsb": bluetoothUsb,
//         "redCarpetService": redCarpetService,
//         "chauffeurInUniform": chauffeurInUniform,
//         "onboardRestroom": onboardRestroom,
//     };
// }

// class Security {
//     bool vehicleTrackingGps;
//     bool cctvFitted;
//     bool publicLiabilityInsurance;
//     bool safetyCertifiedDrivers;

//     Security({
//         required this.vehicleTrackingGps,
//         required this.cctvFitted,
//         required this.publicLiabilityInsurance,
//         required this.safetyCertifiedDrivers,
//     });

//     factory Security.fromJson(Map<String, dynamic> json) => Security(
//         vehicleTrackingGps: json["vehicleTrackingGps"],
//         cctvFitted: json["cctvFitted"],
//         publicLiabilityInsurance: json["publicLiabilityInsurance"],
//         safetyCertifiedDrivers: json["safetyCertifiedDrivers"],
//     );

//     Map<String, dynamic> toJson() => {
//         "vehicleTrackingGps": vehicleTrackingGps,
//         "cctvFitted": cctvFitted,
//         "publicLiabilityInsurance": publicLiabilityInsurance,
//         "safetyCertifiedDrivers": safetyCertifiedDrivers,
//     };
// }

// class FleetDetails {
//     String makeModel;
//     int year;
//     String? vehicleType;
//     String? color;
//     int? capacity;
//     String? notes;

//     FleetDetails({
//         required this.makeModel,
//         required this.year,
//         this.vehicleType,
//         this.color,
//         this.capacity,
//         this.notes,
//     });

//     factory FleetDetails.fromJson(Map<String, dynamic> json) => FleetDetails(
//         makeModel: json["makeModel"],
//         year: json["year"],
//         vehicleType: json["vehicleType"],
//         color: json["color"],
//         capacity: json["capacity"],
//         notes: json["notes"],
//     );

//     Map<String, dynamic> toJson() => {
//         "makeModel": makeModel,
//         "year": year,
//         "vehicleType": vehicleType,
//         "color": color,
//         "capacity": capacity,
//         "notes": notes,
//     };
// }

// class FleetInfo {
//     String? makeAndModel;
//     int? capacity;
//     DateTime? firstRegistered;
//     bool? wheelchairAccessible;
//     int? wheelchairAccessiblePrice;
//     bool? airConditioning;
//     bool? luggageSpace;
//     int? seats;
//     DateTime? firstRegistration;
//     String? boatName;
//     String? type;
//     String? onboardFeatures;
//     int? year;
//     String? notes;

//     FleetInfo({
//         this.makeAndModel,
//         this.capacity,
//         this.firstRegistered,
//         this.wheelchairAccessible,
//         this.wheelchairAccessiblePrice,
//         this.airConditioning,
//         this.luggageSpace,
//         this.seats,
//         this.firstRegistration,
//         this.boatName,
//         this.type,
//         this.onboardFeatures,
//         this.year,
//         this.notes,
//     });

//     factory FleetInfo.fromJson(Map<String, dynamic> json) => FleetInfo(
//         makeAndModel: json["makeAndModel"],
//         capacity: json["capacity"],
//         firstRegistered: json["firstRegistered"] == null ? null : DateTime.parse(json["firstRegistered"]),
//         wheelchairAccessible: json["wheelchairAccessible"],
//         wheelchairAccessiblePrice: json["wheelchairAccessiblePrice"],
//         airConditioning: json["airConditioning"],
//         luggageSpace: json["luggageSpace"],
//         seats: json["seats"],
//         firstRegistration: json["firstRegistration"] == null ? null : DateTime.parse(json["firstRegistration"]),
//         boatName: json["boatName"],
//         type: json["type"],
//         onboardFeatures: json["onboardFeatures"],
//         year: json["year"],
//         notes: json["notes"],
//     );

//     Map<String, dynamic> toJson() => {
//         "makeAndModel": makeAndModel,
//         "capacity": capacity,
//         "firstRegistered": firstRegistered?.toIso8601String(),
//         "wheelchairAccessible": wheelchairAccessible,
//         "wheelchairAccessiblePrice": wheelchairAccessiblePrice,
//         "airConditioning": airConditioning,
//         "luggageSpace": luggageSpace,
//         "seats": seats,
//         "firstRegistration": firstRegistration?.toIso8601String(),
//         "boatName": boatName,
//         "type": type,
//         "onboardFeatures": onboardFeatures,
//         "year": year,
//         "notes": notes,
//     };
// }

// class FuneralPackageOptions {
//     int standard;
//     int vipExecutive;

//     FuneralPackageOptions({
//         required this.standard,
//         required this.vipExecutive,
//     });

//     factory FuneralPackageOptions.fromJson(Map<String, dynamic> json) => FuneralPackageOptions(
//         standard: json["standard"],
//         vipExecutive: json["vipExecutive"],
//     );

//     Map<String, dynamic> toJson() => {
//         "standard": standard,
//         "vipExecutive": vipExecutive,
//     };
// }

// class InsuranceDetails {
//     String publicLiabilityInsuranceProvider;
//     String policyNumber;
//     DateTime? policyExpiryDate;

//     InsuranceDetails({
//         required this.publicLiabilityInsuranceProvider,
//         required this.policyNumber,
//         required this.policyExpiryDate,
//     });

//     factory InsuranceDetails.fromJson(Map<String, dynamic> json) => InsuranceDetails(
//         publicLiabilityInsuranceProvider: json["publicLiabilityInsuranceProvider"],
//         policyNumber: json["policyNumber"],
//         policyExpiryDate: json["policyExpiryDate"] == null ? null : DateTime.parse(json["policyExpiryDate"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "publicLiabilityInsuranceProvider": publicLiabilityInsuranceProvider,
//         "policyNumber": policyNumber,
//         "policyExpiryDate": policyExpiryDate?.toIso8601String(),
//     };
// }

// class Licensing {
//     LicensingDocuments? documents;
//     String? privateHireOperatorLicenceNumber;
//     String? licensingAuthority;
//     String? publicLiabilityInsuranceProvider;
//     String? policyNumber;
//     DateTime? expiryDate;

//     Licensing({
//         this.documents,
//         this.privateHireOperatorLicenceNumber,
//         this.licensingAuthority,
//         this.publicLiabilityInsuranceProvider,
//         this.policyNumber,
//         this.expiryDate,
//     });

//     factory Licensing.fromJson(Map<String, dynamic> json) => Licensing(
//         documents: json["documents"] == null ? null : LicensingDocuments.fromJson(json["documents"]),
//         privateHireOperatorLicenceNumber: json["privateHireOperatorLicenceNumber"],
//         licensingAuthority: json["licensingAuthority"],
//         publicLiabilityInsuranceProvider: json["publicLiabilityInsuranceProvider"],
//         policyNumber: json["policyNumber"],
//         expiryDate: json["expiryDate"] == null ? null : DateTime.parse(json["expiryDate"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "documents": documents?.toJson(),
//         "privateHireOperatorLicenceNumber": privateHireOperatorLicenceNumber,
//         "licensingAuthority": licensingAuthority,
//         "publicLiabilityInsuranceProvider": publicLiabilityInsuranceProvider,
//         "policyNumber": policyNumber,
//         "expiryDate": "${expiryDate!.year.toString().padLeft(4, '0')}-${expiryDate!.month.toString().padLeft(2, '0')}-${expiryDate!.day.toString().padLeft(2, '0')}",
//     };
// }

// class LicensingDocuments {
//     DbsCertificates operatorLicence;
//     DbsCertificates vehicleInsurance;
//     DbsCertificates publicLiabilityInsurance;
//     DbsCertificates v5CLogbook;
//     DbsCertificates chauffeurDrivingLicence;

//     LicensingDocuments({
//         required this.operatorLicence,
//         required this.vehicleInsurance,
//         required this.publicLiabilityInsurance,
//         required this.v5CLogbook,
//         required this.chauffeurDrivingLicence,
//     });

//     factory LicensingDocuments.fromJson(Map<String, dynamic> json) => LicensingDocuments(
//         operatorLicence: DbsCertificates.fromJson(json["operatorLicence"]),
//         vehicleInsurance: DbsCertificates.fromJson(json["vehicleInsurance"]),
//         publicLiabilityInsurance: DbsCertificates.fromJson(json["publicLiabilityInsurance"]),
//         v5CLogbook: DbsCertificates.fromJson(json["v5cLogbook"]),
//         chauffeurDrivingLicence: DbsCertificates.fromJson(json["chauffeurDrivingLicence"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "operatorLicence": operatorLicence.toJson(),
//         "vehicleInsurance": vehicleInsurance.toJson(),
//         "publicLiabilityInsurance": publicLiabilityInsurance.toJson(),
//         "v5cLogbook": v5CLogbook.toJson(),
//         "chauffeurDrivingLicence": chauffeurDrivingLicence.toJson(),
//     };
// }

// class LicensingDetails {
//     String operatorLicenceNumber;
//     String licensingAuthority;

//     LicensingDetails({
//         required this.operatorLicenceNumber,
//         required this.licensingAuthority,
//     });

//     factory LicensingDetails.fromJson(Map<String, dynamic> json) => LicensingDetails(
//         operatorLicenceNumber: json["operatorLicenceNumber"],
//         licensingAuthority: json["licensingAuthority"],
//     );

//     Map<String, dynamic> toJson() => {
//         "operatorLicenceNumber": operatorLicenceNumber,
//         "licensingAuthority": licensingAuthority,
//     };
// }

// class Marketing {
//     List<dynamic> serviceHighlights;
//     String? description;

//     Marketing({
//         required this.serviceHighlights,
//         this.description,
//     });

//     factory Marketing.fromJson(Map<String, dynamic> json) => Marketing(
//         serviceHighlights: List<dynamic>.from(json["serviceHighlights"].map((x) => x)),
//         description: json["description"],
//     );

//     Map<String, dynamic> toJson() => {
//         "serviceHighlights": List<dynamic>.from(serviceHighlights.map((x) => x)),
//         "description": description,
//     };
// }

// class MiniBusRates {
//     double hourlyRate;
//     double halfDayRate;
//     int fullDayRate;
//     double additionalMileageFee;
//     int? mileageLimit;
//     int? mileageAllowance;

//     MiniBusRates({
//         required this.hourlyRate,
//         required this.halfDayRate,
//         required this.fullDayRate,
//         required this.additionalMileageFee,
//         this.mileageLimit,
//         this.mileageAllowance,
//     });

//     factory MiniBusRates.fromJson(Map<String, dynamic> json) => MiniBusRates(
//         hourlyRate: json["hourlyRate"]?.toDouble(),
//         halfDayRate: json["halfDayRate"]?.toDouble(),
//         fullDayRate: json["fullDayRate"],
//         additionalMileageFee: json["additionalMileageFee"]?.toDouble(),
//         mileageLimit: json["mileageLimit"],
//         mileageAllowance: json["mileageAllowance"],
//     );

//     Map<String, dynamic> toJson() => {
//         "hourlyRate": hourlyRate,
//         "halfDayRate": halfDayRate,
//         "fullDayRate": fullDayRate,
//         "additionalMileageFee": additionalMileageFee,
//         "mileageLimit": mileageLimit,
//         "mileageAllowance": mileageAllowance,
//     };
// }

// class OperatingHours {
//     bool available24X7;
//     String specificHours;

//     OperatingHours({
//         required this.available24X7,
//         required this.specificHours,
//     });

//     factory OperatingHours.fromJson(Map<String, dynamic> json) => OperatingHours(
//         available24X7: json["available24x7"],
//         specificHours: json["specificHours"],
//     );

//     Map<String, dynamic> toJson() => {
//         "available24x7": available24X7,
//         "specificHours": specificHours,
//     };
// }

// class Pricing {
//     double? dayRate;
//     int? mileageLimit;
//     double? extraMileageCharge;
//     double hourlyRate;
//     double halfDayRate;
//     int? fullDayRate;
//     int? ceremonyPackageRate;
//     double? perMileCharge;

//     Pricing({
//         this.dayRate,
//         this.mileageLimit,
//         this.extraMileageCharge,
//         required this.hourlyRate,
//         required this.halfDayRate,
//         this.fullDayRate,
//         this.ceremonyPackageRate,
//         this.perMileCharge,
//     });

//     factory Pricing.fromJson(Map<String, dynamic> json) => Pricing(
//         dayRate: json["dayRate"]?.toDouble(),
//         mileageLimit: json["mileageLimit"],
//         extraMileageCharge: json["extraMileageCharge"]?.toDouble(),
//         hourlyRate: json["hourlyRate"]?.toDouble(),
//         halfDayRate: json["halfDayRate"]?.toDouble(),
//         fullDayRate: json["fullDayRate"],
//         ceremonyPackageRate: json["ceremonyPackageRate"],
//         perMileCharge: json["perMileCharge"]?.toDouble(),
//     );

//     Map<String, dynamic> toJson() => {
//         "dayRate": dayRate,
//         "mileageLimit": mileageLimit,
//         "extraMileageCharge": extraMileageCharge,
//         "hourlyRate": hourlyRate,
//         "halfDayRate": halfDayRate,
//         "fullDayRate": fullDayRate,
//         "ceremonyPackageRate": ceremonyPackageRate,
//         "perMileCharge": perMileCharge,
//     };
// }

// class PricingDetails {
//     double? dayRate;
//     int mileageLimit;
//     double? extraMileageCharge;
//     double hourlyRate;
//     double halfDayRate;
//     double? fullDayRate;
//     double? additionalMileageFee;
//     bool? fuelChargesIncluded;
//     int? waitTimeFeePerHour;
//     int? decoratingFloralServiceFee;

//     PricingDetails({
//         this.dayRate,
//         required this.mileageLimit,
//         this.extraMileageCharge,
//         required this.hourlyRate,
//         required this.halfDayRate,
//         this.fullDayRate,
//         this.additionalMileageFee,
//         this.fuelChargesIncluded,
//         this.waitTimeFeePerHour,
//         this.decoratingFloralServiceFee,
//     });

//     factory PricingDetails.fromJson(Map<String, dynamic> json) => PricingDetails(
//         dayRate: json["dayRate"]?.toDouble(),
//         mileageLimit: json["mileageLimit"],
//         extraMileageCharge: json["extraMileageCharge"]?.toDouble(),
//         hourlyRate: json["hourlyRate"]?.toDouble(),
//         halfDayRate: json["halfDayRate"]?.toDouble(),
//         fullDayRate: json["fullDayRate"]?.toDouble(),
//         additionalMileageFee: json["additionalMileageFee"]?.toDouble(),
//         fuelChargesIncluded: json["fuelChargesIncluded"],
//         waitTimeFeePerHour: json["waitTimeFeePerHour"],
//         decoratingFloralServiceFee: json["decoratingFloralServiceFee"],
//     );

//     Map<String, dynamic> toJson() => {
//         "dayRate": dayRate,
//         "mileageLimit": mileageLimit,
//         "extraMileageCharge": extraMileageCharge,
//         "hourlyRate": hourlyRate,
//         "halfDayRate": halfDayRate,
//         "fullDayRate": fullDayRate,
//         "additionalMileageFee": additionalMileageFee,
//         "fuelChargesIncluded": fuelChargesIncluded,
//         "waitTimeFeePerHour": waitTimeFeePerHour,
//         "decoratingFloralServiceFee": decoratingFloralServiceFee,
//     };
// }

// class ServiceDetail {
//     bool worksWithFuneralDirectors;
//     bool supportsAllFuneralTypes;
//     String funeralServiceType;
//     List<String> additionalSupportServices;

//     ServiceDetail({
//         required this.worksWithFuneralDirectors,
//         required this.supportsAllFuneralTypes,
//         required this.funeralServiceType,
//         required this.additionalSupportServices,
//     });

//     factory ServiceDetail.fromJson(Map<String, dynamic> json) => ServiceDetail(
//         worksWithFuneralDirectors: json["worksWithFuneralDirectors"],
//         supportsAllFuneralTypes: json["supportsAllFuneralTypes"],
//         funeralServiceType: json["funeralServiceType"],
//         additionalSupportServices: List<String>.from(json["additionalSupportServices"].map((x) => x)),
//     );

//     Map<String, dynamic> toJson() => {
//         "worksWithFuneralDirectors": worksWithFuneralDirectors,
//         "supportsAllFuneralTypes": supportsAllFuneralTypes,
//         "funeralServiceType": funeralServiceType,
//         "additionalSupportServices": List<dynamic>.from(additionalSupportServices.map((x) => x)),
//     };
// }

// class SpecialPriceDay {
//     DateTime date;
//     double price;
//     String? id;

//     SpecialPriceDay({
//         required this.date,
//         required this.price,
//         this.id,
//     });

//     factory SpecialPriceDay.fromJson(Map<String, dynamic> json) => SpecialPriceDay(
//         date: DateTime.parse(json["date"]),
//         price: json["price"]?.toDouble(),
//         id: json["_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
//         "price": price,
//         "_id": id,
//     };
// }

// class ServicesOffered {
//     bool localGroupTransport;
//     bool airportTransfers;
//     bool schoolTrips;
//     bool corporateTransport;
//     bool eventWeddingShuttles;
//     bool dayTours;
//     bool contractHire;
//     bool accessibleMinibusHire;
//     bool other;
//     String otherSpecified;

//     ServicesOffered({
//         required this.localGroupTransport,
//         required this.airportTransfers,
//         required this.schoolTrips,
//         required this.corporateTransport,
//         required this.eventWeddingShuttles,
//         required this.dayTours,
//         required this.contractHire,
//         required this.accessibleMinibusHire,
//         required this.other,
//         required this.otherSpecified,
//     });

//     factory ServicesOffered.fromJson(Map<String, dynamic> json) => ServicesOffered(
//         localGroupTransport: json["localGroupTransport"],
//         airportTransfers: json["airportTransfers"],
//         schoolTrips: json["schoolTrips"],
//         corporateTransport: json["corporateTransport"],
//         eventWeddingShuttles: json["eventWeddingShuttles"],
//         dayTours: json["dayTours"],
//         contractHire: json["contractHire"],
//         accessibleMinibusHire: json["accessibleMinibusHire"],
//         other: json["other"],
//         otherSpecified: json["otherSpecified"],
//     );

//     Map<String, dynamic> toJson() => {
//         "localGroupTransport": localGroupTransport,
//         "airportTransfers": airportTransfers,
//         "schoolTrips": schoolTrips,
//         "corporateTransport": corporateTransport,
//         "eventWeddingShuttles": eventWeddingShuttles,
//         "dayTours": dayTours,
//         "contractHire": contractHire,
//         "accessibleMinibusHire": accessibleMinibusHire,
//         "other": other,
//         "otherSpecified": otherSpecified,
//     };
// }

// class SubcategoryId {
//     String id;
//     String subcategoryName;

//     SubcategoryId({
//         required this.id,
//         required this.subcategoryName,
//     });

//     factory SubcategoryId.fromJson(Map<String, dynamic> json) => SubcategoryId(
//         id: json["_id"],
//         subcategoryName: json["subcategory_name"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "subcategory_name": subcategoryName,
//     };
// }

// class UploadedDocuments {
//     List<String> fleetPhotos;
//     String? operatorLicence;
//     String? insuranceCertificate;
//     String? driverLicencesAndDbs;
//     String? vehicleMoTs;

//     UploadedDocuments({
//         required this.fleetPhotos,
//         this.operatorLicence,
//         this.insuranceCertificate,
//         this.driverLicencesAndDbs,
//         this.vehicleMoTs,
//     });

//     factory UploadedDocuments.fromJson(Map<String, dynamic> json) => UploadedDocuments(
//         fleetPhotos: List<String>.from(json["fleetPhotos"].map((x) => x)),
//         operatorLicence: json["operatorLicence"],
//         insuranceCertificate: json["insuranceCertificate"],
//         driverLicencesAndDbs: json["driverLicencesAndDBS"],
//         vehicleMoTs: json["vehicleMOTs"],
//     );

//     Map<String, dynamic> toJson() => {
//         "fleetPhotos": List<dynamic>.from(fleetPhotos.map((x) => x)),
//         "operatorLicence": operatorLicence,
//         "insuranceCertificate": insuranceCertificate,
//         "driverLicencesAndDBS": driverLicencesAndDbs,
//         "vehicleMOTs": vehicleMoTs,
//     };
// }

// class VehicleDetails {
//     String makeAndModel;
//     DateTime firstRegistered;
//     String basePostcode;
//     int? locationRadius;

//     VehicleDetails({
//         required this.makeAndModel,
//         required this.firstRegistered,
//         required this.basePostcode,
//         this.locationRadius,
//     });

//     factory VehicleDetails.fromJson(Map<String, dynamic> json) => VehicleDetails(
//         makeAndModel: json["makeAndModel"],
//         firstRegistered: DateTime.parse(json["firstRegistered"]),
//         basePostcode: json["basePostcode"],
//         locationRadius: json["locationRadius"],
//     );

//     Map<String, dynamic> toJson() => {
//         "makeAndModel": makeAndModel,
//         "firstRegistered": firstRegistered.toIso8601String(),
//         "basePostcode": basePostcode,
//         "locationRadius": locationRadius,
//     };
// }

// class EnumValues<T> {
//     Map<String, T> map;
//     late Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//             reverseMap = map.map((k, v) => MapEntry(v, k));
//             return reverseMap;
//     }
// }
