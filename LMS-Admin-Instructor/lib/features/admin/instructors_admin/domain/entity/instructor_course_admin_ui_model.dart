import 'package:lms_admin_instructor/features/instructor/courses_instructor/domain/entity/course_instructor_ui_model.dart';

class InstructorCourseAdminUiModel {
  final bool success;
  final int status;
  final String message;
  final InstructorCourseAdminItemData? data;

  InstructorCourseAdminUiModel({
    required this.success,
    required this.status,
    required this.message,
    this.data,
  });

  InstructorCourseAdminUiModel copyWith({
    bool? success,
    int? status,
    String? message,
    InstructorCourseAdminItemData? data,
  }) {
    return InstructorCourseAdminUiModel(
      success: success ?? this.success,
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}

class InstructorCourseAdminItemData {
  final int totalPages;
  final int currentPage;
  final int totalCourses;
  final List<CourseInstructorItemUIModel> courses;

  InstructorCourseAdminItemData({
    required this.totalPages,
    required this.currentPage,
    required this.totalCourses,
    required this.courses,
  });

  InstructorCourseAdminItemData copyWith({
    int? totalPages,
    int? currentPage,
    int? totalCourses,
    List<CourseInstructorItemUIModel>? courses,
  }) {
    return InstructorCourseAdminItemData(
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
      totalCourses: totalCourses ?? this.totalCourses,
      courses: courses ?? this.courses,
    );
  }
}
