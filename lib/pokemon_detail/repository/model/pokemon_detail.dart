import 'package:flutter_viper_pokemon/pokemon_detail/repository/model/ability/ability.dart';
import 'package:flutter_viper_pokemon/pokemon_detail/repository/model/move/move.dart';
import 'package:flutter_viper_pokemon/pokemon_detail/repository/model/sprites/sprites.dart';
import 'package:flutter_viper_pokemon/pokemon_detail/repository/model/stats/stat.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokemon_detail.g.dart';

@JsonSerializable(
  createToJson: false,
  fieldRename: FieldRename.snake,
)
class PokemonDetailModel {
  const PokemonDetailModel({
    required this.abilities,
    required this.baseExperience,
    required this.height,
    required this.id,
    required this.name,
    required this.weight,
    required this.moves,
    required this.sprites,
    required this.stats,
  });

  @AbilitiesConverter()
  final List<AbilityModel> abilities;

  final int baseExperience;

  final int height;

  final int id;

  final String name;

  final int weight;

  @MovesConverter()
  final List<MoveModel> moves;

  final SpritesModel sprites;

  final List<StatModel> stats;

  factory PokemonDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonDetailModelFromJson(json);
}

class AbilitiesConverter
    implements JsonConverter<List<AbilityModel>, List<dynamic>> {
  const AbilitiesConverter();

  @override
  List<AbilityModel> fromJson(List<dynamic> json) {
    return json
        .map(
          (e) => AbilityModel(
            name: e['ability']['name'] as String,
            url: e['ability']['url'] as String,
          ),
        )
        .toList();
  }

  @override
  List<Map<String, dynamic>> toJson(List<AbilityModel> object) {
    throw UnimplementedError();
  }
}

class MovesConverter implements JsonConverter<List<MoveModel>, List<dynamic>> {
  const MovesConverter();

  @override
  List<MoveModel> fromJson(List<dynamic> json) {
    return json
        .map(
          (e) => MoveModel(
            name: e['move']['name'] as String,
            url: e['move']['url'] as String,
          ),
        )
        .toList();
  }

  @override
  List<Map<String, dynamic>> toJson(List<MoveModel> object) {
    throw UnimplementedError();
  }
}
