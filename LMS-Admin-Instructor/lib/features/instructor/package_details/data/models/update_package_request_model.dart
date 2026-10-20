import 'package:json_annotation/json_annotation.dart';

part 'update_package_request_model.g.dart';

@JsonSerializable()
class UpdatePackageRequestModel {
  @JsonKey(name: 'title')
  final String title;
  
  @JsonKey(name: 'description')
  final String description;
  
  @JsonKey(name: 'price')
  final String price;
  
  @JsonKey(name: 'courses')
  final List<String> courses;

  UpdatePackageRequestModel({
    required this.title,
    required this.description,
    required this.price,
    required this.courses,
  });

  factory UpdatePackageRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UpdatePackageRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePackageRequestModelToJson(this);
}
