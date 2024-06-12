import 'package:flutter_viper_pokemon/pokemon_list/entity/pokemon.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokemon_model.g.dart';

@JsonSerializable(createToJson: false)
class PokemonModel extends Pokemon {
  @override
  final String name;

  @override
  final String url;

  const PokemonModel({
    required this.name,
    required this.url,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonModelFromJson(json);
}

extension PokemonModelExtension on PokemonModel {
  PokemonEntity toEntity() => PokemonEntity(
        name: name,
        url: url,
      );
}
