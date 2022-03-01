part of 'models.dart';

class TourGuide extends Equatable {
  final String tourGuideID;
  final String name;
  final String email;
  final String profilePicture;
  final String hp;
  final String locationID;
  final String location;
  final double rating;
  final int balance;
  final String numberOfReviews;
  final String numberOfTrips;
  final int cost;

  TourGuide(
      {this.tourGuideID,
      this.name,
      this.email,
      this.profilePicture,
      this.hp,
      this.locationID,
      this.location,
      this.rating = 0.0,
      this.balance,
      this.numberOfReviews,
      this.numberOfTrips,
      this.cost});

  factory TourGuide.fromJon(Map<String, dynamic> json) => TourGuide(
      tourGuideID: json['id'],
      name: json['name'],
      email: json['email'],
      profilePicture: json['image'],
      hp: json['hp'],
      locationID: json['id_location'],
      location: json['location_name'],
      balance: int.tryParse(json['balance']),
      rating: double.tryParse(json['rating']),
      numberOfReviews: json['number_of_reviews'],
      numberOfTrips: json['number_of_trips'],
      cost: int.tryParse(json['cost']));

  @override
  List<Object> get props => [
        tourGuideID,
        name,
        email,
        profilePicture,
        hp,
        locationID,
        location,
        rating,
        balance,
        numberOfReviews,
        numberOfTrips,
        cost
      ];
}
