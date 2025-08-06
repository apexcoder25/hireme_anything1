import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DeleteVendorServiceApi {
  late final Dio _dio;

  DeleteVendorServiceApi() {
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

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // print('DELETE REQUEST[${options.method}] => PATH: ${options.path}');
        // print('REQUEST HEADERS: ${options.headers}');
        // print('REQUEST DATA: ${options.data}');
        handler.next(options);
      },
      onResponse: (response, handler) {
        print(
            'DELETE RESPONSE[${response.statusCode}] => DATA: ${response.data}');
        handler.next(response);
      },
      onError: (error, handler) {
        print(
            'DELETE ERROR[${error.response?.statusCode}] => MESSAGE: ${error.message}');
        print('DELETE ERROR DATA: ${error.response?.data}');
        handler.next(error);
      },
    ));
  }

  Future<bool> deleteVendorService(String serviceId) async {
    print("Starting delete API call for serviceId: $serviceId");

    try {
      final payload = {"serviceId": serviceId};

      final response = await _dio.delete(
        '/vendor/delete_vendore_service',
        data: payload,
      );

      // print('Delete response status code: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        Get.snackbar(
          "Success",
          "Service deleted successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color.fromARGB(255, 5, 129, 69),
          colorText: Colors.white,
          borderRadius: 8.0,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
          icon: const Icon(Icons.check_circle, color: Colors.white),
        );
        return true;
      } else {
        String errorMessage = "Failed to delete service";
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
          icon: const Icon(Icons.error, color: Colors.white),
        );
        return false;
      }
    } on DioException catch (e) {
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
                e.response?.data?['message'] ?? "Invalid service ID or request";
          } else if (e.response?.statusCode == 404) {
            errorMessage = "Service not found or already deleted";
          } else if (e.response?.statusCode == 403) {
            errorMessage = "You don't have permission to delete this service";
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
        "Delete Failed",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        borderRadius: 8.0,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 4),
        icon: const Icon(Icons.error_outline, color: Colors.white),
      );
      return false;
    } catch (e) {
      print('Unexpected error during deletion: $e');
      Get.snackbar(
        "Error",
        "Unexpected error occurred while deleting service: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        borderRadius: 8.0,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.warning, color: Colors.white),
      );
      return false;
    }
  }

  Future<bool> showDeleteConfirmation(
      BuildContext context, String serviceName) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: Row(
                children: [
                  Icon(Icons.warning, color: Colors.red, size: 24),
                  SizedBox(width: 10),
                  Text(
                    "Delete Service",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Are you sure you want to delete this service?",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      serviceName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "This action cannot be undone.",
                    style: TextStyle(
                      color: Colors.red.shade600,
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text("Delete"),
                ),
              ],
            );
          },
        ) ??
        false;
  }
}
