import 'package:json_annotation/json_annotation.dart';

part 'showdown.g.dart';

@JsonSerializable(
  createToJson: false,
  fieldRename: FieldRename.snake,
)
class ShowdownModel {
  const ShowdownModel({
    required this.backDefault,
    required this.frontDefault,
  });

  final String backDefault;

  final String frontDefault;

  factory ShowdownModel.fromJson(Map<String, dynamic> json) =>
      _$ShowdownModelFromJson(json);
}
