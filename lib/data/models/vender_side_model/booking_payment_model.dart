class BookingPaymentModel {
    BookingPaymentModel({
        required this.bookings,
    });

    final List<Booking> bookings;

    factory BookingPaymentModel.fromJson(Map<String, dynamic> json){ 
        return BookingPaymentModel(
            bookings: json["bookings"] == null ? [] : List<Booking>.from(json["bookings"]!.map((x) => Booking.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "bookings": bookings.map((x) => x?.toJson()).toList(),
    };

}

class Booking {
    Booking({
        required this.occasionAndPurpose,
        required this.priceDetails,
        required this.id,
        required this.userId,
        required this.vendorId,
        required this.serviceId,
        required this.invoiceNumber,
        required this.grandTotal,
        required this.commissionPrice,
        required this.paypalOrderId,
        required this.confirmationCode,
        required this.otp,
        required this.cancellationPolicyType,
        required this.bookingServiceStatus,
        required this.paymentCaptureId,
        required this.bookingStatus,
        required this.paymentStatus,
        required this.paymentMethod,
        required this.bookingRefundAmount,
        required this.pickupTime,
        required this.pickupLocation,
        required this.dropLocation,
        required this.distance,
        required this.dateOfTravel,
        required this.isReturnTrip,
        required this.tripType,
        required this.wheelchairAccessRequired,
        required this.termsConfirmed,
        required this.privacyConfirmed,
        required this.bookingSpecialRequests,
        required this.isRated,
        required this.isAcceptedByVendor,
        required this.orderNo,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.bookingRefundTransaction,
        required this.extrasAndServices,
        required this.specialRequests,
        required this.pickupAddress,
        required this.dropoffAddress,
        required this.journeyDate,
        required this.bookingType,
        required this.returnTrip,
        required this.returnPickupTime,
        required this.carriageType,
        required this.horseColourPreference,
        required this.numberOfPassengers,
        required this.refundAmount,
        required this.refundTransaction,
        required this.returnDate,
        required this.departureDate,
        required this.departureTime,
        required this.primaryDeparturePoint,
        required this.boatType,
        required this.otherBoatTypeDescription,
        required this.numberOfGuests,
        required this.typicalUse,
        required this.otherTypicalUse,
        required this.rentalDuration,
        required this.paymentId,
    });

    final OccasionAndPurpose? occasionAndPurpose;
    final PriceDetails? priceDetails;
    final String? id;
    final UserId? userId;
    final String? vendorId;
    final ServiceId? serviceId;
    final String? invoiceNumber;
    final double? grandTotal;
    final double? commissionPrice;
    final String? paypalOrderId;
    final String? confirmationCode;
    final int? otp;
    final String? cancellationPolicyType;
    final String? bookingServiceStatus;
    final String? paymentCaptureId;
    final String? bookingStatus;
    final String? paymentStatus;
    final String? paymentMethod;
    final double? bookingRefundAmount;
    final String? pickupTime;
    final String? pickupLocation;
    final String? dropLocation;
    final int? distance;
    final DateTime? dateOfTravel;
    final bool? isReturnTrip;
    final String? tripType;
    final bool? wheelchairAccessRequired;
    final bool? termsConfirmed;
    final bool? privacyConfirmed;
    final String? bookingSpecialRequests;
    final bool? isRated;
    final bool? isAcceptedByVendor;
    final dynamic? orderNo;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;
    final String? bookingRefundTransaction;
    final ExtrasAndServices? extrasAndServices;
    final SpecialRequests? specialRequests;
    final String? pickupAddress;
    final String? dropoffAddress;
    final DateTime? journeyDate;
    final String? bookingType;
    final bool? returnTrip;
    final String? returnPickupTime;
    final String? carriageType;
    final String? horseColourPreference;
    final int? numberOfPassengers;
    final int? refundAmount;
    final String? refundTransaction;
    final String? returnDate;
    final DateTime? departureDate;
    final String? departureTime;
    final String? primaryDeparturePoint;
    final String? boatType;
    final String? otherBoatTypeDescription;
    final int? numberOfGuests;
    final List<String> typicalUse;
    final String? otherTypicalUse;
    final String? rentalDuration;
    final String? paymentId;

    factory Booking.fromJson(Map<String, dynamic> json){ 
        return Booking(
            occasionAndPurpose: json["occasionAndPurpose"] == null ? null : OccasionAndPurpose.fromJson(json["occasionAndPurpose"]),
            priceDetails: json["price_details"] == null ? null : PriceDetails.fromJson(json["price_details"]),
            id: json["_id"],
            userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
            vendorId: json["vendorId"],
            serviceId: json["serviceId"] == null ? null : ServiceId.fromJson(json["serviceId"]),
            invoiceNumber: json["invoiceNumber"],
            grandTotal: json["grand_total"],
            commissionPrice: json["commission_price"],
            paypalOrderId: json["paypal_order_id"],
            confirmationCode: json["confirmation_code"],
            otp: json["otp"],
            cancellationPolicyType: json["cancellation_policy_type"],
            bookingServiceStatus: json["booking_service_status"],
            paymentCaptureId: json["payment_capture_id"],
            bookingStatus: json["booking_status"],
            paymentStatus: json["payment_status"],
            paymentMethod: json["payment_method"],
            bookingRefundAmount: json["refund_amount"],
            pickupTime: json["pickup_time"],
            pickupLocation: json["pickup_location"],
            dropLocation: json["drop_location"],
            distance: json["distance"],
            dateOfTravel: DateTime.tryParse(json["dateOfTravel"] ?? ""),
            isReturnTrip: json["isReturnTrip"],
            tripType: json["tripType"],
            wheelchairAccessRequired: json["wheelchairAccessRequired"],
            termsConfirmed: json["terms_confirmed"],
            privacyConfirmed: json["privacy_confirmed"],
            bookingSpecialRequests: json["special_requests"],
            isRated: json["isRated"],
            isAcceptedByVendor: json["isAcceptedByVendor"],
            orderNo: json["order_no"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
            bookingRefundTransaction: json["refund_transaction"],
            extrasAndServices: json["extrasAndServices"] == null ? null : ExtrasAndServices.fromJson(json["extrasAndServices"]),
            specialRequests: json["specialRequests"] == null ? null : SpecialRequests.fromJson(json["specialRequests"]),
            pickupAddress: json["pickup_address"],
            dropoffAddress: json["dropoff_address"],
            journeyDate: DateTime.tryParse(json["journey_date"] ?? ""),
            bookingType: json["booking_type"],
            returnTrip: json["return_trip"],
            returnPickupTime: json["return_pickup_time"],
            carriageType: json["carriageType"],
            horseColourPreference: json["horseColourPreference"],
            numberOfPassengers: json["numberOfPassengers"],
            refundAmount: json["refundAmount"],
            refundTransaction: json["refundTransaction"],
            returnDate: json["return_date"],
            departureDate: DateTime.tryParse(json["departure_date"] ?? ""),
            departureTime: json["departure_time"],
            primaryDeparturePoint: json["primary_departure_point"],
            boatType: json["boatType"],
            otherBoatTypeDescription: json["otherBoatTypeDescription"],
            numberOfGuests: json["numberOfGuests"],
            typicalUse: json["typicalUse"] == null ? [] : List<String>.from(json["typicalUse"]!.map((x) => x)),
            otherTypicalUse: json["otherTypicalUse"],
            rentalDuration: json["rentalDuration"],
            paymentId: json["paymentId"],
        );
    }

    Map<String, dynamic> toJson() => {
        "occasionAndPurpose": occasionAndPurpose?.toJson(),
        "price_details": priceDetails?.toJson(),
        "_id": id,
        "userId": userId?.toJson(),
        "vendorId": vendorId,
        "serviceId": serviceId?.toJson(),
        "invoiceNumber": invoiceNumber,
        "grand_total": grandTotal,
        "commission_price": commissionPrice,
        "paypal_order_id": paypalOrderId,
        "confirmation_code": confirmationCode,
        "otp": otp,
        "cancellation_policy_type": cancellationPolicyType,
        "booking_service_status": bookingServiceStatus,
        "payment_capture_id": paymentCaptureId,
        "booking_status": bookingStatus,
        "payment_status": paymentStatus,
        "payment_method": paymentMethod,
        "refund_amount": bookingRefundAmount,
        "pickup_time": pickupTime,
        "pickup_location": pickupLocation,
        "drop_location": dropLocation,
        "distance": distance,
        "dateOfTravel": dateOfTravel?.toIso8601String(),
        "isReturnTrip": isReturnTrip,
        "tripType": tripType,
        "wheelchairAccessRequired": wheelchairAccessRequired,
        "terms_confirmed": termsConfirmed,
        "privacy_confirmed": privacyConfirmed,
        "special_requests": bookingSpecialRequests,
        "isRated": isRated,
        "isAcceptedByVendor": isAcceptedByVendor,
        "order_no": orderNo,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "refund_transaction": bookingRefundTransaction,
        "extrasAndServices": extrasAndServices?.toJson(),
        "specialRequests": specialRequests?.toJson(),
        "pickup_address": pickupAddress,
        "dropoff_address": dropoffAddress,
        "journey_date": journeyDate?.toIso8601String(),
        "booking_type": bookingType,
        "return_trip": returnTrip,
        "return_pickup_time": returnPickupTime,
        "carriageType": carriageType,
        "horseColourPreference": horseColourPreference,
        "numberOfPassengers": numberOfPassengers,
        "refundAmount": refundAmount,
        "refundTransaction": refundTransaction,
        "return_date": returnDate,
        "departure_date": departureDate?.toIso8601String(),
        "departure_time": departureTime,
        "primary_departure_point": primaryDeparturePoint,
        "boatType": boatType,
        "otherBoatTypeDescription": otherBoatTypeDescription,
        "numberOfGuests": numberOfGuests,
        "typicalUse": typicalUse.map((x) => x).toList(),
        "otherTypicalUse": otherTypicalUse,
        "rentalDuration": rentalDuration,
        "paymentId": paymentId,
    };

}

class ExtrasAndServices {
    ExtrasAndServices({
        required this.floralDecor,
        required this.lanternsLighting,
        required this.refreshmentService,
        required this.liveMusic,
        required this.redCarpetService,
        required this.groomsAttendant,
        required this.photographyPackage,
        required this.accessibilityAssistance,
    });

    final bool? floralDecor;
    final bool? lanternsLighting;
    final bool? refreshmentService;
    final bool? liveMusic;
    final bool? redCarpetService;
    final bool? groomsAttendant;
    final bool? photographyPackage;
    final bool? accessibilityAssistance;

    factory ExtrasAndServices.fromJson(Map<String, dynamic> json){ 
        return ExtrasAndServices(
            floralDecor: json["floralDecor"],
            lanternsLighting: json["lanternsLighting"],
            refreshmentService: json["refreshmentService"],
            liveMusic: json["liveMusic"],
            redCarpetService: json["redCarpetService"],
            groomsAttendant: json["groomsAttendant"],
            photographyPackage: json["photographyPackage"],
            accessibilityAssistance: json["accessibilityAssistance"],
        );
    }

    Map<String, dynamic> toJson() => {
        "floralDecor": floralDecor,
        "lanternsLighting": lanternsLighting,
        "refreshmentService": refreshmentService,
        "liveMusic": liveMusic,
        "redCarpetService": redCarpetService,
        "groomsAttendant": groomsAttendant,
        "photographyPackage": photographyPackage,
        "accessibilityAssistance": accessibilityAssistance,
    };

}

class OccasionAndPurpose {
    OccasionAndPurpose({
        required this.schoolTrip,
        required this.corporateEvent,
        required this.weddingParty,
        required this.airportTransfer,
        required this.sportsTeam,
        required this.dayTour,
        required this.other,
        required this.wedding,
        required this.prom,
        required this.culturalCeremony,
        required this.filmShoot,
        required this.photoshoot,
        required this.otherSpecified,
    });

    final bool? schoolTrip;
    final bool? corporateEvent;
    final bool? weddingParty;
    final bool? airportTransfer;
    final bool? sportsTeam;
    final bool? dayTour;
    final bool? other;
    final bool? wedding;
    final bool? prom;
    final bool? culturalCeremony;
    final bool? filmShoot;
    final bool? photoshoot;
    final String? otherSpecified;

    factory OccasionAndPurpose.fromJson(Map<String, dynamic> json){ 
        return OccasionAndPurpose(
            schoolTrip: json["schoolTrip"],
            corporateEvent: json["corporateEvent"],
            weddingParty: json["weddingParty"],
            airportTransfer: json["airportTransfer"],
            sportsTeam: json["sportsTeam"],
            dayTour: json["dayTour"],
            other: json["other"],
            wedding: json["wedding"],
            prom: json["prom"],
            culturalCeremony: json["culturalCeremony"],
            filmShoot: json["filmShoot"],
            photoshoot: json["photoshoot"],
            otherSpecified: json["otherSpecified"],
        );
    }

    Map<String, dynamic> toJson() => {
        "schoolTrip": schoolTrip,
        "corporateEvent": corporateEvent,
        "weddingParty": weddingParty,
        "airportTransfer": airportTransfer,
        "sportsTeam": sportsTeam,
        "dayTour": dayTour,
        "other": other,
        "wedding": wedding,
        "prom": prom,
        "culturalCeremony": culturalCeremony,
        "filmShoot": filmShoot,
        "photoshoot": photoshoot,
        "otherSpecified": otherSpecified,
    };

}

class PriceDetails {
    PriceDetails({
        required this.basePrice,
        required this.totalPrice,
        required this.extraCharges,
        required this.discounts,
        required this.depositAmount,
    });

    final double? basePrice;
    final double? totalPrice;
    final int? extraCharges;
    final int? discounts;
    final int? depositAmount;

    factory PriceDetails.fromJson(Map<String, dynamic> json){ 
        return PriceDetails(
            basePrice: json["basePrice"],
            totalPrice: json["totalPrice"],
            extraCharges: json["extraCharges"],
            discounts: json["discounts"],
            depositAmount: json["depositAmount"],
        );
    }

    Map<String, dynamic> toJson() => {
        "basePrice": basePrice,
        "totalPrice": totalPrice,
        "extraCharges": extraCharges,
        "discounts": discounts,
        "depositAmount": depositAmount,
    };

}

class ServiceId {
    ServiceId({
        required this.id,
        required this.categoryId,
        required this.subcategoryId,
        required this.serviceIdServiceName,
        required this.serviceName,
    });

    final String? id;
    final CategoryId? categoryId;
    final SubcategoryId? subcategoryId;
    final String? serviceIdServiceName;
    final String? serviceName;

    factory ServiceId.fromJson(Map<String, dynamic> json){ 
        return ServiceId(
            id: json["_id"],
            categoryId: json["categoryId"] == null ? null : CategoryId.fromJson(json["categoryId"]),
            subcategoryId: json["subcategoryId"] == null ? null : SubcategoryId.fromJson(json["subcategoryId"]),
            serviceIdServiceName: json["service_name"],
            serviceName: json["serviceName"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "categoryId": categoryId?.toJson(),
        "subcategoryId": subcategoryId?.toJson(),
        "service_name": serviceIdServiceName,
        "serviceName": serviceName,
    };

}

class CategoryId {
    CategoryId({
        required this.id,
        required this.categoryName,
    });

    final String? id;
    final String? categoryName;

    factory CategoryId.fromJson(Map<String, dynamic> json){ 
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

class SpecialRequests {
    SpecialRequests({
        required this.scenicRoute,
        required this.vintageCostumeHire,
        required this.personalizedSignage,
        required this.animalWelfarePreferences,
        required this.other,
        required this.otherSpecified,
        required this.details,
    });

    final bool? scenicRoute;
    final bool? vintageCostumeHire;
    final bool? personalizedSignage;
    final bool? animalWelfarePreferences;
    final bool? other;
    final String? otherSpecified;
    final String? details;

    factory SpecialRequests.fromJson(Map<String, dynamic> json){ 
        return SpecialRequests(
            scenicRoute: json["scenicRoute"],
            vintageCostumeHire: json["vintageCostumeHire"],
            personalizedSignage: json["personalizedSignage"],
            animalWelfarePreferences: json["animalWelfarePreferences"],
            other: json["other"],
            otherSpecified: json["otherSpecified"],
            details: json["details"],
        );
    }

    Map<String, dynamic> toJson() => {
        "scenicRoute": scenicRoute,
        "vintageCostumeHire": vintageCostumeHire,
        "personalizedSignage": personalizedSignage,
        "animalWelfarePreferences": animalWelfarePreferences,
        "other": other,
        "otherSpecified": otherSpecified,
        "details": details,
    };

}

class UserId {
    UserId({
        required this.id,
        required this.countryCode,
        required this.mobileNo,
        required this.firstName,
        required this.lastName,
        required this.email,
    });

    final String? id;
    final String? countryCode;
    final String? mobileNo;
    final String? firstName;
    final String? lastName;
    final String? email;

    factory UserId.fromJson(Map<String, dynamic> json){ 
        return UserId(
            id: json["_id"],
            countryCode: json["country_code"],
            mobileNo: json["mobile_no"],
            firstName: json["firstName"],
            lastName: json["lastName"],
            email: json["email"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "country_code": countryCode,
        "mobile_no": mobileNo,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
    };

}
