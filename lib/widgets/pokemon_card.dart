import 'package:flutter/material.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({
    Key? key,
    this.isFavourite = false,
    this.text,
    this.index = 1,
  }) : super(key: key);

  final bool isFavourite;
  final String? text;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      height: 180,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[500],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.network(
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$index.png',
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 140,
            child: ListTile(
              visualDensity: const VisualDensity(vertical: -4),
              title: Text(
                text ?? 'Bulbusar',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              trailing: Icon(
                isFavourite ? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
