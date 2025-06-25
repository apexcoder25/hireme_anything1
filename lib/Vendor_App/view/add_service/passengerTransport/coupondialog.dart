import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coupanController.dart';
import 'package:intl/intl.dart'; // Import for date formatting

class AddCouponDialog extends StatelessWidget {
  final CouponController couponController = Get.put(CouponController());

  final TextEditingController codeController = TextEditingController();
  final TextEditingController discountValueController = TextEditingController();
  final TextEditingController usageLimitController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final RxString discountType = "PERCENTAGE".obs; // Default type
  final RxBool isGlobal = false.obs;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add New Coupon"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: codeController,
              decoration: const InputDecoration(labelText: "Coupon Code"),
            ),
            Obx(() => DropdownButtonFormField<String>(
                  value: discountType.value,
                  items: ["PERCENTAGE", "FLAT"].map((String type) {
                    return DropdownMenuItem(value: type, child: Text(type));
                  }).toList(),
                  onChanged: (value) {
                    discountType.value = value!;
                  },
                  decoration: const InputDecoration(labelText: "Discount Type"),
                )),
            TextField(
              controller: discountValueController,
              decoration: const InputDecoration(labelText: "Discount Value"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: usageLimitController,
              decoration: const InputDecoration(labelText: "Usage Limit"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: expiryDateController,
              decoration: const InputDecoration(
                labelText: "Expiry Date (YYYY-MM-DD)",
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // Formatting
                  expiryDateController.text = formattedDate; // Store in correct format
                }
              },
            ),
            Obx(() => CheckboxListTile(
                  title: const Text("Is this coupon valid for all services? (Global)"),
                  value: isGlobal.value,
                  onChanged: (value) {
                    isGlobal.value = value!;
                  },
                )),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            couponController.addCoupon(
              code: codeController.text.trim(),
              type: discountType.value.trim(),
              value: int.tryParse(discountValueController.text.trim()) ?? 0,
              limit: int.tryParse(usageLimitController.text.trim()) ?? 0,
              expiry: expiryDateController.text.trim(), // Correct format ensured
              isGlobal: isGlobal.value,
            );
            print(couponController.coupons);
            Get.back(); // Close dialog
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
