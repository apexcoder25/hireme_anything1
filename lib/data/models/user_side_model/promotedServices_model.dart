
import 'dart:convert';

PromotedServices promotedServicesFromJson(String str) => PromotedServices.fromJson(json.decode(str));

String promotedServicesToJson(PromotedServices data) => json.encode(data.toJson());

class PromotedServices {
    bool success;
    int count;
    List<Datum> data;
    dynamic userLocation;
    AppliedFilters appliedFilters;

    PromotedServices({
        required this.success,
        required this.count,
        required this.data,
        required this.userLocation,
        required this.appliedFilters,
    });

    factory PromotedServices.fromJson(Map<String, dynamic> json) => PromotedServices(
        success: json["success"],
        count: json["count"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        userLocation: json["userLocation"],
        appliedFilters: AppliedFilters.fromJson(json["appliedFilters"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "userLocation": userLocation,
        "appliedFilters": appliedFilters.toJson(),
    };
}

class AppliedFilters {
    int maxDistance;
    dynamic categoryId;

    AppliedFilters({
        required this.maxDistance,
        required this.categoryId,
    });

    factory AppliedFilters.fromJson(Map<String, dynamic> json) => AppliedFilters(
        maxDistance: json["maxDistance"],
        categoryId: json["categoryId"],
    );

    Map<String, dynamic> toJson() => {
        "maxDistance": maxDistance,
        "categoryId": categoryId,
    };
}

class Datum {
    int id;
    String title;
    String subtitle;
    String description;
    String vendor;
    double rating;
    int reviews;
    String phone;
    String location;
    dynamic distance;
    List<String> tags;
    List<String> services;
    String startingPrice;
    String image;
    bool isVerified;
    bool isTrending;
    String responseTime;
    String promotionLevel;

    Datum({
        required this.id,
        required this.title,
        required this.subtitle,
        required this.description,
        required this.vendor,
        required this.rating,
        required this.reviews,
        required this.phone,
        required this.location,
        required this.distance,
        required this.tags,
        required this.services,
        required this.startingPrice,
        required this.image,
        required this.isVerified,
        required this.isTrending,
        required this.responseTime,
        required this.promotionLevel,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
        description: json["description"],
        vendor: json["vendor"],
        rating: json["rating"]?.toDouble(),
        reviews: json["reviews"],
        phone: json["phone"],
        location: json["location"],
        distance: json["distance"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        services: List<String>.from(json["services"].map((x) => x)),
        startingPrice: json["startingPrice"],
        image: json["image"],
        isVerified: json["isVerified"],
        isTrending: json["isTrending"],
        responseTime: json["responseTime"],
        promotionLevel: json["promotionLevel"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "description": description,
        "vendor": vendor,
        "rating": rating,
        "reviews": reviews,
        "phone": phone,
        "location": location,
        "distance": distance,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "services": List<dynamic>.from(services.map((x) => x)),
        "startingPrice": startingPrice,
        "image": image,
        "isVerified": isVerified,
        "isTrending": isTrending,
        "responseTime": responseTime,
        "promotionLevel": promotionLevel,
    };
}
