import 'package:dartz/dartz.dart';

abstract class ApiConsumer {
  Future<Either<String, T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
  });

  Future<Either<String, T>> getRaw<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  });
  Future<Either<String, T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    Duration? sendTimeout,
    Duration? receiveTimeout,
    void Function(int sent, int total)? onSendProgress,
    T Function(Map<String, dynamic>)? fromJson,
  });
  Future<Either<String, T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    Duration? sendTimeout,
    Duration? receiveTimeout,
    void Function(int sent, int total)? onSendProgress,
    T Function(Map<String, dynamic>)? fromJson,
  });
  Future<Either<String, T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    Duration? sendTimeout,
    Duration? receiveTimeout,
    void Function(int sent, int total)? onSendProgress,
    T Function(Map<String, dynamic>)? fromJson,
  });
  Future<Either<String, T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    Duration? sendTimeout,
    Duration? receiveTimeout,
    T Function(Map<String, dynamic>)? fromJson,
  });

  Future<dynamic> multipartFileFromPath(String path, {String? filename});
  dynamic multipartFileFromBytes(List<int> bytes, {String? filename});
}
