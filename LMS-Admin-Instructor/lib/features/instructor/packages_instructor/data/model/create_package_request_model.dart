import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';

class CreatePackageRequestModel {
  final String title;
  final String description;
  final String price;
  final List<String> courses;

  CreatePackageRequestModel({
    required this.title,
    required this.description,
    required this.price,
    required this.courses,
  });

  Map<String, dynamic> toJson() {
    return {
      ApiKey.title: title,
      ApiKey.description: description,
      ApiKey.price: price,
      'courses': courses,
    };
  }
}
