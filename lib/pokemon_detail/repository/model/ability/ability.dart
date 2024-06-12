import 'package:json_annotation/json_annotation.dart';

part 'ability.g.dart';

@JsonSerializable(
  createToJson: false,
)
class AbilityModel {
  const AbilityModel({
    required this.name,
    required this.url,
  });

  final String name;

  final String url;

  factory AbilityModel.fromJson(Map<String, dynamic> json) =>
      _$AbilityModelFromJson(json);
}
