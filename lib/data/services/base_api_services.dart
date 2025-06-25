abstract class BaseApiServices {
  Future<dynamic> getApi(String url, {Map<String, dynamic>? queryParameters});

  Future<dynamic> postApi(String url, dynamic data, {Map<String, dynamic>? queryParameters});

  Future<dynamic> patchApi(String url, dynamic data, {Map<String, dynamic>? queryParameters});

  Future<dynamic> putApi(String url, dynamic data, {Map<String, dynamic>? queryParameters});

  Future<dynamic> deleteApi(String url, {dynamic data});
}