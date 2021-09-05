part of 'extensions.dart';

extension FirebaseUSerExtensions on auth.User {
  User convertToUser({String name = "No Name", String hp = ""}) =>
      User(this.uid, this.email, name: name, hp: hp);
}
