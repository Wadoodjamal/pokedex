import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/cubit/home_cubit.dart';
import 'package:pokedex/bloc/states/home_state.dart';
import 'package:pokedex/widgets/pokemon_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: BlocConsumer<HomeCubit, HomeState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is HomeStateInitial) {
                    context.read<HomeCubit>().waitForScreenLoad();
                  } else if (state is HomeStateLoading) {
                    context.read<HomeCubit>().loadingFavouritesAndPokemons();
                  }
                  return state.pokemonList.isEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Pokedex',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Favourites',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  _seeFavouritesText(),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            _favouriteList(context),
                            const SizedBox(height: 30),
                            Text(
                              'All Pokemons',
                              style: TextStyle(
                                fontSize: 24,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            _pokemonList(constraints, state),
                          ],
                        );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _pokemonList(BoxConstraints constraints, HomeState state) {
    return Container(
      constraints: BoxConstraints(minHeight: constraints.maxHeight),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 4,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) => PokemonCard(
          text: state.pokemonList[index].name,
          index: index + 1,
          isFavourite: false,
        ),
        itemCount: 20,
      ),
    );
  }

  Widget _favouriteList(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return state.favouriteList.isEmpty
            ? SizedBox(
                height: 70,
                child: Center(
                  child: Text(
                    'No favourites yet',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              )
            : SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: 160,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      const PokemonCard(isFavourite: true),
                ),
              );
      },
    );
  }

  Widget _seeFavouritesText() {
    return GestureDetector(
      child: Text(
        'See All',
        style: TextStyle(
          fontSize: 18,
          color: Colors.yellow[700],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}


// List<Pokemon> pokemonList = snapshot.data as List<Pokemon>;
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     
//                     
//                     
//                   ],
//                 );
