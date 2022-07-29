import 'package:pokedex/api/pokemon.dart';

class HomeState {
  final List<Pokemon> pokemonList;
  final List<dynamic> favouriteList;

  const HomeState({
    this.pokemonList = const [],
    this.favouriteList = const [],
  });

  HomeState copyWith({
    List<Pokemon>? pokemonList,
    List<dynamic>? favouriteList,
  }) {
    return HomeState(
      pokemonList: pokemonList ?? this.pokemonList,
      favouriteList: favouriteList ?? this.favouriteList,
    );
  }
}

class HomeStateInitial extends HomeState {
  HomeStateInitial() : super();
}

class HomeStateLoading extends HomeState {
  HomeStateLoading() : super();
}

class HomeStateLoaded extends HomeState {
  HomeStateLoaded({List<dynamic>? favouriteList, List<Pokemon>? pokemonList})
      : super(favouriteList: favouriteList!, pokemonList: pokemonList!);
}
