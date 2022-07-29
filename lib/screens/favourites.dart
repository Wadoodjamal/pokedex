import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/cubit/favourite_cubit.dart';
import 'package:pokedex/bloc/states/favourite_state.dart';
import 'package:pokedex/widgets/pokemon_card.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<FavouriteCubit, FavouriteState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is FavouriteStateInitial) {
              context.read<FavouriteCubit>().waitForScreenLoad();
            } else if (state is FavouritesStateLoading) {
              context.read<FavouriteCubit>().loadingFavouritesAndPokemons();
            }
            return Container(
              margin: const EdgeInsets.only(right: 16, left: 16, top: 30),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Favourites',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      _favouritesList(constraints, context),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _favouritesList(BoxConstraints constraints, BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          minHeight: constraints.maxHeight, minWidth: constraints.maxWidth),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 4,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) => const PokemonCard(isFavourite: true),
        itemCount: 20,
      ),
    );
  }
}
