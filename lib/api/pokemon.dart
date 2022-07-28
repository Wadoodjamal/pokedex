import 'package:dio/dio.dart';

class Pokemon {
  Pokemon({
    this.name,
    this.url,
  });

  String? name;
  String? url;

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        name: json["name"] as String,
        url: json["url"] as String,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };

  static Future<List<Pokemon>> getPokemon() async {
    Dio dio = Dio();
    List<Pokemon> pokemonList = [];
    await dio.get('https://pokeapi.co/api/v2/pokemon/').then((response) {
      List<dynamic> data = response.data['results'];
      pokemonList = data.map((e) => Pokemon.fromJson(e)).toList();
    });
    return pokemonList;
  }
}
