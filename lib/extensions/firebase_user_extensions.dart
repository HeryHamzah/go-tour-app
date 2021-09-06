part of 'extensions.dart';

extension FirebaseUserExtensions on auth.User {
  User convertToUser({String name = "No Name", String hp = ""}) =>
      User(this.uid, this.email, name: name, hp: hp);

  Future<User> fromDatabase() async => await UserServices.getUser(this.uid);
}
