import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:travel_tourguide_app/models/models.dart';
import 'package:travel_tourguide_app/services/services.dart';

part 'favorite_destination_event.dart';
part 'favorite_destination_state.dart';

class FavoriteDestinationBloc
    extends Bloc<FavoriteDestinationEvent, FavoriteDestinationState> {
  FavoriteDestinationBloc() : super(FavoriteDestinationState([]));

  @override
  Stream<FavoriteDestinationState> mapEventToState(
      FavoriteDestinationEvent event) async* {
    if (event is AddToFavorites) {
      await UserServices.addToFavorites(event.idUser, event.destination);

      List<Destination> destinations = state.destinations + [event.destination];

      yield FavoriteDestinationState(destinations);
    } else if (event is RemoveFromFavorites) {
      await UserServices.removeFromFavorites(event.idFavorite);

      List<Destination> destinations = state.destinations;
      destinations.remove(event.destination);

      yield FavoriteDestinationState(destinations);
    } else if (event is GetFavorites) {
      List<Destination> destinations =
          await UserServices.getFavorites(event.idUser);

      yield FavoriteDestinationState(destinations);
    }
  }
}
