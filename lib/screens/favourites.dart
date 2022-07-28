import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/api/pokemon.dart';
import 'package:pokedex/widgets/pokemon_card.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  void _getPokemon() async {
    Dio dio = Dio();
    await dio.get('https://pokeapi.co/api/v2/pokemon/').then((response) {
      List<dynamic> data = response.data['results'];
      List<Pokemon> pokemonList = data.map((e) => Pokemon.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    _getPokemon();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
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
                SizedBox(
                  height: MediaQuery.of(context).size.height - 150,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 4,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) =>
                        const PokemonCard(isFavourite: true),
                    itemCount: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
