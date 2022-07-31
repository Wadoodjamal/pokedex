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
    var pokemonList = await Pokemon.getPokemon();
    var favouriteList = await getFavouriteList();
    loadedState(favouriteList: favouriteList, pokemonList: pokemonList);
  }

  void loadedState({List<dynamic>? favouriteList, List<Pokemon>? pokemonList}) {
    emit(HomeStateLoaded(
        favouriteList: favouriteList, pokemonList: pokemonList));
  }

  void addToFavourites(Pokemon pokemon, int index) {
    if (state.favouriteList.isEmpty) {
      emit(state.copyWith(
          favouriteList: state.favouriteList
            ..add({'pokemon': pokemon, 'index': index})));
      storeFavourite(state.favouriteList);
    } else {
      var check = false;
      for (int i = 0; i < state.favouriteList.length; i++) {
        if (state.favouriteList[i]['pokemon'].name == pokemon.name) {
          check = true;
          break;
        }
      }
      if (!check) {
        emit(state.copyWith(
            favouriteList: state.favouriteList
              ..add({'pokemon': pokemon, 'index': index})));
        storeFavourite(state.favouriteList);
      }
    }
  }
}
