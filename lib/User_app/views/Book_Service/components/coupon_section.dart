import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/User_app/views/Book_Service/controllers/your_service_booking.dart';


class CouponSection extends StatefulWidget {
  final YourServicesViewModel viewModel;

  const CouponSection({super.key, required this.viewModel});

  @override
  State<CouponSection> createState() => _CouponSectionState();
}

class _CouponSectionState extends State<CouponSection> {
  @override
  Widget build(BuildContext context) {

    final TextEditingController couponController = TextEditingController(text: widget.viewModel.selectedCoupon.value);


    ever(widget.viewModel.selectedCoupon, (String? newValue) {
      couponController.text = newValue ?? '';
    });

    return Column(
      children: [
        Row(
          children: [
            const SizedBox(height: 100,),
            Expanded(
              child: TextField(
                controller: couponController,
                decoration: const InputDecoration(
                  labelText: 'Type or select a coupon',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                onChanged: (value) {
                  widget.viewModel.selectedCoupon.value = value; 
                },
              ),
            ),
            const SizedBox(width: 8),
            Obx(() {
           
              if (widget.viewModel.discountAmount.value > 0 && widget.viewModel.selectedCoupon.value.isNotEmpty) {
                return ElevatedButton(
                  onPressed: () {
                  
                    widget.viewModel.selectedCoupon.value = '';
                    widget.viewModel.discountAmount.value = 0.0;
                    widget.viewModel.calculateTotal();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  child: const Text('Remove', style: TextStyle(fontSize: 14)),
                );
              } else {
                return ElevatedButton(
                  onPressed: () {
                    if (widget.viewModel.selectedCoupon.value.isNotEmpty &&
                        widget.viewModel.service.value!.coupons.any((c) => c.couponCode == widget.viewModel.selectedCoupon.value)) {
                      widget.viewModel.applyCoupon(widget.viewModel.selectedCoupon.value);
                    } else {
                      Get.snackbar('Error', 'Invalid or expired coupon');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  child: const Text('Apply', style: TextStyle(fontSize: 14)),
                );
              }
            }),
            const SizedBox(width: 8),
            TextButton(
              onPressed: widget.viewModel.toggleCoupons,
              child: Obx(() => Text(
                    widget.viewModel.showCoupons.value ? 'Hide Coupons' : 'Show Coupons',
                    style: const TextStyle(color: Colors.blue, fontSize: 14),
                  )),
            ),
          ],
        ),
        Obx(() {
          if (widget.viewModel.showCoupons.value) {
            return Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(8),
              color: Colors.grey[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.viewModel.selectedCoupon.value.isNotEmpty && widget.viewModel.discountAmount.value > 0)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Applied Coupon: ${widget.viewModel.selectedCoupon.value} - £${widget.viewModel.discountAmount.value.toStringAsFixed(2)} discount',
                        style: const TextStyle(color: Colors.green, fontSize: 14),
                      ),
                    ),
                  ...widget.viewModel.service.value!.coupons
                      .where((c) => !widget.viewModel.isCouponExpired(DateTime.parse(c.expiryDate)))
                      .map(
                        (coupon) => ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            '${coupon.couponCode} (${coupon.discountValue}% off)',
                            style: const TextStyle(fontSize: 14, color: Colors.black87),
                          ),
                          trailing: TextButton(
                            onPressed: () {
                            
                              widget.viewModel.selectedCoupon.value = coupon.couponCode;
                              widget.viewModel.applyCoupon(coupon.couponCode);
                              widget.viewModel.toggleCoupons(); 
                            },
                            child: const Text('Use', style: TextStyle(color: Colors.blue, fontSize: 14)),
                          ),
                        ),
                      ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}