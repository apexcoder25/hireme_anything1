// lib/data/models/user_side_model/CouponModel.dart

class Coupon {
  final String? couponCode;
  final String? discountType;
  final int? discountValue;
  final int? usageLimit;
  final int? currentUsageCount;
  final dynamic expiryDate; // can be DateTime or String
  final bool? isGlobal;
  final int? minimumDays;
  final int? minimumVehicles;
  final String? description;
  final String? id;

  Coupon({
    this.couponCode,
    this.discountType,
    this.discountValue,
    this.usageLimit,
    this.currentUsageCount,
    this.expiryDate,
    this.isGlobal,
    this.minimumDays,
    this.minimumVehicles,
    this.description,
    this.id,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      couponCode: json["coupon_code"],
      discountType: json["discount_type"],
      discountValue: json["discount_value"],
      usageLimit: json["usage_limit"],
      currentUsageCount: json["current_usage_count"],
      expiryDate: json["expiry_date"],
      isGlobal: json["is_global"],
      minimumDays: json["minimum_days"],
      minimumVehicles: json["minimum_vehicles"],
      description: json["description"],
      id: json["_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "coupon_code": couponCode,
        "discount_type": discountType,
        "discount_value": discountValue,
        "usage_limit": usageLimit,
        "current_usage_count": currentUsageCount,
        "expiry_date": expiryDate,
        "is_global": isGlobal,
        "minimum_days": minimumDays,
        "minimum_vehicles": minimumVehicles,
        "description": description,
        "_id": id,
      };
}