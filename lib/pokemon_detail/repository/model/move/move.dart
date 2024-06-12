import 'package:json_annotation/json_annotation.dart';

part 'move.g.dart';

@JsonSerializable(
  createToJson: false,
  fieldRename: FieldRename.snake,
)
class MoveModel {
  const MoveModel({
    required this.name,
    required this.url,
  });

  final String name;

  final String url;

  factory MoveModel.fromJson(Map<String, dynamic> json) =>
      _$MoveModelFromJson(json);
}
