import 'package:flutter_viper_pokemon/pokemon_detail/entity/pokemon_detail.dart';
import 'package:flutter_viper_pokemon/pokemon_detail/repository/model/pokemon_detail.dart';
import 'package:flutter_viper_pokemon/pokemon_detail/repository/model_extension.dart';
import 'package:flutter_viper_pokemon/pokemon_detail/repository/pokemon_detail_repository.dart';
import 'package:flutter_viper_pokemon/util.dart';

abstract class PokemonDetailInteractor {
  /// 포켓몬 이름으로 조회
  Future<PokemonDetailEntity> getPokemonDetail(
    String name,
  );
}

class PokemonDetailInteractorImpl implements PokemonDetailInteractor {
  const PokemonDetailInteractorImpl(
    PokemonDetailRepository repository,
  ) : _repository = repository;

  final PokemonDetailRepository _repository;

  @override
  Future<PokemonDetailEntity> getPokemonDetail(
    String name,
  ) async {
    final Result<PokemonDetailModel, String> result =
        await _repository.getPokemonDetail(
      name,
    );

    if (result.hasError) throw ResultException.fromResult(result);

    return result.data!.toEntity();
  }
}
