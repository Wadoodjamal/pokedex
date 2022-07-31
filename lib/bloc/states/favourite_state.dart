class FavouriteState {
  final List<dynamic> favouriteList;

  const FavouriteState({this.favouriteList = const []});
}

class FavouriteStateInitial extends FavouriteState {
  const FavouriteStateInitial();
}

class FavouritesStateLoading extends FavouriteState {
  const FavouritesStateLoading();
}

class FavouritesStateLoaded extends FavouriteState {
  FavouritesStateLoaded({List<dynamic>? favouriteList})
      : super(favouriteList: favouriteList ?? []);
}
