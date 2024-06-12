import 'package:flutter_viper_pokemon/pokemon_detail/entity/pokemon_detail.dart';

import 'model/ability/ability.dart';
import 'model/move/move.dart';
import 'model/pokemon_detail.dart';
import 'model/sprites/other/other.dart';
import 'model/sprites/other/showdown/showdown.dart';
import 'model/sprites/sprites.dart';
import 'model/stats/stat.dart';

extension on AbilityModel {
  AbilityEntity toEntity() => AbilityEntity(name: name, url: url);
}

extension on MoveModel {
  MoveEntity toEntity() => MoveEntity(name: name, url: url);
}

extension on ShowdownModel {
  ShowdownEntity toEntity() => ShowdownEntity(
        backDefault: backDefault,
        frontDefault: frontDefault,
      );
}

extension on OtherModel {
  OtherEntity toEntity() => OtherEntity(
        officialArtworkDefault: officialArtworkDefault,
        showdown: showdown.toEntity(),
      );
}

extension on SpritesModel {
  SpritesEntity toEntity() => SpritesEntity(
        backDefault: backDefault,
        backFemale: backFemale,
        backShiny: backShiny,
        backShinyFemale: backShiny,
        frontDefault: frontDefault,
        frontFemale: frontFemale,
        frontShiny: frontShiny,
        frontShinyFemale: frontShinyFemale,
        other: other.toEntity(),
      );
}

extension on StatModel {
  StatEntity toEntity() => StatEntity(
        baseStat: baseStat,
        effort: effort,
        name: name,
      );
}

extension PokemonDetailModelExtension on PokemonDetailModel {
  PokemonDetailEntity toEntity() => PokemonDetailEntity(
        abilities: abilities.map((e) => e.toEntity()).toList(),
        baseExperience: baseExperience,
        height: height,
        id: id,
        name: name,
        weight: weight,
        moves: moves.map((e) => e.toEntity()).toList(),
        sprites: sprites.toEntity(),
        stats: stats.map((e) => e.toEntity()).toList(),
      );
}
