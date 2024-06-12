import 'package:flutter/material.dart';

abstract class PokemonListRouter {
  /// 포켓몬 상세 화면으로 이동
  Future<void> navigateToPokemonDetail(
    BuildContext context,
    String name,
  );
}

class PokemonListRouterImpl implements PokemonListRouter {
  @override
  Future<void> navigateToPokemonDetail(
    BuildContext context,
    String name,
  ) async {
    return Navigator.maybeOf(context)?.pushNamed<void>(
      '/detail',
      arguments: name,
    );
  }
}
