import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorTitle = "Error";
    String errorMessage = "An unexpected error occurred";

    if (err.type == DioExceptionType.connectionTimeout) {
      errorMessage = "Connection Timeout";
    }

    if (err.response != null) {
      switch (err.response!.statusCode) {
        case 400:
          errorTitle = "Bad Request";
          errorMessage = '${err.response?.data['message'] ?? 'Bad Request'}';
          break;
        case 401:
          errorTitle = "Unauthorized";
          errorMessage = '${err.response?.data['message'] ?? 'Unauthorized'}';
          break;
       
      }
    }

    if (err.response?.statusCode == 401) {
      rootScaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text("$errorTitle: $errorMessage")),
      );
    }

    handler.next(err);
  }
}