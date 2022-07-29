import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/states/favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(const FavouriteStateInitial());

  Future<void> waitForScreenLoad() async {
    await Future.delayed(const Duration(seconds: 1));
    emit(const FavouritesStateLoading());
  }

  Future<void> loadingFavouritesAndPokemons() async {
    loadedState();
  }

  void loadedState() {
    emit(const FavouritesStateLoaded());
  }
}
