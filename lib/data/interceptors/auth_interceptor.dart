// import 'dart:developer';

// import 'package:dio/dio.dart';


// class AuthInterceptor extends Interceptor {
//   @override
//   Future<void> onRequest(
//     RequestOptions options,
//     RequestInterceptorHandler handler,
//   ) async {
//     if (options.headers["Authorization"] == null && auth.currentUser != null) {
//       String? newAccessToken = await auth.currentUser!.getIdToken();
//       options.headers['Authorization'] = 'Bearer $newAccessToken';
//     }
//     log(options.headers["Authorization"]);
//     super.onRequest(options, handler);
//   }
// }
