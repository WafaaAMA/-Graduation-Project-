import 'package:dio/dio.dart';
import 'package:medical_center/Core/api/api_consumer.dart';
import 'package:medical_center/Core/api/api_interceptor.dart';
import 'package:medical_center/Core/api/endpoints.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = Endpoints.baseUrl;
    dio.interceptors.add(ApiInterceptor());
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      logPrint: (object) => print('Dio: $object'),
    ));
  }

  @override
  Future<dynamic> delete(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      print('Sending DELETE request to: ${Endpoints.baseUrl}$path');
      final response = await dio.delete(path,
          data: data, queryParameters: queryParameters);
      print('Received DELETE response: ${response.data}');
      return response.data;
    } on DioException catch (e) {
      print('DELETE request failed: ${e.message}, URL: ${Endpoints.baseUrl}$path');
      throw _handleDioError(e);
    }
  }

  @override
  Future<dynamic> get(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      print('Sending GET request to: ${Endpoints.baseUrl}$path');
      final response = await dio.get(path,
          data: data, queryParameters: queryParameters);
      print('Received GET response: ${response.data}');
      return response.data;
    } on DioException catch (e) {
      print('GET request failed: ${e.message}, URL: ${Endpoints.baseUrl}$path');
      throw _handleDioError(e);
    }
  }

  @override
  Future<dynamic> patch(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      print('Sending PATCH request to: ${Endpoints.baseUrl}$path');
      final response = await dio.patch(path,
          data: data, queryParameters: queryParameters);
      print('Received PATCH response: ${response.data}');
      return response.data;
    } on DioException catch (e) {
      print('PATCH request failed: ${e.message}, URL: ${Endpoints.baseUrl}$path');
      throw _handleDioError(e);
    }
  }

  @override
  Future<dynamic> post(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      print('Sending POST request to: ${Endpoints.baseUrl}$path with data: $data');
      final response = await dio.post(path,
          data: data, queryParameters: queryParameters);
      print('Received POST response: ${response.data}');
      return response.data;
    } on DioException catch (e) {
      print('POST request failed: ${e.message}, URL: ${Endpoints.baseUrl}$path');
      throw _handleDioError(e);
    }
  }

  @override
  Future<dynamic> put(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      print('Sending PUT request to: ${Endpoints.baseUrl}$path');
      final response = await dio.put(path,
          data: data, queryParameters: queryParameters);
      print('Received PUT response: ${response.data}');
      return response.data;
    } on DioException catch (e) {
      print('PUT request failed: ${e.message}, URL: ${Endpoints.baseUrl}$path');
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    print('Handling Dio error: ${e.response?.data}');
    if (e.response != null) {
      final statusCode = e.response?.statusCode;
      final data = e.response?.data;
      String message = 'API error: $statusCode';
      if (data is Map<String, dynamic>) {
        message = data['message']?.toString() ??
            data['error']?.toString() ??
            'Unknown API error';
      } else if (data is String) {
        message = data;
      }
      if (statusCode == 401) {
        message = 'Unauthorized: Invalid or missing token';
      } else if (statusCode == 400 && message.toLowerCase().contains('exceeded')) {
        message = 'Booking limit exceeded';
      } else if (statusCode == 404) {
        message = 'Resource not found: Requested endpoint or resource does not exist';
      }
      return Exception('$message (Status: $statusCode)');
    } else {
      return Exception('Network error: ${e.message ?? 'Unknown error'}');
    }
  }
}