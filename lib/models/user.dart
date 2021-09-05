part of 'models.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String profilePicture;
  final String hp;

  User(this.id, this.email, {this.name, this.profilePicture, this.hp});

  User copyWith(
          {String name, String email, String profilePicture, String hp}) =>
      User(this.id, this.email,
          name: name ?? this.name,
          profilePicture: profilePicture ?? this.profilePicture,
          hp: hp ?? this.hp);

  @override
  List<Object> get props => [id, name, email, profilePicture, hp];
}
