part of 'models.dart';

class Destination extends Equatable {
  final String id;
  final String name;
  final String price;
  final String location;
  final List<String> images;

  Destination({this.id, this.name, this.price, this.location, this.images});

  @override
  List<Object> get props => [id, name, price, location, images];
}
