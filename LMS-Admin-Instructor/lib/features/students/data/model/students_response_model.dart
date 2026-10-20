import 'package:json_annotation/json_annotation.dart';
import 'package:lms_admin_instructor/features/students/domain/entity/student_ui_model.dart';
import 'students_model.dart';

part 'students_response_model.g.dart';

@JsonSerializable()
class StudentsResponseModel {
  final bool success;
  final int status;
  final String message;
  final StudentsData data;

  @JsonKey(name: 'total_enrollments')
  final int? totalEnrollments;

  StudentsResponseModel({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
    this.totalEnrollments,
  });

  factory StudentsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$StudentsResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$StudentsResponseModelToJson(this);

  StudentUIModel toEntity() {
    return StudentUIModel(
      students: data.students?.map((e) => e.toEntity()).toList() ?? [],
      totalEnrollments: data.totalEnrollments ?? 0,
      totalStudents: data.totalStudents ?? 0,
      totalPages: data.totalPages ?? 1,
      currentPage: data.currentPage ?? 1,
    );
  }
}

@JsonSerializable()
class StudentsData {
  @JsonKey(name: 'total_pages')
  final int? totalPages;
  @JsonKey(name: 'current_page')
  final int? currentPage;
  @JsonKey(name: 'total_students')
  final int? totalStudents;
  final List<StudentsModel>? students;

  @JsonKey(name: 'total_enrollments')
  final int? totalEnrollments;

  StudentsData({
    this.totalPages,
    this.currentPage,
    this.totalStudents,
    this.students,
    this.totalEnrollments,
  });

  factory StudentsData.fromJson(Map<String, dynamic> json) =>
      _$StudentsDataFromJson(json);
  Map<String, dynamic> toJson() => _$StudentsDataToJson(this);
}
