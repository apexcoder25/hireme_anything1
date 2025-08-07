import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AddVendorServiceApi {
  late final Dio _dio;

  final Map<String, String> endpoints = {
    'boat': '/vendor/add_boat_hire_service',
    'chauffeur': '/vendor/add_chauffeur_service',
    'coach': '/vendor/add_coach_service',
    'funeral': '/vendor/add-funeral-partner',
    'horseCarriage': '/vendor/add-horse-partner',
    'limousine': '/vendor/add-limousine-partner',
    'minibus': '/vendor/add_minibus_service',
  };

  AddVendorServiceApi() {
    final options = BaseOptions(
      baseUrl: 'https://stag-api.hireanything.com',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3N2ZhZGY0MTM2NmU2ZjMzMDMwMDFkYSIsImlhdCI6MTc1NDE0MDUwNiwiZXhwIjoxNzU0NzQ1MzA2fQ.EgQEldM6P0hw_jbvOtaOWpdRl-4_NJ-x--8qfTj4X94'
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
        enabled: kDebugMode,
      ),
    );

    // Add custom interceptor for detailed logging
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print('REQUEST[${options.method}] => PATH: ${options.path}');
        print('REQUEST HEADERS: ${options.headers}');
        print('REQUEST DATA: ${options.data}');
        handler.next(options);
      },
      onResponse: (response, handler) {
        print('RESPONSE[${response.statusCode}] => DATA: ${response.data}');
        handler.next(response);
      },
      onError: (error, handler) {
        print(
            'ERROR[${error.response?.statusCode}] => MESSAGE: ${error.message}');
        print('ERROR DATA: ${error.response?.data}');
        handler.next(error);
      },
    ));
  }

  Future<bool> addServiceVendor(Map<String, dynamic> data, String serviceType) async {
    print("Starting API call...");
    print('data hai $data');
    try {
      // print("Sending POST request to /vendor/add_chauffeur_service");

      String? endpoint = endpoints[serviceType];
      print('enpoint hai  $endpoint');

      final response = await _dio.post(
        endpoint!,
        data: data,
      );
      print('data ye hai $data');

      print('Response status code: ${response.statusCode}');
      // print('Response data: ${response.data}');
      // print('Response data: ${response}');

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
        String errorMessage =
            "Failed to add vendor service: ${response.statusMessage}";
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
      // print('DioException occurred: ${e.type}');
      // print('Error message: ${e.message}');
      // print('Error response: ${e.response?.data}');

      String errorMessage;
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          errorMessage =
              "Connection timeout - Please check your internet connection";
          break;
        case DioExceptionType.receiveTimeout:
          errorMessage = "Request timeout - Server took too long to respond";
          break;
        case DioExceptionType.badResponse:
          if (e.response?.statusCode == 401) {
            errorMessage = "Authentication failed - Please login again";
          } else if (e.response?.statusCode == 400) {
            errorMessage =
                e.response?.data?['message'] ?? "Invalid request data";
          } else if (e.response?.statusCode == 422) {
            errorMessage = "Validation failed - Please check your input data";
          } else {
            errorMessage =
                "Server error (${e.response?.statusCode}): ${e.response?.statusMessage}";
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
