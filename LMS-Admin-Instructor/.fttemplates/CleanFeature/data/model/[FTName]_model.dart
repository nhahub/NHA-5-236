import 'package:json_annotation/json_annotation.dart';

part '<FTName | snakecase>_model.g.dart';

@JsonSerializable()
class <FTName | pascalcase>Model {
  final String image;
  final String name;

  <FTName | pascalcase>Model({required this.image, required this.name});

  factory <FTName | pascalcase>Model.fromJson(Map<String, dynamic> json) => _$<FTName | pascalcase>ModelFromJson(json);
  Map<String, dynamic> toJson() => _$<FTName | pascalcase>ModelToJson(this);
}