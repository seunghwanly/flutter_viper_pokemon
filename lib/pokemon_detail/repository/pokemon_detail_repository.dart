import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_viper_pokemon/pokemon_detail/repository/model/pokemon_detail.dart';
import 'package:flutter_viper_pokemon/util.dart';

abstract class PokemonDetailRepository {
  Future<Result<PokemonDetailModel, String>> getPokemonDetail(
    String name,
  );
}

class PokemonDetailRepositoryImpl implements PokemonDetailRepository {
  const PokemonDetailRepositoryImpl(Dio dio) : _dio = dio;

  final Dio _dio;

  @override
  Future<Result<PokemonDetailModel, String>> getPokemonDetail(
    String name,
  ) async {
    if (name.isEmpty) {
      return const Result(error: '이름을 찾을 수 없습니다.');
    }

    try {
      final Response response = await _dio.getUri(
        Uri.https(
          'pokeapi.co',
          '/api/v2/pokemon/$name',
        ),
      );

      if (!response.isOk) {
        return Result(
          error: response.statusMessage ?? response.data,
        );
      }

      final Map<String, dynamic> data = Map<String, dynamic>.from(
        response.data,
      );

      return Result(
        data: PokemonDetailModel.fromJson(data),
      );
    } catch (e) {
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: e,
          stack: StackTrace.current,
          library: 'PokemonDetailRepositoryImpl',
          context: ErrorDescription('포켓몬 상세 정보를 가져오는 중 오류가 발생했습니다.'),
        ),
      );

      return Result(
        error: '$e',
      );
    }
  }
}
