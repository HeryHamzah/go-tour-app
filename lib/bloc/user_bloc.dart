import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_tourguide_app/models/models.dart';
import 'package:travel_tourguide_app/services/services.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is LoadUser) {
      User user = await UserServices.getUser(event.id);

      yield UserLoaded(user);
    } else if (event is SignOutUser) {
      yield UserInitial();
    } else if (event is UploadProfileUser) {
      await UserServices.uploadImage(
          imageFile: event.imageFile, userID: event.idUser);

      User updatedUser = await UserServices.getUser(event.idUser);

      yield UserLoaded(updatedUser);
    } else if (event is UpdateUser) {
      User user = await UserServices.updateUser(event.user);

      yield UserLoaded(user);
    } else if (event is AddToFavorites) {
      User updatedUser = (state as UserLoaded).user.copyWith(
          favorites:
              (state as UserLoaded).user.favorites + [event.idDestination]);

      await UserServices.updateUser(updatedUser);

      yield UserLoaded(updatedUser);
    } else if (event is RemoveFromFavorites) {
      List<String> idDestinations = (state as UserLoaded).user.favorites;
      idDestinations.remove(event.idDestination);

      User updatedUser =
          (state as UserLoaded).user.copyWith(favorites: idDestinations);

      await UserServices.updateUser(updatedUser);

      yield UserLoaded(updatedUser);
    } else if (event is TopUp) {
      int balance = (state as UserLoaded).user.balance + event.amount;

      User updatedUser = (state as UserLoaded).user.copyWith(balance: balance);

      await UserServices.updateUser(updatedUser);
      yield UserLoaded(updatedUser);
    } else if (event is Purchase) {
      int balance = (state as UserLoaded).user.balance - event.amount;

      User updatedUser = (state as UserLoaded).user.copyWith(balance: balance);
      await UserServices.updateUser(updatedUser);
      yield UserLoaded(updatedUser);
    }
  }
}
