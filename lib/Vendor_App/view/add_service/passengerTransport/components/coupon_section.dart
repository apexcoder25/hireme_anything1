// components/coupon_section.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/components/passenger_service_viewmodel.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coupon_list.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coupondialog.dart';

class CouponSection extends StatefulWidget {
  const CouponSection({super.key});

  @override
  State<CouponSection> createState() => _CouponSectionState();
}

class _CouponSectionState extends State<CouponSection> {
  @override
  Widget build(BuildContext context) {
    final vm = Get.put(PassengerServiceViewModel());
    final w = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Coupons / Discounts", style: TextStyle(color: Colors.black87, fontSize: 20)),
        const SizedBox(height: 20),
        SizedBox(
          width: w * 0.5,
          height: 50,
          child: ElevatedButton(
            onPressed: () => Get.dialog( AddCouponDialog()),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text("Add Coupon", style: TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(height: 20),
        Obx(() => vm.couponController.coupons.isNotEmpty
            ?  CouponList()
            : const Center(child: Text("No coupons added yet."))),
        const SizedBox(height: 20),
      ],
    );
  }
}