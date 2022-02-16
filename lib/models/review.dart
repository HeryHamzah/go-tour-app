part of 'models.dart';

class Review extends Equatable {
  final String coment;
  final String userName;
  final String userPicture;
  final double rating;

  Review({this.coment, this.userName, this.userPicture, this.rating});

  factory Review.fromJson(Map<String, dynamic> json) => Review(
      coment: json['coment'],
      userName: json['user_name'],
      userPicture: json['user_picture'],
      rating: double.tryParse(json['rating']));

  @override
  List<Object> get props => [coment, userName, rating];
}
