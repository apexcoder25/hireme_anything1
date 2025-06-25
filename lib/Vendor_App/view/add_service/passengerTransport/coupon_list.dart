import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coupanController.dart';

class CouponList extends StatefulWidget {
  @override
  State<CouponList> createState() => _CouponListState();
}

class _CouponListState extends State<CouponList> {
  final CouponController couponController = Get.put(CouponController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          itemCount: couponController.coupons.length,
          itemBuilder: (context, index) {
            var coupon = couponController.coupons[index];

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: ListTile(
                title: Text("Code: ${coupon['coupon_code']}"),
                subtitle: Text(
                  "Type: ${coupon['discount_type']} | Value: ${coupon['discount_value']}\n"
                  "Usage Limit: ${coupon['usage_limit']}\n"
                  "Expires: ${coupon['expiry_date']}\n"
                  "Global: ${coupon['is_global'] == true ? 'Yes' : 'No'}", // Fix applied
                ),
                trailing: TextButton(
                  onPressed: () => couponController.removeCoupon(index),
                  child: const Text("Remove", style: TextStyle(color: Colors.red)),
                ),
              ),
            );
          },
        ));
  }
}
