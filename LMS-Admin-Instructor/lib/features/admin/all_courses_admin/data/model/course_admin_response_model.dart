import 'package:lms_admin_instructor/features/admin/all_courses_admin/data/model/course_admin_model.dart';
import 'package:lms_admin_instructor/features/admin/all_courses_admin/domain/entity/course_admin_ui_model.dart';

class AllCoursesAdminResponseModel {
  final bool success;
  final int status;
  final String message;
  final AllCoursesAdminData data;

  AllCoursesAdminResponseModel({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  factory AllCoursesAdminResponseModel.fromJson(Map<String, dynamic> json) {
    return AllCoursesAdminResponseModel(
      success: json['success'] ?? false,
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data: AllCoursesAdminData.fromJson(json['data'] ?? {}),
    );
  }

  CourseAdminListUIModel toEntity() {
    return CourseAdminListUIModel(
      courses: data.courses.map((e) => e.toEntity()).toList(),
      totalCourses: data.totalCourses,
      totalPages: data.totalPages,
      currentPage: data.currentPage,
    );
  }
}

class AllCoursesAdminData {
  final int totalCourses;
  final int totalPages;
  final int currentPage;
  final List<CourseAdminModel> courses;

  AllCoursesAdminData({
    required this.totalCourses,
    required this.totalPages,
    required this.currentPage,
    required this.courses,
  });

  factory AllCoursesAdminData.fromJson(Map<String, dynamic> json) {
    return AllCoursesAdminData(
      totalCourses: json['total_courses'] ?? 0,
      totalPages: json['total_pages'] ?? 1,
      currentPage: json['current_page'] ?? 1,
      courses: (json['courses'] as List?)
              ?.map((e) => CourseAdminModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}
