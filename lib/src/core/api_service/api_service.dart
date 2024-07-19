import 'dart:developer';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    // Set up base URL and timeouts
    _dio.options.connectTimeout = const Duration(seconds: 5); // 5 seconds
    _dio.options.receiveTimeout = const Duration(seconds: 3); // 3 seconds

    // Add interceptors
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Modify request before sending
        log('Request: ${options.method} ${options.uri}');
        return handler.next(options); // Continue with request
      },
      onResponse: (response, handler) {
        // Modify response before returning
        log('Response: ${response.statusCode} ${response.requestOptions.uri}');
        return handler.next(response); // Continue with response
      },
      onError: (DioException e, handler) {
        // Handle errors
        log('Error: ${e.message}');
        return handler.next(e); // Continue with error
      },
    ));
  }

  Future<Response> get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return response;
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }
}
