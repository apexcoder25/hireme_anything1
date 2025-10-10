import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/data/session_manage/session_user_side_manage.dart';
import 'package:hire_any_thing/payment/payment_controller.dart';
import 'package:hire_any_thing/res/routes/routes.dart';
import 'package:hire_any_thing/User_app/views/Book_Service/controllers/your_service_booking.dart';

class PaymentButtons extends StatefulWidget {
  final YourServicesViewModel viewModel;
  final String pickupTime;
  final String pickupDate;

  const PaymentButtons({super.key, required this.viewModel, required this.pickupTime, required this.pickupDate});

  @override
  State<PaymentButtons> createState() => _PaymentButtonsState();
}

class _PaymentButtonsState extends State<PaymentButtons> {
  final SessionManageerUserSide session = SessionManageerUserSide();
  String usertoken = "";
  final PaymentController paymentController = Get.put(PaymentController());

  @override
  void initState() {
    super.initState();
    getToken();
  }

  Future<void> getToken() async {
    final token = await session.getToken() ?? "";
    print("Retrieved user token: $token");
    setState(() {
      usertoken = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              if (usertoken.isEmpty) {
                Get.toNamed(UserRoutesName.loginUserView);
              } else {
                String orderId = "ORD-${DateTime.now().millisecondsSinceEpoch}";
                double totalAmount = widget.viewModel.totalAmount.value;
                // Pass token and viewModel to match the updated PaymentController
                await paymentController.executePayPalPayment(
                  orderId,
                  totalAmount,
                  usertoken,
                  widget.viewModel,
                  widget.pickupDate,
                  widget.pickupTime
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              'PayPal',
              style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Clear cart logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              'Clear Cart',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}