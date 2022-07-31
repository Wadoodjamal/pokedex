import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/states/favourite_state.dart';
import 'package:pokedex/shared_preferences.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(const FavouriteStateInitial());

  Future<void> waitForScreenLoad() async {
    await Future.delayed(const Duration(seconds: 1));
    emit(const FavouritesStateLoading());
  }

  Future<void> loadingFavourite() async {
    var favouriteList = await getFavouriteList();
    loadedState(favouriteList: favouriteList);
  }

  void loadedState({List<dynamic>? favouriteList}) {
    emit(FavouritesStateLoaded(favouriteList: favouriteList));
  }
}
