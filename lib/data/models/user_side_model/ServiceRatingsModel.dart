// data/models/user_side_model/service_ratings_model.dart

class ServiceRatings {
  List<Rating>? ratings;
  double? averageRating;

  ServiceRatings({this.ratings, this.averageRating});

  factory ServiceRatings.fromJson(Map<String, dynamic> json) => ServiceRatings(
        ratings: json["ratings"] == null ? null : List<Rating>.from(json["ratings"].map((x) => Rating.fromJson(x))),
        averageRating: json["averageRating"]?.toDouble(),
      );
}

class Rating {
  VendorResponse? vendorResponse;
  String? id;
  UserId? userId;
  String? serviceId;
  String? bookingId;
  int? rating;
  String? comment;
  DateTime? createdAt;
  DateTime? updatedAt;

  Rating({
    this.vendorResponse,
    this.id,
    this.userId,
    this.serviceId,
    this.bookingId,
    this.rating,
    this.comment,
    this.createdAt,
    this.updatedAt,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        vendorResponse: json["vendor_response"] == null ? null : VendorResponse.fromJson(json["vendor_response"]),
        id: json["_id"],
        userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
        serviceId: json["serviceId"],
        bookingId: json["bookingId"],
        rating: json["rating"],
        comment: json["comment"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );
}

class VendorResponse {
  DateTime? createdAt;

  VendorResponse({this.createdAt});

  factory VendorResponse.fromJson(Map<String, dynamic> json) => VendorResponse(
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
      );
}

class UserId {
  String? id;
  String? firstName;
  String? lastName;

  UserId({this.id, this.firstName, this.lastName});

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
      );
}