import 'package:json_annotation/json_annotation.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/domain/entity/instructor_admin_ui_model.dart';

part 'instructor_admin_model.g.dart';

@JsonSerializable()
class InstructorLinkModel {
  final String? slug;
  @JsonKey(name: 'platformName')
  final String? platformName;
  final String? url;

  InstructorLinkModel({this.slug, this.platformName, this.url});

  factory InstructorLinkModel.fromJson(Map<String, dynamic> json) =>
      _$InstructorLinkModelFromJson(json);

  Map<String, dynamic> toJson() => _$InstructorLinkModelToJson(this);

  InstructorLinkUiModel toEntity() {
    return InstructorLinkUiModel(
      slug: slug ?? '',
      platformName: platformName ?? '',
      url: url ?? '',
    );
  }
}

@JsonSerializable()
class InstructorAdminModel {
  @JsonKey(name: 'first_name')
  final String? first_name;
  @JsonKey(name: 'last_name')
  final String? last_name;
  final String? email;
  final String? slug;
  final String? bio;
  final String? description;
  final String? image;
  @JsonKey(name: 'created_at')
  final String? joindata;
  final List<InstructorLinkModel>? links;

  InstructorAdminModel({
    this.slug,
    this.first_name,
    this.last_name,
    this.email,
    this.bio,
    this.description,
    this.image,
    this.links,
    this.joindata,
  });

  factory InstructorAdminModel.fromJson(Map<String, dynamic> json) =>
      _$InstructorAdminModelFromJson(json);

  Map<String, dynamic> toJson() => _$InstructorAdminModelToJson(this);

  InstructoritemUiModel toEntity() {
    return InstructoritemUiModel(
      slug: slug ?? '',
      first_name: first_name ?? '',
      last_name: last_name ?? '',
      email: email ?? '',
      bio: bio ?? '',
      description: description ?? '',
      image: image,
      joindata: joindata ?? '',
      links: links?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}
