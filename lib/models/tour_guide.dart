part of 'models.dart';

class TourGuide extends Equatable {
  final String tourGuideID;
  final String name;
  final String email;
  final String profilePicture;
  final String hp;
  final String location;
  final double rating;
  final int balance;

  TourGuide(
      {this.tourGuideID,
      this.name,
      this.email,
      this.profilePicture,
      this.hp,
      this.location,
      this.rating = 0,
      this.balance});

  factory TourGuide.fromJon(Map<String, dynamic> json) => TourGuide(
      tourGuideID: json['id'],
      name: json['name'],
      email: json['email'],
      profilePicture: json['image'],
      hp: json['hp'],
      location: json['location_name'],
      balance: int.tryParse(json['balance']));
  @override
  List<Object> get props =>
      [tourGuideID, name, email, profilePicture, hp, location, rating, balance];
}
