import 'package:flutter/material.dart';

abstract class PokemonListRouter {
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
