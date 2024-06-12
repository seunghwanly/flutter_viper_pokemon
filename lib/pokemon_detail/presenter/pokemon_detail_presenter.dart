import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_viper_pokemon/pokemon_detail/entity/pokemon_detail.dart';
import 'package:flutter_viper_pokemon/pokemon_detail/interactor/pokemon_detail_interactor.dart';
import 'package:flutter_viper_pokemon/util.dart';

abstract class PokemonDetailPresenter {
  PokemonDetailEntity? get pokemonDetail;

  Future<void> getPokemonDetail(String name);
}

class PokemonDetailPresenterImpl extends ChangeNotifier
    implements PokemonDetailPresenter {
  PokemonDetailPresenterImpl({
    required PokemonDetailInteractor interactor,
  }) : _interactor = interactor;

  final PokemonDetailInteractor _interactor;

  @override
  PokemonDetailEntity? pokemonDetail;

  final StreamController<String> errorStreamController =
      StreamController<String>.broadcast();

  @override
  Future<void> getPokemonDetail(
    String name,
  ) async {
    if (name.isEmpty) return;
    try {
      final PokemonDetailEntity pokemonDetailEntity =
          await _interactor.getPokemonDetail(
        name,
      );

      pokemonDetail = pokemonDetailEntity;

      return notifyListeners();
    } on ResultException catch (e) {
      return errorStreamController.add(e.error);
    }
  }

  @override
  void dispose() {
    errorStreamController.close();
    super.dispose();
  }
}
