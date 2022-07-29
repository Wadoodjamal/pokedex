import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/api/pokemon.dart';
import 'package:pokedex/bloc/states/home_state.dart';
import 'package:pokedex/shared_preferences.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeStateInitial());

  Future<void> waitForScreenLoad() async {
    await Future.delayed(const Duration(seconds: 1));
    emit(HomeStateLoading());
  }

  Future<void> loadingFavouritesAndPokemons() async {
    List<dynamic> favouriteList = await getFavouriteList();
    var pokemonList = await Pokemon.getPokemon();
    loadedState(favouriteList: favouriteList, pokemonList: pokemonList);
  }

  void loadedState({List<dynamic>? favouriteList, List<Pokemon>? pokemonList}) {
    emit(HomeStateLoaded(
        favouriteList: favouriteList, pokemonList: pokemonList));
  }
}
