part of 'favorite_destination_bloc.dart';

class FavoriteDestinationState extends Equatable {
  final List<Destination> destinations;

  FavoriteDestinationState(this.destinations);

  @override
  List<Object> get props => [destinations];
}
