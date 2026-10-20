import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/admin_profile_ui_model.dart';

part 'admin_profile_model.g.dart';

@JsonSerializable()
class AdminProfileResponseModel {
  final bool? success;
  final int? status;
  final String? message;
  final AdminProfileModel? data;

  AdminProfileResponseModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory AdminProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AdminProfileResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdminProfileResponseModelToJson(this);
}

@JsonSerializable()
class AdminProfileModel {
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  final String? email;
  final String? slug;
  final String? image;
  @JsonKey(name: 'created_at')
  final String? createdAt;

  AdminProfileModel({
    this.firstName,
    this.lastName,
    this.email,
    this.slug,
    this.image,
    this.createdAt,
  });

  factory AdminProfileModel.fromJson(Map<String, dynamic> json) =>
      _$AdminProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdminProfileModelToJson(this);

  AdminProfileUIModel toEntity() {
    return AdminProfileUIModel(
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      email: email ?? '',
      slug: slug ?? '',
      image: image ?? '',
      createdAt: createdAt ?? '',
    );
  }
}
