import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/data/session_manage/session_user_side_manage.dart';
import 'package:hire_any_thing/res/routes/routes.dart';
import 'package:hire_any_thing/services/payment_services.dart';
import 'package:hire_any_thing/views/Book_Service/controllers/your_service_booking.dart';
import 'package:intl/intl.dart';

class PaymentController extends GetxController {
  final PaymentService _paymentService = Get.put(PaymentService());
  RxString selectedPaymentOption = ''.obs;

  Future<void> executePayPalPayment(
    String orderId,
    double amount,
    String token,
    YourServicesViewModel viewModel,
    String pickupDate,
    String pickupTime,
  ) async {
    // Validate and format pickupDate and pickupTime if needed
    final formattedPickupDate = _formatDate(pickupDate);
    final formattedPickupTime = _formatTime(pickupTime);

    if (formattedPickupDate == null || formattedPickupTime == null) {
      Get.snackbar(
        'Error',
        'Invalid date or time format',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final result = await _paymentService.executePayPalPayment(
      orderId: orderId,
      amount: amount,
    );
    handlePaymentResult(result, token, viewModel, formattedPickupTime, formattedPickupDate);
  }

  void handlePaymentResult(
    Map<String, dynamic> result,
    String token,
    YourServicesViewModel viewModel,
    String pickupTime,
    String pickupDate,
  ) async {
    if (result['success']) {
      final service = viewModel.service.value;
      if (service == null) {
        Get.snackbar(
          'Error',
          'Service data not available',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      double grandTotal = viewModel.totalAmount.value;
      double commissionPrice = grandTotal * 0.20; // 20% to company
      double vendorAmount = grandTotal * 0.80;    // 80% to vendor

      Map<String, dynamic> payload = {
        'booking_seats': 1,
        'cancellation_policy_type': service.cancellationPolicyType ?? "FLEXIBLE",
        'commission_price': commissionPrice,
        'distance': viewModel.distance,
        'drop_location': viewModel.toLocation,       // From YourServicesViewModel
        'grand_total': grandTotal,
        'payment_details': {
          'company_amount': commissionPrice,
          'vendor_amount': vendorAmount,
          'payment_status': "completed",
        },
        'paypal_details': {
          'id': result['orderId'],
          'intent': "CAPTURE",
          'status': "COMPLETED",
        },
        'paypal_order_id': result['orderId'],
        'pickup_date': pickupDate, // Use formatted YYYY-MM-DD
        'pickup_location': viewModel.fromLocation,   // From YourServicesViewModel
        'pickup_time': pickupTime, // Use formatted HH:MM
        'serviceId': service.id,
        'userId': await SessionManageerUserSide().getUserId(),
        'vendorId': service.vendorId.id,
        'vendor_amount': vendorAmount,
      };

      final bookingResult = await _paymentService.createBooking(token, payload);
      print('Booking Result: $bookingResult');
      if (bookingResult['success']) {
        int otp = Random().nextInt(9000) + 1000;
        Get.offAllNamed(UserRoutesName.paymentSuccess, arguments: {
          'orderId': result['orderId'],
          'otp': otp,
        });
      } else {
        Get.snackbar(
          'Booking Error',
          bookingResult['error'] ?? 'Unknown error occurred',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        'Payment Error',
        result['error'] ?? 'Unknown error occurred',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Format pickupDate to YYYY-MM-DD
  String? _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return null;
    try {
      final dateParts = dateStr.split('-');
      if (dateParts.length == 3) {
        final day = int.parse(dateParts[0]);
        final month = int.parse(dateParts[1]);
        final year = int.parse(dateParts[2]);
        return DateFormat('yyyy-MM-dd').format(DateTime(year, month, day));
      }
      return DateFormat('yyyy-MM-dd').parse(dateStr).toIso8601String().split('T')[0];
    } catch (e) {
      print("Error formatting date $dateStr: $e");
      return null;
    }
  }

  // Format pickupTime to HH:MM
  String? _formatTime(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty) return null;
    try {
      final timeParts = timeStr.split(':');
      if (timeParts.length == 2) {
        final hours = int.parse(timeParts[0].replaceAll(RegExp(r'[^0-9]'), ''));
        final minutes = int.parse(timeParts[1].replaceAll(RegExp(r'[^0-9]'), ''));
        if (hours >= 0 && hours <= 23 && minutes >= 0 && minutes <= 59) {
          return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
        }
      }
      return timeStr; // Return original if parsing fails but string looks valid
    } catch (e) {
      print("Error formatting time $timeStr: $e");
      return null;
    }
  }
}