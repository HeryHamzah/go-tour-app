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
          imageFile: event.imageFile, idUser: event.idUser);

      User updatedUser = await UserServices.getUser(event.idUser);

      yield UserLoaded(updatedUser);
    } else if (event is UpdateUser) {
      User user = await UserServices.updateUser(event.user);

      // print(user.id +
      //     " " +
      //     user.email +
      //     " " +
      //     user.name +
      //     " " +
      //     user.hp +
      //     " " +
      //     user.profilePicture);

      // await AuthServices.updateEmail(user.email);

      yield UserLoaded(user);
    }
  }
}
