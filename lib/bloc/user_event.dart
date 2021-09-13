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
  final User user;

  UploadProfileUser({this.imageFile, this.user});
  @override
  List<Object> get props => [imageFile, user];
}
