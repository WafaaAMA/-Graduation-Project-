import 'package:dio/dio.dart';
import 'package:medical_center/Core/api/database/cachehelper.dart';
// import 'package:medical_center/Core/api/api_key.dart';
import 'package:medical_center/Core/api/endpoints.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = CacheHelper.getData(key: ApiKey.token);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
      print('ApiInterceptor: Added Bearer token to request');
    } else {
      print('ApiInterceptor: No token found for request');
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException e, ErrorInterceptorHandler handler) {
    print('ApiInterceptor: Error occurred - ${e.response?.data ?? e.message}');
    super.onError(e, handler);
  }
}