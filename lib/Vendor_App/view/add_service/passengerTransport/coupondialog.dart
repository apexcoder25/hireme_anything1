import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coupanController.dart';
import 'package:intl/intl.dart';

class AddCouponDialog extends StatefulWidget {
  const AddCouponDialog({super.key});

  @override
  State<AddCouponDialog> createState() => _AddCouponDialogState();
}

class _AddCouponDialogState extends State<AddCouponDialog> {
  final CouponController controller = Get.find();

  final codeCtrl = TextEditingController(text: "HA-");
  final valueCtrl = TextEditingController();
  final usageCtrl = TextEditingController(text: "1");
  final expiryCtrl = TextEditingController();
  final minDaysCtrl = TextEditingController(text: "7");
  final minVehiclesCtrl = TextEditingController(text: "5");
  final descCtrl = TextEditingController();

  final RxString couponType = "General".obs;
  final RxString discountType = "Percentage (%)".obs;
  final RxBool isGlobal = false.obs;

  @override
  void initState() {
    super.initState();

    /// 🔵 AUTO ADD HA- PREFIX
    codeCtrl.addListener(() {
      if (!codeCtrl.text.startsWith("HA-")) {
        final text = codeCtrl.text.replaceAll("HA-", "");
        codeCtrl.value = TextEditingValue(
          text: "HA-$text",
          selection: TextSelection.collapsed(offset: ("HA-$text").length),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      titlePadding: const EdgeInsets.fromLTRB(20, 16, 12, 8),
      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Add Coupon", style: TextStyle(fontWeight: FontWeight.w600)),
          IconButton(icon: const Icon(Icons.close), onPressed: () => Get.back()),
        ],
      ),
      content: SizedBox(
        width: 420,
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            /// COUPON TYPE
            const Text("Coupon Type", style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Obx(() => Row(
              children: ["General", "Long Booking", "Multi Vehicle"].map((t) {
                final selected = couponType.value == t;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: OutlinedButton(
                      onPressed: () => couponType.value = t,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: selected ? const Color(0xFFE8F2FF) : Colors.white,
                        side: BorderSide(color: selected ? const Color(0xFF2F80ED) : const Color(0xFFE0E0E0)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(
                        t,
                        style: TextStyle(
                          color: selected ? const Color(0xFF2F80ED) : Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            )),

            const SizedBox(height: 18),

            /// COUPON CODE
            const Text("Coupon Code", style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: codeCtrl,
                    decoration: InputDecoration(
                      hintText: "HA-SAVE15, HA-LONG7, HA-MULTI5",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    codeCtrl.text = "HA-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}";
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE8F2FF),
                    foregroundColor: const Color(0xFF2F80ED),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Auto-generate HA-code"),
                ),
              ],
            ),
            const SizedBox(height: 6),
            const Text(
              "💡 HA- prefix is automatically added for HireAnything branding. You can customize the rest manually or use auto-generate.",
              style: TextStyle(fontSize: 11, color: Color(0xFF9E9E9E)),
            ),

            const SizedBox(height: 18),

            /// DISCOUNT
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: discountType.value,
                    items: ["Percentage (%)", "Fixed Amount (£)"]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) => discountType.value = v!,
                    decoration: const InputDecoration(
                      labelText: "Discount Type",
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: valueCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Discount Value",
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            /// USAGE + EXPIRY
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: usageCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Usage Limit",
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: expiryCtrl,
                    readOnly: true,
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2035),
                      );
                      if (d != null) expiryCtrl.text = DateFormat("dd-MM-yyyy").format(d);
                    },
                    decoration: const InputDecoration(
                      labelText: "Expiry Date (optional)",
                      suffixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            /// CONDITIONS (EXACT BLUE CARD)
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF4FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Obx(() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text("Coupon Conditions", style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                if (couponType.value != "General")
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: minDaysCtrl,
                          decoration: const InputDecoration(
                            labelText: "Minimum Days (7+ days)",
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: minVehiclesCtrl,
                          decoration: const InputDecoration(
                            labelText: "Minimum Vehicles (5+ vehicles)",
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
              ])),
            ),

            const SizedBox(height: 14),

            /// DESCRIPTION
            Obx(() {
              descCtrl.text = couponType.value == "Long Booking"
                  ? "Discount for extended bookings (7+ days)"
                  : couponType.value == "Multi Vehicle"
                      ? "Discount for group bookings (5+ vehicles)"
                      : "General promotional discount";
              return TextField(
                controller: descCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Description (optional)",
                  border: OutlineInputBorder(),
                ),
              );
            }),

            const SizedBox(height: 10),

            /// GLOBAL
            Obx(() => CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("Allow this coupon to be used across all services"),
              value: isGlobal.value,
              onChanged: (v) => isGlobal.value = v ?? false,
            )),
          ]),
        ),
      ),
      actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
        ElevatedButton(
          onPressed: () {
            controller.addCoupon(
              code: codeCtrl.text.trim(),
              type: discountType.value.contains("Percentage") ? "PERCENTAGE" : "FLAT",
              value: int.tryParse(valueCtrl.text) ?? 0,
              limit: int.tryParse(usageCtrl.text) ?? 1,
              expiry: expiryCtrl.text,
              isGlobal: isGlobal.value,
            );
            Get.back();
          },
          child: const Text("Save Coupon"),
        ),
      ],
    );
  }
}
