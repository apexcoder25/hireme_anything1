import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/constants_file/app_vendor_side_urls.dart';
import 'package:hire_any_thing/data/exceptions/api_exception.dart';
import 'package:hire_any_thing/data/interceptors/error_interceptors.dart';
import 'package:hire_any_thing/data/services/base_api_services.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiServiceVenderSide implements BaseApiServices {
  late final Dio _dio;

  // Base URL for OTP and auth endpoints
  static const String _authBaseUrl = 'https://stag-api.hireanything.com';

  ApiServiceVenderSide() {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final options = BaseOptions(
      baseUrl: AppUrlsVendorSide.baseUrlVendorSideUrls2,
      headers: headers,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
      validateStatus: (status) => status != null && status < 500,
    );

    _dio = Dio(options);

    _dio.interceptors.addAll([
      ErrorInterceptor(),
      if (kDebugMode)
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
    ]);
  }

  void setRequestHeaders(Map<String, String> headers) {
    _dio.options.headers.addAll(headers);
  }

  @override
  Future<dynamic> getApi(String url, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<dynamic> postApi(String url, dynamic data, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.post(url, data: data, queryParameters: queryParameters);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<dynamic> patchApi(String url, dynamic data, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.patch(url, data: data, queryParameters: queryParameters);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<dynamic> putApi(String url, dynamic data,
      {Map<String, dynamic>? queryParameters, Map<String, String>? headers}) async {
    try {
      final response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: headers != null ? Options(headers: headers) : null,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<dynamic> deleteApi(String url, {dynamic data}) async {
    try {
      final response = await _dio.delete(url, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  dynamic _handleResponse(dio.Response response) {
    if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
      return response.data;
    } else {
      throw ApiException.fromDioError(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        ),
      );
    }
  }

  // ====================== OTP & EMAIL VERIFICATION METHODS ======================

  /// Send OTP to email for verification (used when changing email)
  Future<bool> sendOtpEmail(String email) async {
    try {
      final response = await Dio().post(
        '$_authBaseUrl/vendor/send-otp/',
        data: {"email": email},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "OTP sent successfully to $email");
        return true;
      }
    } on DioException catch (e) {
      Get.snackbar("Error", "Failed to send OTP: ${e.message}");
    } catch (e) {
      Get.snackbar("Error", "Network error while sending OTP");
    }
    return false;
  }

  /// Verify OTP for email
  Future<bool> verifyOtpEmail(String email, String otp) async {
    try {
      final response = await Dio().post(
        '$_authBaseUrl/vendor/verify-otp',
        data: {"email": email, "otp": otp},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Email verified successfully!");
        return true;
      } else {
        Get.snackbar("Failed", "Invalid OTP");
        return false;
      }
    } on DioException catch (e) {
      Get.snackbar("Error", "Verification failed: ${e.message}");
    } catch (e) {
      Get.snackbar("Error", "Network error during verification");
    }
    return false;
  }

  // ====================== COMPANY INFO APIs ======================

  Future<dynamic> getCompanyInfo(String token) async {
    try {
      final response = await _dio.get(
        'company-info',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<dynamic> saveCompanyInfo(String token, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        'company-info',
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<dynamic> updateCompanyInfo(String token, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(
        'company-info',
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}