import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hire_any_thing/constants_file/app_user_side_urls.dart';
import 'package:hire_any_thing/constants_file/app_vendor_side_urls.dart';
import 'package:hire_any_thing/data/exceptions/api_exception.dart';
import 'package:hire_any_thing/data/interceptors/error_interceptors.dart';
import 'package:hire_any_thing/data/services/base_api_services.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiServiceVenderSide implements BaseApiServices {
  late final Dio _dio;

  ApiServiceVenderSide() {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final options = BaseOptions(
      baseUrl: AppUrlsVendorSide.baseUrlVendorSideUrls,
      headers: headers,
      connectTimeout: AppUrlsUserSide.connectionTimeout,
      receiveTimeout: AppUrlsUserSide.receiveTimeout,
      responseType: ResponseType.json,
      validateStatus: (status) {
        return status != null && status < 500;
      },
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
          enabled: kDebugMode,
        ),
    ]);
  }

  void setRequestHeaders(Map<String, String> headers) {
    _dio.options.headers.addAll(headers);
  }

  @override
  Future<dynamic> getApi(String url, {Map<String, dynamic>? queryParameters}) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException.fromDioError(
          DioException(requestOptions: RequestOptions(path: url), error: e));
    }
  }

  @override
  Future<dynamic> postApi(String url, dynamic data,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException.fromDioError(
          DioException(requestOptions: RequestOptions(path: url), error: e));
    }
  }

  @override
  Future<dynamic> patchApi(String url, dynamic data,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final Response response = await _dio.patch(
        url,
        data: data,
        queryParameters: queryParameters,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException.fromDioError(
          DioException(requestOptions: RequestOptions(path: url), error: e));
    }
  }

  @override
  Future<dynamic> putApi(String url, dynamic data,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException.fromDioError(
          DioException(requestOptions: RequestOptions(path: url), error: e));
    }
  }

  @override
  Future<dynamic> deleteApi(String url, {dynamic data}) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException.fromDioError(
          DioException(requestOptions: RequestOptions(path: url), error: e));
    }
  }

  dynamic _handleResponse(Response response) {
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
}