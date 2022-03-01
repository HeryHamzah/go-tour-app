part of 'models.dart';

class Destination extends Equatable {
  final String id;
  final String name;
  final String price;
  final String about;
  final String locationID;
  final String locationName;
  final List<String> images;
  final double rating;
  final String numberOfVisits;
  final String numberOfReviews;

  Destination(
      {this.id,
      this.name,
      this.price,
      this.about,
      this.locationID,
      this.locationName,
      this.images,
      this.rating = 0.0,
      this.numberOfVisits,
      this.numberOfReviews});

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
      id: json['id_destination'],
      name: json['name'],
      price: json['price'],
      about: json['about'],
      locationID: json['id_location'],
      locationName: json['location_name'],
      images: (json['images'] as String).split(","),
      rating: double.tryParse(json['rating']),
      numberOfVisits: json['number_of_visits'],
      numberOfReviews: json['number_of_reviews']);

  @override
  List<Object> get props => [
        id,
        name,
        price,
        about,
        locationID,
        locationName,
        images,
        rating,
        numberOfVisits,
        numberOfReviews
      ];
}
