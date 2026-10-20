import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/student_ui_model.dart';

part 'students_model.g.dart';

@JsonSerializable()
class StudentsModel {
  final String? slug;
  @JsonKey(name: 'student_name')
  final String? studentName;
  final String? email;
  @JsonKey(name: 'is_active')
  final bool? isActive;
  @JsonKey(name: 'enrollments_count')
  final int? enrollmentsCount;
  final String? image;
  @JsonKey(name: 'is_verified')
  final bool? isVerified;

  StudentsModel({
    this.slug,
    this.studentName,
    this.email,
    this.isActive,
    this.enrollmentsCount,
    this.image,
    this.isVerified,
  });

  factory StudentsModel.fromJson(Map<String, dynamic> json) =>
      _$StudentsModelFromJson(json);
  Map<String, dynamic> toJson() => _$StudentsModelToJson(this);

  StudentItemUIModel toEntity() {
    return StudentItemUIModel(
      slug: slug ?? '',
      studentName: studentName ?? 'N/A',
      email: email ?? '',
      isActive: isActive ?? false,
      enrollmentsCount: enrollmentsCount ?? 0,
      image: image,
      isVerified: isVerified ?? false,
    );
  }
}
