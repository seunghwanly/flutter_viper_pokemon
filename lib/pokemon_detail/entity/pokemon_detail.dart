abstract class Ability {
  String get name;
  String get url;
}

abstract class Move {
  String get name;
  String get url;
}

abstract class Showdown {
  String get backDefault;
  String get frontDefault;
}

abstract class Other {
  String get officialArtworkDefault;
  Showdown get showdown;
}

abstract class Sprites {
  String get backDefault;
  String? get backFemale;
  String get backShiny;
  String? get backShinyFemale;
  String get frontDefault;
  String? get frontFemale;
  String get frontShiny;
  String? get frontShinyFemale;
  Other get other;
}

abstract class Stat {
  int get baseStat;
  int get effort;
  String get name;
}

abstract class PokemonDetail {
  List<Ability> get abilities;
  int get baseExperience;
  int get height;
  int get id;
  String get name;
  int get weight;
  List<Move> get moves;
  Sprites get sprites;
  List<Stat> get stats;
}

class AbilityEntity implements Ability {
  const AbilityEntity({
    required this.name,
    required this.url,
  });

  @override
  final String name;

  @override
  final String url;
}

class MoveEntity implements Move {
  const MoveEntity({
    required this.name,
    required this.url,
  });

  @override
  final String name;

  @override
  final String url;
}

class ShowdownEntity implements Showdown {
  const ShowdownEntity({
    required this.backDefault,
    required this.frontDefault,
  });

  @override
  final String backDefault;

  @override
  final String frontDefault;
}

class OtherEntity implements Other {
  const OtherEntity({
    required this.officialArtworkDefault,
    required this.showdown,
  });

  @override
  final String officialArtworkDefault;

  @override
  final ShowdownEntity showdown;
}

class SpritesEntity implements Sprites {
  const SpritesEntity({
    required this.backDefault,
    required this.backFemale,
    required this.backShiny,
    required this.backShinyFemale,
    required this.frontDefault,
    required this.frontFemale,
    required this.frontShiny,
    required this.frontShinyFemale,
    required this.other,
  });

  @override
  final String backDefault;

  @override
  final String? backFemale;

  @override
  final String backShiny;

  @override
  final String? backShinyFemale;

  @override
  final String frontDefault;

  @override
  final String? frontFemale;

  @override
  final String frontShiny;

  @override
  final String? frontShinyFemale;

  @override
  final OtherEntity other;

  List<String> get images => [
        if (backDefault.isNotEmpty) backDefault,
        if (backFemale?.isNotEmpty ?? false) backFemale!,
        if (backShiny.isNotEmpty) backShiny,
        if (backShinyFemale?.isNotEmpty ?? false) backShinyFemale!,
        if (frontDefault.isNotEmpty) frontDefault,
        if (frontFemale?.isNotEmpty ?? false) frontFemale!,
        if (frontShiny.isNotEmpty) frontShiny,
        if (frontShinyFemale?.isNotEmpty ?? false) frontShinyFemale!,
        if (other.officialArtworkDefault.isNotEmpty)
          other.officialArtworkDefault,
        if (other.showdown.backDefault.isNotEmpty) other.showdown.backDefault,
        if (other.showdown.frontDefault.isNotEmpty) other.showdown.frontDefault,
      ];
}

class StatEntity implements Stat {
  const StatEntity({
    required this.baseStat,
    required this.effort,
    required this.name,
  });

  @override
  final int baseStat;

  @override
  final int effort;

  @override
  final String name;
}

class PokemonDetailEntity implements PokemonDetail {
  const PokemonDetailEntity({
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

  @override
  final List<AbilityEntity> abilities;

  @override
  final int baseExperience;

  @override
  final int height;

  @override
  final int id;

  @override
  final String name;

  @override
  final int weight;

  @override
  final List<MoveEntity> moves;

  @override
  final SpritesEntity sprites;

  @override
  final List<StatEntity> stats;
}
