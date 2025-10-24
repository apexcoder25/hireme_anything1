import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';

class AddVendorServiceApi {
  late final Dio _dio;

  final Map<String, String> endpoints = {
    'boat': '/vendor/add_boat_service',
    'chauffeur': '/vendor/add_chauffeur_service',
    'coach': '/vendor/add_coach_service',
    'funeral': '/vendor/add-funeral-partner',
    'horseCarriage': '/vendor/add_horse_carriage_service',
    'limousine': '/vendor/add-limousine-partner',
    'minibus': '/vendor/add_minibus_service',
  };

  AddVendorServiceApi() {
    final options = BaseOptions(
      baseUrl: 'https://stag-api.hireanything.com',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      responseType: ResponseType.json,
    );

    _dio = Dio(options);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {

          final token = await SessionVendorSideManager().getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          
          print('REQUEST[${options.method}] => PATH: ${options.path}');
          print('REQUEST HEADERS: ${options.headers}');
          print('REQUEST DATA: ${options.data}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          print('RESPONSE[${response.statusCode}] => DATA: ${response.data}');
          handler.next(response);
        },
        onError: (error, handler) async {
          print('ERROR[${error.response?.statusCode}] => MESSAGE: ${error.message}');
          print('ERROR DATA: ${error.response?.data}');
          
          // Clear session if token is invalid
          if (error.response?.statusCode == 401) {
            await SessionVendorSideManager().clearSession();
          }
          
          handler.next(error);
        },
      ),
    );

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
        enabled: kDebugMode,
      ),
    );
  }

  Future<bool> addServiceVendor(Map<String, dynamic> data, String serviceType) async {
    print("Starting API call...");
    print('data hai $data');
    try {
      String? endpoint = endpoints[serviceType];
      print('endpoint hai $endpoint');

      final response = await _dio.post(
        endpoint!,
        data: data,
      );
      print('data ye hai $data');

      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 201) {
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
        String errorMessage = "Failed to add vendor service: ${response.statusMessage}";
        if (response.data != null && response.data is Map) {
          errorMessage = response.data['message'] ?? errorMessage;
        }
        Get.snackbar(
          "Error",
          errorMessage,
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
      String errorMessage;
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          errorMessage = "Connection timeout - Please check your internet connection";
          break;
        case DioExceptionType.receiveTimeout:
          errorMessage = "Request timeout - Server took too long to respond";
          break;
        case DioExceptionType.badResponse:
          if (e.response?.statusCode == 401) {
            // Clear session when authentication fails
            await SessionVendorSideManager().clearSession();
            errorMessage = "Authentication failed - Please login again";
          } else if (e.response?.statusCode == 400) {
            errorMessage = e.response?.data?['message'] ?? "Invalid request data";
          } else if (e.response?.statusCode == 422) {
            errorMessage = "Validation failed - Please check your input data";
          } else {
            errorMessage = "Server error (${e.response?.statusCode}): ${e.response?.statusMessage}";
          }
          break;
        case DioExceptionType.cancel:
          errorMessage = "Request was cancelled";
          break;
        case DioExceptionType.unknown:
          errorMessage = "Network error - Please check your connection";
          break;
        default:
          errorMessage = e.message ?? "An unexpected error occurred";
      }

      Get.snackbar(
        "Error",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        borderRadius: 8.0,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      );
      return false;
    } catch (e) {
      print('Unexpected error: $e');
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
