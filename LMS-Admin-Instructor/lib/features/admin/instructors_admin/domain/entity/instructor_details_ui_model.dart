import 'package:lms_admin_instructor/features/admin/instructors_admin/data/model/instructor_admin_model.dart';

class InstructorDetailsUiModel {
  final bool success;
  final int status;
  final String message;
  final InstructorAdminModel data;

  InstructorDetailsUiModel({
    required this.data,
    required this.success,
    required this.status,
    required this.message,
  });

  InstructorDetailsUiModel copyWith({
    bool? success,
    int? status,
    String? message,
    InstructorAdminModel? data,
  }) {
    return InstructorDetailsUiModel(
      data: data ?? this.data,
      success: success ?? this.success,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
