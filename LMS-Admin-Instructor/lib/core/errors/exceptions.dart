import 'package:dio/dio.dart';
import 'package:lms_admin_instructor/core/errors/error_model.dart';

class DioExceptionHandler {
  static String handleException(DioException e) {
    
    if (e.response != null) {
      
      try {
        final errorModel = ErrorModel.fromJson(
          e.response?.data ?? {},
        );
        
        final serverMessage = errorModel.message;
        
        switch (e.response?.statusCode) {
          case 400:
            return 'Bad request: $serverMessage';
          case 401:
            return 'Unauthorized: $serverMessage';
          case 403:
            return 'Forbidden: $serverMessage';
          case 404:
            return 'Not found: $serverMessage';
          case 409:
            return 'Conflict: $serverMessage'; 
          case 422:
            return 'Validation error: $serverMessage';
          case 500:
            return 'Server error, please try again later';
          case 502:
          case 503:
            return 'Service unavailable, please try again later';
          default:
            return serverMessage;
        }
      } catch (err) {
        
        try {
          if (e.response?.data is Map) {
            final data = e.response?.data as Map;
            if (data.containsKey('message')) {
              return data['message'].toString();
            }
          }
        } catch (_) {}
        
        return 'Server error (${e.response?.statusCode})';
      }
    }
    
    // network error handling
    switch (e.type) {
      case DioExceptionType.connectionError:
      case DioExceptionType.connectionTimeout:
        return 'No internet connection. Please check your network.';
        
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return 'Server is taking too long to respond. Please try again.';
        
      case DioExceptionType.cancel:
        return 'Request was cancelled';
        
      case DioExceptionType.badCertificate:
        return 'Security certificate error';
        
      case DioExceptionType.badResponse:
        return 'Unexpected response from server';
        
      default:
        return 'Network error: ${e.message}';
    }
  }
}