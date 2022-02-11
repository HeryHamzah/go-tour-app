part of 'models.dart';

class Destination extends Equatable {
  final String id;
  final String name;
  final String price;
  final String about;
  final String location;
  final List<String> images;
  final double rating;

  Destination(
      {this.id,
      this.name,
      this.price,
      this.about,
      this.location,
      this.images,
      this.rating});

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
      id: json['id_destination'],
      name: json['name'],
      price: json['price'],
      about: json['about'],
      location: json['location'],
      images: (json['images'] as String).split(","),
      rating: double.tryParse(json['rating'] ?? 0));

  @override
  List<Object> get props => [id, name, price, about, location, images];
}
