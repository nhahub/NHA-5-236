import 'package:json_annotation/json_annotation.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/data/model/course_instructor_model.dart';
import '../../domain/entity/instructor_course_admin_ui_model.dart';

part 'instructor_course_admin_responce_model.g.dart';

@JsonSerializable()
class InstructorCourseAdminResponceModel {
  final bool? success;
  final int? status;
  final String? message;
  final InstructorCourseAdminData? data;

  InstructorCourseAdminResponceModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory InstructorCourseAdminResponceModel.fromJson(
    Map<String, dynamic> json,
  ) => _$InstructorCourseAdminResponceModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$InstructorCourseAdminResponceModelToJson(this);

  InstructorCourseAdminUiModel toEntity() {
    return InstructorCourseAdminUiModel(
      success: success ?? false,
      status: status ?? 0,
      message: message ?? '',
      data: data?.toEntity(),
    );
  }
}

@JsonSerializable()
class InstructorCourseAdminData {
  @JsonKey(name: 'total_pages')
  final int? totalPages;
  @JsonKey(name: 'current_page')
  final int? currentPage;
  @JsonKey(name: 'total_courses')
  final int? totalCourses;
  final List<CourseInstructorModel>? courses;

  InstructorCourseAdminData({
    this.totalPages,
    this.currentPage,
    this.totalCourses,
    this.courses,
  });

  factory InstructorCourseAdminData.fromJson(Map<String, dynamic> json) =>
      _$InstructorCourseAdminDataFromJson(json);

  Map<String, dynamic> toJson() => _$InstructorCourseAdminDataToJson(this);

  InstructorCourseAdminItemData toEntity() {
    return InstructorCourseAdminItemData(
      totalPages: totalPages ?? 1,
      currentPage: currentPage ?? 1,
      totalCourses: totalCourses ?? 0,
      courses: courses?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}
