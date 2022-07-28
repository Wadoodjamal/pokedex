import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/api/pokemon.dart';
import 'package:pokedex/screens/favourites.dart';
import 'package:pokedex/widgets/pokemon_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: Pokemon.getPokemon(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List<Pokemon> pokemonList = snapshot.data as List<Pokemon>;
                return Column(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Favourites',
                            style: TextStyle(
                              fontSize: 24,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FavouritesScreen(),
                              ),
                            ),
                            child: Text(
                              'See All',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.yellow[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 160,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            const PokemonCard(isFavourite: true),
                      ),
                    ),
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 140,
                      width: MediaQuery.of(context).size.width,
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 4,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) => PokemonCard(
                          text: pokemonList[index].name,
                          index: index + 1,
                          isFavourite: false,
                        ),
                        itemCount: 20,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
