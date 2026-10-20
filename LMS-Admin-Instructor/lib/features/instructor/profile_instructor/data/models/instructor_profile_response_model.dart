import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/instructor_profile_ui_model.dart';

part 'instructor_profile_response_model.g.dart';

@JsonSerializable()
class InstructorProfileResponseModel {
  final bool? success;
  final int? status;
  final String? message;
  final InstructorProfileDataModel? data;

  InstructorProfileResponseModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory InstructorProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$InstructorProfileResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$InstructorProfileResponseModelToJson(this);
}

@JsonSerializable()
class InstructorProfileDataModel {
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  final String? email;
  final String? slug;
  final String? bio;
  final String? description;
  final String? image;
  final List<InstructorLinkModel>? links;
  @JsonKey(name: 'created_at')
  final String? createdAt;

  InstructorProfileDataModel({
    this.firstName,
    this.lastName,
    this.email,
    this.slug,
    this.bio,
    this.description,
    this.image,
    this.links,
    this.createdAt,
  });

  factory InstructorProfileDataModel.fromJson(Map<String, dynamic> json) =>
      _$InstructorProfileDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$InstructorProfileDataModelToJson(this);

  InstructorProfileUIModel toEntity() {
    return InstructorProfileUIModel(
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      email: email ?? '',
      slug: slug ?? '',
      bio: bio ?? '',
      description: description ?? '',
      image: image ?? '',
      links: links?.map((e) => e.toEntity()).toList() ?? [],
      createdAt: createdAt ?? '',
    );
  }
}

@JsonSerializable()
class InstructorLinkModel {
  final String? slug;
  final String? platformName;
  final String? url;

  InstructorLinkModel({
    this.slug,
    this.platformName,
    this.url,
  });

  factory InstructorLinkModel.fromJson(Map<String, dynamic> json) =>
      _$InstructorLinkModelFromJson(json);

  Map<String, dynamic> toJson() => _$InstructorLinkModelToJson(this);

  InstructorLinkUIModel toEntity() {
    return InstructorLinkUIModel(
      slug: slug ?? '',
      platformName: platformName ?? '',
      url: url ?? '',
    );
  }
}
