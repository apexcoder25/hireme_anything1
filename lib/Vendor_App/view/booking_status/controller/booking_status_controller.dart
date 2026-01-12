import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/constants_file/app_vendor_side_urls.dart';
import 'package:hire_any_thing/data/exceptions/api_exception.dart';
import 'package:hire_any_thing/data/services/api_service_vendor_side.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';

import '../../../../data/models/vender_side_model/booking_status_model.dart';


class BookingController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<Booking> bookings = <Booking>[].obs;
  final RxString errorMessage = ''.obs;

  final ApiServiceVenderSide _apiService = ApiServiceVenderSide();
  final SessionVendorSideManager _sessionManager = SessionVendorSideManager();

  // Filter: 'pending', 'completed', 'cancelled'
  final RxString selectedFilter = 'pending'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      String? token = await _sessionManager.getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Authentication token not found';
        isLoading.value = false;
        return;
      }

      _apiService.setRequestHeaders({'Authorization': 'Bearer $token'});
      final response = await _apiService.getApi(AppUrlsVendorSide.vendorBookingsUrl);

      final bookingModel = BookingStatusVendorModel.fromJson(response);
      bookings.assignAll(bookingModel.bookings);

      print('Loaded ${bookings.length} bookings'); // Debug
    } on ApiException catch (e) {
      errorMessage.value = e.message ?? 'Failed to load bookings';
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // Add this method to your BookingController class

Future<void> acceptBooking(String bookingId) async {
  try {
    // Show loading if you want (optional)
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    String? token = await _sessionManager.getToken();
    if (token == null || token.isEmpty) {
      Get.back(); // close dialog
      Get.snackbar('Error', 'Authentication required');
      return;
    }

    _apiService.setRequestHeaders({'Authorization': 'Bearer $token'});

    final response = await _apiService.postApi(
      '${AppUrlsVendorSide.baseUrlVendorSideUrls2}/booking/accept/$bookingId',
      {}, // empty body if required by API
    );

    Get.back(); // close loading dialog

    if (response['message'] != null) {
      Get.snackbar(
        'Success',
        response['message'],
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Refresh the list
      await fetchBookings();
    }
  } catch (e) {
    Get.back(); // close dialog if open
    Get.snackbar(
      'Error',
      'Failed to accept booking. Please try again.',
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}

// Add to BookingController

Future<void> markCompleteBooking(String bookingId, String otp) async {
  try {
    Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);

    String? token = await _sessionManager.getToken();
    if (token == null) {
      Get.back();
      Get.snackbar('Error', 'Authentication required');
      return;
    }

    _apiService.setRequestHeaders({'Authorization': 'Bearer $token'});

    final payload = {
      "status": {"service": "completed"},
      "otp": otp,
      "serviceType": "bouncyCastle" // Adjust if dynamic later
    };

    final response = await _apiService.putApi(
      '${AppUrlsVendorSide.baseUrlVendorSideUrls2}update-booking-status/$bookingId',
      payload,
    );

    Get.back(); // close loading

    if (response['message']?.toString().toLowerCase().contains('success') == true ||
        response['message'] == null) {
      Get.snackbar('Success', 'Booking marked as complete', backgroundColor: Colors.green, colorText: Colors.white);
      await fetchBookings();
    } else {
      Get.snackbar('Failed', response['message'] ?? 'Invalid OTP', backgroundColor: Colors.red, colorText: Colors.white);
    }
  } catch (e) {
    Get.back();
    Get.snackbar('Error', 'Failed to update status', backgroundColor: Colors.red, colorText: Colors.white);
  }
}

Future<void> cancelBooking(String bookingId) async {
  try {
    Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);

    String? token = await _sessionManager.getToken();
    if (token == null) {
      Get.back();
      Get.snackbar('Error', 'Authentication required');
      return;
    }

    _apiService.setRequestHeaders({'Authorization': 'Bearer $token'});

    final response = await _apiService.postApi(
      '${AppUrlsVendorSide.baseUrlVendorSideUrls2}booking/cancel/$bookingId',
      {}, // empty body
    );

    Get.back();

    if (response['message']?.toString().toLowerCase().contains('success') == true ||
        response['message'] == null) {
      Get.snackbar('Success', 'Booking cancelled', backgroundColor: Colors.green, colorText: Colors.white);
      await fetchBookings();
    } else {
      Get.snackbar('Failed', response['message'] ?? 'Cancellation failed', backgroundColor: Colors.red, colorText: Colors.white);
    }
  } catch (e) {
    Get.back();
    Get.snackbar('Error', 'Failed to cancel booking', backgroundColor: Colors.red, colorText: Colors.white);
  }
}

Future<void> refreshBookings() => fetchBookings();

  // Helper for summary counts
  int get pendingCount => bookings.where((b) => b.displayStatus == 'pending').length;
  int get completedCount => bookings.where((b) => b.displayStatus == 'completed').length;
  int get cancelledCount => bookings.where((b) => b.displayStatus == 'cancelled').length;
double get totalRevenue {
  double sum = bookings.fold(0.0, (s, b) => s + b.displayAmount);
  return double.parse(sum.toStringAsFixed(2));
}}