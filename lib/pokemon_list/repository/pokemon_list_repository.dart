import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_viper_pokemon/pokemon_list/repository/model/pokemon_model.dart';
import 'package:flutter_viper_pokemon/util.dart';

abstract class PokemonListRepository {
  /// 의존성 주입을 위한 [Dio] 객체 파라미터
  const PokemonListRepository(Dio dio);

  /// [Result]의 [data]에는 [PokemonModel] 리스트와 이전/다음 페이지 URL이 포함됩니다.
  /// - $1: [List<PokemonModel>] 포켓몬 리스트
  /// - $2: [String?] 다음 페이지 URL
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
