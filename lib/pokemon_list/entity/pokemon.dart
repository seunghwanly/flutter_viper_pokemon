abstract class Pokemon {
  const Pokemon();

  String get name;

  String get url;
}

class PokemonEntity extends Pokemon {
  @override
  final String name;

  @override
  final String url;

  const PokemonEntity({
    required this.name,
    required this.url,
  });
}
