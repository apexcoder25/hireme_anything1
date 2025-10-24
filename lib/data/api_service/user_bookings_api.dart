import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/constants_file/app_user_side_urls.dart';
import 'package:hire_any_thing/data/models/user_side_model/user_booking_model.dart';
import 'package:hire_any_thing/data/services/api_service.dart';
import 'package:hire_any_thing/data/session_manage/session_user_side_manage.dart'; // Add this import

class UserBookingApi {
  final ApiService _apiService = ApiService();

  // Fetch user bookings
  Future<List<BookingDetails>> getUserBookings() async {
    try {
      // Use session manager instead of direct SharedPreferences
      final sessionManager = SessionManageerUserSide();
      final token = await sessionManager.getToken();

      if (token.isEmpty) {
        Get.snackbar(
          "Error",
          "Session expired. Please login again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          borderRadius: 8.0,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
        );
        return [];
      }

      _apiService.setRequestHeaders({"Authorization": "Bearer $token"});

      final response = await _apiService.getApi(
        AppUrlsUserSide.userBookings,
      );

      print('Booking Response: $response');

      if (response != null && response is List) {
        List<BookingDetails> bookings =
            response.map((json) => BookingDetails.fromJson(json)).toList();
        return bookings;
      } else {
        // Get.snackbar(
        //   "Error",
        //   "Failed to fetch bookings",
        //   snackPosition: SnackPosition.BOTTOM,
        //   backgroundColor: Colors.redAccent,
        //   colorText: Colors.white,
        //   borderRadius: 8.0,
        //   margin: const EdgeInsets.all(16),
        //   duration: const Duration(seconds: 3),
        // );
        return [];
      }
    } catch (e) {
      print("Booking Fetch Error: $e");
      Get.snackbar(
        "Error",
        "Some Error Occurred: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        borderRadius: 8.0,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      );
      return [];
    }
  }

  // Create a new booking
  Future<bool> createBooking(Map<String, dynamic> bookingData) async {
    try {
      final sessionManager = SessionManageerUserSide();
      final token = await sessionManager.getToken();

      if (token == null || token.isEmpty) {
        Get.snackbar(
          "Error",
          "Session expired. Please login again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          borderRadius: 8.0,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
        );
        return false;
      }

      _apiService.setRequestHeaders({"Authorization": "Bearer $token"});

      final response = await _apiService.postApi(
        AppUrlsUserSide.createBooking,
        bookingData,
      );

      print('Create Booking Response: $response');

      if (response != null && response["status"] == true) {
        Get.snackbar(
          "Success",
          "Booking created successfully.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color.fromARGB(255, 5, 129, 69),
          colorText: Colors.white,
          borderRadius: 8.0,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
        );
        return true;
      } else {
        Get.snackbar(
          "Error",
          response?["message"] ?? "Failed to create booking",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          borderRadius: 8.0,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
        );
        return false;
      }
    } catch (e) {
      print("Create Booking Error: $e");
      Get.snackbar(
        "Error",
        "Some Error Occurred: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        borderRadius: 8.0,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      );
      return false;
    }
  }

  Future<bool> cancelBooking(String bookingId) async {
    try {
      final sessionManager = SessionManageerUserSide();
      final token = await sessionManager.getToken();

      if (token == null || token.isEmpty) {
        Get.snackbar(
          "Error",
          "Session expired. Please login again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          borderRadius: 8.0,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
        );
        return false;
      }

      _apiService.setRequestHeaders({"Authorization": "Bearer $token"});

      final response = await _apiService.postApi(
        "${AppUrlsUserSide.cancelBooking}/$bookingId",
        {"booking_status": "cancelled"},
      );

      print('Cancel Booking Response: $response');

      if (response != null && response["status"] == true) {
        Get.snackbar(
          "Success",
          "Booking cancelled successfully.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color.fromARGB(255, 5, 129, 69),
          colorText: Colors.white,
          borderRadius: 8.0,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
        );
        return true;
      } else {
        Get.snackbar(
          "Error",
          response?["message"] ?? "Failed to cancel booking",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          borderRadius: 8.0,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
        );
        return false;
      }
    } catch (e) {
      print("Cancel Booking Error: $e");
      Get.snackbar(
        "Error",
        "Some Error Occurred: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        borderRadius: 8.0,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      );
      return false;
    }
  }
}
