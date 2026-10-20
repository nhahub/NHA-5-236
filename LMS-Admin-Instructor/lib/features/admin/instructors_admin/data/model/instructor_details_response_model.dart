import 'package:json_annotation/json_annotation.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/data/model/instructor_admin_model.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/domain/entity/instructor_details_ui_model.dart';

part 'instructor_details_response_model.g.dart';

@JsonSerializable()
class InstructorDetailsResponseModel {
  final bool success;
  final int status;
  final String message;
  final InstructorAdminModel data;

  InstructorDetailsResponseModel({
    required this.data,
    required this.success,
    required this.status,
    required this.message,
  });
  factory InstructorDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$InstructorDetailsResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$InstructorDetailsResponseModelToJson(this);
  InstructorDetailsUiModel toEntity() {
    return InstructorDetailsUiModel(
      data: data,
      success: success,
      status: status,
      message: message,
    );
  }
}
