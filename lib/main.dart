import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_viper_pokemon/pokemon_detail/interactor/pokemon_detail_interactor.dart';
import 'package:flutter_viper_pokemon/pokemon_detail/presenter/pokemon_detail_presenter.dart';
import 'package:flutter_viper_pokemon/pokemon_detail/repository/pokemon_detail_repository.dart';
import 'package:flutter_viper_pokemon/pokemon_detail/view/pokemon_detail_screen.dart';
import 'package:flutter_viper_pokemon/pokemon_list/interactor/pokemon_list_interactor.dart';
import 'package:flutter_viper_pokemon/pokemon_list/presenter/pokemon_list_presenter.dart';
import 'package:flutter_viper_pokemon/pokemon_list/repository/pokemon_list_repository.dart';
import 'package:flutter_viper_pokemon/pokemon_list/router/pokemon_list_router.dart';
import 'package:flutter_viper_pokemon/pokemon_list/view/pokemon_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  final Dio dio = Dio();

  /// PokemonList 의존성 주입
  final PokemonListRepository pokemonListRepository = PokemonListRepositoryImpl(
    dio,
  );
  final PokemonListInteractor pokemonListInteractor = PokemonListInteractorImpl(
    pokemonListRepository,
  );

  runApp(
    ChangeNotifierProvider<PokemonListPresenterImpl>(
      create: (_) => PokemonListPresenterImpl(
        interactor: pokemonListInteractor,
        router: PokemonListRouterImpl(),
      ),
      child: const PokemonApp(),
    ),
  );
}

class PokemonApp extends StatelessWidget {
  const PokemonApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      title: 'Pokemon App',
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => const PokemonListScreen(),
        '/detail': (context) {
          final String name =
              ModalRoute.of(context)!.settings.arguments as String;

          assert(name.isNotEmpty, 'name is empty!');

          final Dio dio = Dio();

          /// PokemonDetail 의존성 주입
          final PokemonDetailRepository pokemonDetailRepository =
              PokemonDetailRepositoryImpl(
            dio,
          );

          final PokemonDetailInteractor pokemonDetailInteractor =
              PokemonDetailInteractorImpl(
            pokemonDetailRepository,
          );

          return ChangeNotifierProvider<PokemonDetailPresenterImpl>(
            create: (_) => PokemonDetailPresenterImpl(
              interactor: pokemonDetailInteractor,
            ),
            child: PokemonDetailScreen(name: name),
          );
        },
      },
    );
  }
}
