import 'package:flutter_viper_pokemon/pokemon_list/entity/pokemon.dart';
import 'package:flutter_viper_pokemon/pokemon_list/repository/model/pokemon_model.dart';
import 'package:flutter_viper_pokemon/pokemon_list/repository/pokemon_list_repository.dart';
import 'package:flutter_viper_pokemon/util.dart';

abstract class PokemonListInteractor {
  /// 포켓몬 리스트 불러오기
  Future<(List<PokemonEntity>, String?, String?)> getPokemons({
    String? next,
  });
}

class PokemonListInteractorImpl implements PokemonListInteractor {
  const PokemonListInteractorImpl(
    PokemonListRepository repository,
  ) : _repository = repository;

  final PokemonListRepository _repository;

  @override
  Future<(List<PokemonEntity>, String?, String?)> getPokemons({
    String? next,
  }) async {
    final Result<(List<PokemonModel>, String?, String?), String> result =
        await _repository.getPokemons(
      next: next,
    );

    if (result.hasError) throw ResultException.fromResult(result);

    final List<PokemonEntity> pokemons =
        result.data!.$1.map((e) => e.toEntity()).toList();

    return (pokemons, result.data!.$2, result.data!.$3);
  }
}
