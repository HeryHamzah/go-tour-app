part of 'extensions.dart';

extension FirebaseUserExtensions on auth.User {
  User convertToUser(
          {String name = "No Name",
          String hp = "",
          int balance = 0,
          List<String> favorites = const [],
          List<String> myTrips = const []}) =>
      User(this.uid, this.email,
          name: name,
          hp: hp,
          balance: balance,
          favorites: favorites,
          myTrips: myTrips);

  Future<User> fromDatabase() async => await UserServices.getUser(this.uid);
}
