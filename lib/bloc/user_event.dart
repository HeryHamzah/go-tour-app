part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoadUser extends UserEvent {
  final String id;

  LoadUser(this.id);

  @override
  List<Object> get props => [id];
}

class SignOutUser extends UserEvent {
  @override
  List<Object> get props => [];
}

class UploadProfileUser extends UserEvent {
  final File imageFile;
  final String idUser;

  UploadProfileUser({this.imageFile, this.idUser});
  @override
  List<Object> get props => [imageFile, idUser];
}

class UpdateUser extends UserEvent {
  final User user;

  UpdateUser(this.user);
  @override
  List<Object> get props => [user];
}

class AddToFavorites extends UserEvent {
  final String idDestination;

  AddToFavorites(this.idDestination);

  @override
  List<Object> get props => [idDestination];
}

class RemoveFromFavorites extends UserEvent {
  final String idDestination;

  RemoveFromFavorites(this.idDestination);

  @override
  List<Object> get props => [idDestination];
}

class AddToMyTrip extends UserEvent {
  final String idDestination;

  AddToMyTrip(this.idDestination);

  @override
  List<Object> get props => [idDestination];
}

class RemoveFromMyTrip extends UserEvent {
  final String idDestination;

  RemoveFromMyTrip(this.idDestination);

  @override
  List<Object> get props => [idDestination];
}

class TopUp extends UserEvent {
  final int amount;

  TopUp(this.amount);
  @override
  List<Object> get props => [amount];
}
