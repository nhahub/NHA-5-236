import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/course_student_ui_model.dart';

part 'course_students_response_model.g.dart';

@JsonSerializable()
class CourseStudentsResponseModel {
  @JsonKey(name: 'total_students')
  final int totalStudents;

  @JsonKey(name: 'total_pages')
  final int totalPages;

  @JsonKey(name: 'current_page')
  final int currentPage;

  @JsonKey(name: 'students')
  final List<CourseStudentModel> students;

  CourseStudentsResponseModel({
    required this.totalStudents,
    required this.totalPages,
    required this.currentPage,
    required this.students,
  });

  factory CourseStudentsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseStudentsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseStudentsResponseModelToJson(this);

  CourseStudentsListUIModel toEntity({
    required int currentPage,
    int pageSize = 10,
  }) {
    return CourseStudentsListUIModel(
      students: students.map((e) => e.toEntity()).toList(),
      totalStudents: totalStudents,
      totalPages: totalPages,
      currentPage: this.currentPage,
    );
  }
}

@JsonSerializable()
class CourseStudentModel {
  @JsonKey(name: 'student_slug')
  final String? studentSlug;
  @JsonKey(name: 'student_name')
  final String? studentName;
  @JsonKey(name: 'student_email')
  final String? studentEmail;
  @JsonKey(name: 'enrollment_date')
  final String? enrollmentDate;
  @JsonKey(name: 'progress')
  final num? progress;

  CourseStudentModel({
    this.studentSlug,
    this.studentName,
    this.studentEmail,
    this.enrollmentDate,
    this.progress,
  });

  factory CourseStudentModel.fromJson(Map<String, dynamic> json) =>
      _$CourseStudentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseStudentModelToJson(this);

  CourseStudentItemUIModel toEntity() {
    return CourseStudentItemUIModel(
      name: studentName ?? '',
      email: studentEmail ?? '',
      avatar: "",
      enrollmentDate: enrollmentDate ?? '',
      progress: (progress ?? 0).toDouble() / 100.0,
      slug: studentSlug ?? '',
    );
  }
}
