part of 'models.dart';

class Destination extends Equatable {
  final String id;
  final String name;
  final String price;
  final String about;
  final String location;
  final List<String> images;

  Destination(
      {this.id, this.name, this.price, this.about, this.location, this.images});

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        id: json['id_destination'],
        name: json['name'],
        price: json['price'],
        about: json['about'],
        location: json['location'],
        images: (json['images'] as String).split(","),
      );

  @override
  List<Object> get props => [id, name, price, about, location, images];
}
