part of 'favorite_destination_bloc.dart';

abstract class FavoriteDestinationEvent extends Equatable {
  const FavoriteDestinationEvent();
}

class AddToFavorites extends FavoriteDestinationEvent {
  final String idUser;
  final Destination destination;

  AddToFavorites({this.idUser, this.destination});
  @override
  List<Object> get props => [idUser, destination];
}

class RemoveFromFavorites extends FavoriteDestinationEvent {
  final Destination destination;

  RemoveFromFavorites(this.destination);
  @override
  List<Object> get props => [destination];
}

class GetFavorites extends FavoriteDestinationEvent {
  final String idUser;

  GetFavorites(this.idUser);
  @override
  List<Object> get props => [idUser];
}
