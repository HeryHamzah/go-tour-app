part of 'models.dart';

class Location extends Equatable {
  final String id;
  final String name;
  final String image;

  Location({this.id, this.name, this.image});

  @override
  List<Object> get props => [id, name, image];
}
