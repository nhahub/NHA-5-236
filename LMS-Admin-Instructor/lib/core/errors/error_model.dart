import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';

class ErrorModel {
  final String message;

  ErrorModel({required this.message});
  
  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    return ErrorModel(
      message: jsonData[ApiKey.message] ?? 'Unknown error',
    );
  }
}