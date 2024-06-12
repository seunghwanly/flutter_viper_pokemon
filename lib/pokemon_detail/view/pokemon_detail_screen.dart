import 'package:flutter/material.dart';
import 'package:flutter_viper_pokemon/pokemon_detail/entity/pokemon_detail.dart';
import 'package:flutter_viper_pokemon/pokemon_detail/presenter/pokemon_detail_presenter.dart';
import 'package:provider/provider.dart';

abstract class PokemonDetailView {
  void displayError(String message);
}

class PokemonDetailScreen extends StatefulWidget {
  const PokemonDetailScreen({
    required this.name,
    super.key,
  });

  final String name;

  @override
  State<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen>
    implements PokemonDetailView {
  @override
  void initState() {
    super.initState();

    final PokemonDetailPresenterImpl presenter =
        context.read<PokemonDetailPresenterImpl>();

    /// 데이터 받아오기
    presenter.getPokemonDetail(widget.name);

    presenter.errorStreamController.stream.listen(
      (message) {
        if (!mounted || message.isEmpty) return;
        displayError(message);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PokemonDetailPresenter presenter =
        context.watch<PokemonDetailPresenterImpl>();

    final PokemonDetailEntity? pokemonDetail = presenter.pokemonDetail;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Builder(
        builder: (context) {
          if (pokemonDetail == null) {
            return const Center(
              child: Text('포켓몬 정보를 찾을 수 없어요 :('),
            );
          }

          final int ratio = MediaQuery.of(context).devicePixelRatio.toInt();

          final List<String> images = pokemonDetail.sprites.images;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                /// 이미지
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.network(
                    pokemonDetail.sprites.other.officialArtworkDefault,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.error_outline_rounded,
                    ),
                    width: 128,
                    height: 128,
                    cacheHeight: 128 * ratio,
                    cacheWidth: 128 * ratio,
                  ),
                ),

                /// 그 외 이미지
                SizedBox.fromSize(
                  size: const Size.fromHeight(128),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    itemBuilder: (context, i) => Padding(
                      padding: EdgeInsets.only(
                        left: i == 0 ? 16 : 0,
                        right: i == images.length - 1 ? 16 : 0,
                      ),
                      child: Image.network(
                        images[i],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                /// 기본 정보
                ListTile(
                  leading: const Text('Name'),
                  title: Text(pokemonDetail.name),
                ),
                ListTile(
                  leading: const Text('Weight'),
                  title: Text('${pokemonDetail.weight} kg'),
                ),
                ListTile(
                  leading: const Text('Height'),
                  title: Text('${pokemonDetail.height} cm'),
                ),
                ListTile(
                  leading: const Text('Base Experience'),
                  title: Text('${pokemonDetail.baseExperience}'),
                ),
                const SizedBox(height: 12),

                /// 스탯
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('STATS📊'),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Wrap(
                    runSpacing: 12,
                    spacing: 12,
                    children: pokemonDetail.stats
                        .map(
                          (e) =>
                              RawChip(label: Text('${e.name}: ${e.baseStat}')),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 12),

                /// 능력
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('ABILITIES💪'),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Wrap(
                    runSpacing: 12,
                    spacing: 12,
                    children: pokemonDetail.abilities
                        .map(
                          (e) => RawChip(label: Text(e.name)),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 12),

                /// 움직임
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('MOVES💨'),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Wrap(
                    runSpacing: 12,
                    spacing: 12,
                    children: pokemonDetail.moves
                        .map(
                          (e) => RawChip(label: Text(e.name)),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 12),

                const SizedBox(height: 36),
              ],
            ),
          );
        },
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
