import 'package:json_annotation/json_annotation.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/data/model/instructor_admin_model.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/domain/entity/instructor_admin_ui_model.dart';

part 'instructor_admin_respomse_model.g.dart';

@JsonSerializable()
class InstructorAdminResponseModel {
  final bool success;
  final int status;
  final String message;
  final InstructorAdminData data;

  InstructorAdminResponseModel({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  factory InstructorAdminResponseModel.fromJson(Map<String, dynamic> json) =>
      _$InstructorAdminResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$InstructorAdminResponseModelToJson(this);

  InstructorAdminUiModel toEntity() {
    return InstructorAdminUiModel(
      instructors: data.instructors?.map((e) => e.toEntity()).toList() ?? [],
      totalInstructors: data.totalInstructors ?? 0,
      totalPages: data.totalPages ?? 1,
      currentPage: data.currentPage ?? 1,
    );
  }
}

@JsonSerializable()
class InstructorAdminData {
  @JsonKey(name: 'total_pages')
  final int? totalPages;
  @JsonKey(name: 'current_page')
  final int? currentPage;
  @JsonKey(name: 'total_instructors')
  final int? totalInstructors;
  final List<InstructorAdminModel>? instructors;

  InstructorAdminData({
    this.totalPages,
    this.currentPage,
    this.totalInstructors,
    this.instructors,
  });

  factory InstructorAdminData.fromJson(Map<String, dynamic> json) =>
      _$InstructorAdminDataFromJson(json);
  Map<String, dynamic> toJson() => _$InstructorAdminDataToJson(this);
}
