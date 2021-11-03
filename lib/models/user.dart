part of 'models.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String profilePicture;
  final String hp;
  final List<String> favorites;

  User(this.id, this.email, {this.name, this.profilePicture, this.hp, this.favorites = const []});

  User copyWith(
          {String name, String email, String profilePicture, String hp, List<String> favorites}) =>
      User(this.id, email ?? this.email,
          name: name ?? this.name,
          profilePicture: profilePicture ?? this.profilePicture,
          hp: hp ?? this.hp,
          favorites: favorites ?? this.favorites
          );

  @override
  List<Object> get props => [id, name, email, profilePicture, hp, favorites];
}
