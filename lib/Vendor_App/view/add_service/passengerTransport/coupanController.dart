import 'package:get/get.dart';

class CouponController extends GetxController {
  RxList<Map<String, dynamic>> coupons = <Map<String, dynamic>>[].obs;

  void addCoupon({
    required String code,
    required String type,
    required int value,
    required int limit,
    required String expiry,
    required bool isGlobal,
  }) {
    coupons.add({
      "coupon_code": code.trim(),
      "discount_type": type.isNotEmpty ? type : "PERCENTAGE",
      "discount_value": value,
      "usage_limit": limit,
      "expiry_date": expiry.trim(),
      "is_global": isGlobal ?? false, 
      "current_usage_count": 0, 
    });
    print(coupons);
  }

  void removeCoupon(int index) {
    if (index >= 0 && index < coupons.length) {
      coupons.removeAt(index);
    }
  }

  void clearCoupons() {
    coupons.clear();
  }
}
