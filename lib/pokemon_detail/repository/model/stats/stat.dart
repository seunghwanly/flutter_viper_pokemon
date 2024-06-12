import 'package:json_annotation/json_annotation.dart';

part 'stat.g.dart';

String _getName(Map<String, dynamic> json) => json['name'] as String;

@JsonSerializable(
  createToJson: false,
  fieldRename: FieldRename.snake,
)
class StatModel {
  const StatModel({
    required this.baseStat,
    required this.effort,
    required this.name,
  });

  final int baseStat;

  final int effort;

  @JsonKey(
    name: 'stat',
    fromJson: _getName,
  )
  final String name;

  factory StatModel.fromJson(Map<String, dynamic> json) =>
      _$StatModelFromJson(json);
}
