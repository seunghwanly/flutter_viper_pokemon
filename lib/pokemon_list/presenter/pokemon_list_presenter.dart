import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_viper_pokemon/pokemon_list/entity/pokemon.dart';
import 'package:flutter_viper_pokemon/pokemon_list/interactor/pokemon_list_interactor.dart';
import 'package:flutter_viper_pokemon/pokemon_list/router/pokemon_list_router.dart';
import 'package:flutter_viper_pokemon/util.dart';

abstract class PokemonListPresenter {
  List<PokemonEntity> get pokemons;

  String? get previous;

  String? get next;

  /// 포켓몬 리스트 불러오기
  Future<void> getPokemons();

  Future<void> onRoute(
    BuildContext context,
    String name,
  );
}

class PokemonListPresenterImpl extends ChangeNotifier
    implements PokemonListPresenter {
  PokemonListPresenterImpl({
    required PokemonListInteractor interactor,
    required PokemonListRouter router,
  })  : _interactor = interactor,
        _router = router;

  final PokemonListInteractor _interactor;

  final PokemonListRouter _router;

  @override
  List<PokemonEntity> pokemons = [];

  @override
  String? previous;

  @override
  String? next;

  final StreamController<String> errorStreamController =
      StreamController<String>.broadcast();

  @override
  void dispose() {
    errorStreamController.close();
    super.dispose();
  }

  @override
  Future<void> getPokemons() async {
    try {
      final (List<PokemonEntity> l, String? p, String? n) =
          await _interactor.getPokemons(
        next: next,
      );

      if (p == null) {
        pokemons = l;
      } else {
        pokemons.addAll(l);
      }

      previous = p;
      next = n;

      return notifyListeners();
    } on ResultException catch (e) {
      return errorStreamController.add(e.error);
    }
  }

  @override
  Future<void> onRoute(
    BuildContext context,
    String name,
  ) =>
      _router.navigateToPokemonDetail(
        context,
        name,
      );
}
