import 'package:flutter_viper_pokemon/pokemon_detail/repository/model/sprites/other/other.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sprites.g.dart';

@JsonSerializable(
  createToJson: false,
  fieldRename: FieldRename.snake,
)
class SpritesModel {
  const SpritesModel({
    required this.backDefault,
    this.backFemale,
    required this.backShiny,
    this.backShinyFemale,
    required this.frontDefault,
    this.frontFemale,
    required this.frontShiny,
    this.frontShinyFemale,
    required this.other,
  });

  final String backDefault;

  final String? backFemale;

  final String backShiny;

  final String? backShinyFemale;

  final String frontDefault;

  final String? frontFemale;

  final String frontShiny;

  final String? frontShinyFemale;

  final OtherModel other;

  factory SpritesModel.fromJson(Map<String, dynamic> json) =>
      _$SpritesModelFromJson(json);
}
