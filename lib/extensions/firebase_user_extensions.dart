part of 'extensions.dart';

extension FirebaseUserExtensions on auth.User {
  User convertToUser(
          {String name = "No Name",
          String hp = "",
          List<String> favorites = const [],
          List<String> myTrips = const []}) =>
      User(this.uid, this.email,
          name: name, hp: hp, favorites: favorites, myTrips: myTrips);

  Future<User> fromDatabase() async => await UserServices.getUser(this.uid);
}
