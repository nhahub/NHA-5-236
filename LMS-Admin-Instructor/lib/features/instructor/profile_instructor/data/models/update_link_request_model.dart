import 'package:json_annotation/json_annotation.dart';

part 'update_link_request_model.g.dart';

@JsonSerializable()
class UpdateLinkRequestModel {
  final String slug;
  @JsonKey(name: 'platformName')
  final String platformName;
  final String url;

  UpdateLinkRequestModel({
    required this.slug,
    required this.platformName,
    required this.url,
  });

  factory UpdateLinkRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateLinkRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateLinkRequestModelToJson(this);
}
