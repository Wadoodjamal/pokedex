import 'package:flutter/material.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({
    Key? key,
    this.isFavourite = false,
    this.text,
    this.index = 1,
    this.func,
  }) : super(key: key);

  final bool isFavourite;
  final String? text;
  final Function()? func;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      height: 180,
      width: 155,
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
            width: 150,
            child: ListTile(
              visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
              title: Text(
                text?.toUpperCase() ?? 'Bulbusar'.toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              trailing: GestureDetector(
                onTap: func,
                child: Icon(
                  isFavourite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
