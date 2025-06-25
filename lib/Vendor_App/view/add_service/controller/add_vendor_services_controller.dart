import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AddVendorServiceApi {
  late final Dio _dio;

  AddVendorServiceApi() {
    // Initialize Dio with base options
    final options = BaseOptions(
      baseUrl: 'https://api.hireanything.com',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      responseType: ResponseType.json,
    );

    _dio = Dio(options);

    // Add PrettyDioLogger for logging
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode, // Only log in debug mode
      ),
    );
  }

  Future<bool> addServiceVendor(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        '/vendor/add_vendor_service',
        data: data,
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "Vendor service added successfully",
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
          "Failed to add vendor service: ${response.statusMessage}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          borderRadius: 8.0,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
        );
        return false;
      }
    } on DioException catch (e) {
      // PrettyDioLogger will log the error details
      Get.snackbar(
        "Error",
        e.message ?? "Some Error Occurred!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        borderRadius: 8.0,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      );
      return false;
    } catch (e) {
      Get.snackbar(
        "Error",
        "Unexpected Error: $e",
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