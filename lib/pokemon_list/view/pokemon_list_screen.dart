import 'package:flutter/material.dart';
import 'package:flutter_viper_pokemon/pokemon_list/entity/pokemon.dart';
import 'package:flutter_viper_pokemon/pokemon_list/presenter/pokemon_list_presenter.dart';
import 'package:flutter_viper_pokemon/util.dart';
import 'package:provider/provider.dart';

abstract class PokemonListView {
  ///  에러 메시지를 보여주는 메소드
  void displayError(String message);
}

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({super.key});

  @override
  State<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen>
    implements PokemonListView {
  final Debouncer _debouncer = Debouncer();

  @override
  void initState() {
    super.initState();

    final PokemonListPresenterImpl presenter =
        context.read<PokemonListPresenterImpl>();

    /// 데이터 받아오기
    presenter.getPokemons();

    presenter.errorStreamController.stream.listen(
      (message) {
        if (!mounted || message.isEmpty) return;
        displayError(message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final PokemonListPresenter presenter =
        context.watch<PokemonListPresenterImpl>();

    final List<PokemonEntity> pokemons = presenter.pokemons;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon List'),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: presenter.getPokemons,
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification.metrics.atEdge &&
                notification.metrics.extentAfter == 0) {
              _debouncer.run(action: presenter.getPokemons);
            }

            return false;
          },
          child: ListView.separated(
            itemBuilder: (context, i) {
              if (i == pokemons.length) {
                return const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    '모두 확인했어요!',
                    textAlign: TextAlign.center,
                  ),
                );
              }

              final String name = pokemons[i].name;

              return ListTile(
                onTap: () {
                  // TODO(seunghwanly): navigate to detail screen (PRESENTER)
                  if (name.isEmpty) return;
                  debugPrint(name);
                  presenter.onRoute(context, name);
                },
                title: Text(name),
                trailing: const Icon(Icons.arrow_forward_ios),
              );
            },
            separatorBuilder: (_, __) => const Divider(),
            itemCount: pokemons.length + 1,
          ),
        ),
      ),
    );
  }

  @override
  void displayError(String message) =>
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
}
