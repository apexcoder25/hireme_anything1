import 'dart:async';

import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class PaymentService extends GetxService {
  // Existing PayPal client IDs and secrets...
  final String paypalClientId = "AfyWfKvmesOqx2dtjnJZ2jEBTyav61ymSB8OsjNUbpDV_07_V7trOfmqW8JegBU9ENrD3qd8nUY09NaL";
  final String paypalSecret = "EHzPCJ63App8C7IkYVwV5imImTUDAfGqF9OTBr1TxXcz9FFV3rPnk4TBwUycYGqUX-aOM3TcQWdzMnnl";
  final String paypalBnCode = "HireAnything_SP";
  final String paypalClientSecret = "EHzPCJ63App8C7IkYVwV5imImTUDAfGqF9OTBr1TxXcz9FFV3rPnk4TBwUycYGqUX-aOM3TcQWdzMnnl";

  Future<Map<String, dynamic>> executePayPalPayment({
    required String orderId,
    required double amount,
  }) async {
    final completer = Completer<Map<String, dynamic>>();
    // Existing PayPal execution code...
    Get.to(() => PaypalCheckout(
      sandboxMode: true,
      clientId: paypalClientId,
      secretKey: paypalSecret,
      returnURL: "success.snippetcoder.com",
      cancelURL: "cancel.snippetcoder.com",
      transactions: [
        {
          "amount": {
            "total": amount.toStringAsFixed(2),
            "currency": "GBP",
            "details": {
              "subtotal": amount.toStringAsFixed(2),
              "shipping": "0",
              "shipping_discount": 0
            }
          },
          "description": "Payment for Order #$orderId",
          "item_list": {
            "items": [
              {
                "name": "Order #$orderId",
                "quantity": "1",
                "price": amount.toStringAsFixed(2),
                "currency": "GBP"
              }
            ],
          }
        }
      ],
      note: "Payment for order",
      onSuccess: (Map params) {
        print("Payment Success: $params");
        completer.complete({'success': true, 'orderId': params['orderId'] ?? orderId});
        Get.back();
      },
      onError: (error) {
        print("Payment Error: $error");
        completer.complete({'success': false, 'error': error.toString()});
        Get.back();
      },
      onCancel: () {
        print("Payment Cancelled");
        completer.complete({'success': false, 'error': "Payment Cancelled"});
        Get.back();
      },
    ));
    return completer.future;
  }

  Future<Map<String, dynamic>> createBooking(String token, Map<String, dynamic> payload) async {
    final response = await http.post(
      Uri.parse('https://api.hireanything.com/user/booking-with-split-payment'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(payload),
    );
    if (response.statusCode == 200) {
      return {'success': true, 'data': jsonDecode(response.body)};
    } else {
      return {'success': false, 'error': 'Failed to create booking: ${response.body}'};
    }
  }
}