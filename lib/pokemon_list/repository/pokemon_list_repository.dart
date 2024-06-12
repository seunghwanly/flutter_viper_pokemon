import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_viper_pokemon/pokemon_list/repository/model/pokemon_model.dart';
import 'package:flutter_viper_pokemon/util.dart';

abstract class PokemonListRepository {
  const PokemonListRepository(Dio dio);

  /// - $1: [List<PokemonModel>] data
  /// - $2: [String?] previous
  /// - $3: [String?] next
  Future<Result<(List<PokemonModel>, String?, String?), String>> getPokemons({
    String? next,
  });
}

class PokemonListRepositoryImpl implements PokemonListRepository {
  const PokemonListRepositoryImpl(Dio dio) : _dio = dio;

  final Dio _dio;

  @override
  Future<Result<(List<PokemonModel>, String?, String?), String>> getPokemons({
    String? next,
  }) async {
    try {
      final Response response = await _dio.getUri(
        next == null
            ? Uri.https(
                'pokeapi.co',
                '/api/v2/pokemon',
              )
            : Uri.parse(next),
      );

      if (!response.isOk) {
        return Result(
          error: response.statusMessage ?? '요청에 실패했습니다,',
        );
      }

      final Map<String, dynamic> data = Map<String, dynamic>.from(
        response.data,
      );

      final List<PokemonModel> pokemons =
          (data['results'] as List<dynamic>? ?? [])
              .map<PokemonModel>((e) => PokemonModel.fromJson(e))
              .toList();

      return Result(
        data: (
          pokemons,
          data['previous'] as String?,
          data['next'] as String?,
        ),
      );
    } catch (e) {
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: e,
          stack: StackTrace.current,
          library: 'PokemonRepositoryImpl',
          context: ErrorDescription('Failed to fetch pokemons'),
        ),
      );

      return Result(
        error: '$e',
      );
    }
  }
}
