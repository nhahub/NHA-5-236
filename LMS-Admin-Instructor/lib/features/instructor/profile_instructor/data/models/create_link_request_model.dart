import 'package:json_annotation/json_annotation.dart';

part 'create_link_request_model.g.dart';

@JsonSerializable()
class CreateLinkRequestModel {
  @JsonKey(name: 'platformName')
  final String platformName;
  final String url;

  CreateLinkRequestModel({
    required this.platformName,
    required this.url,
  });

  factory CreateLinkRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CreateLinkRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateLinkRequestModelToJson(this);
}
