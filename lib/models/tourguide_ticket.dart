part of 'models.dart';

class TourGuideTicket extends Equatable {
  final String bookingCode;
  final DateTime dateTime;
  final TourGuide tourGuide;
  final User user;
  final String destinations;
  final int totalPrice;
  final String comment;
  final double rating;

  TourGuideTicket(
      {this.bookingCode,
      this.dateTime,
      this.tourGuide,
      this.user,
      this.destinations,
      this.totalPrice,
      this.comment,
      this.rating});

  TourGuideTicket copyWith({
    String bookingCode,
    DateTime dateTime,
    String userName,
    TourGuide tourGuide,
    String destinations,
    int totalPrice,
    String userID,
    String userPicture,
    String comment,
    double rating,
  }) =>
      TourGuideTicket(
          bookingCode: this.bookingCode,
          dateTime: this.dateTime,
          tourGuide: this.tourGuide,
          user: this.user,
          destinations: this.destinations,
          totalPrice: this.totalPrice,
          comment: comment ?? this.comment,
          rating: rating ?? this.rating);

  factory TourGuideTicket.fromJson(Map<String, dynamic> json) =>
      TourGuideTicket(
          bookingCode: json['id'],
          dateTime: DateTime.fromMillisecondsSinceEpoch(
              int.tryParse(json["date_time"])),
          tourGuide: TourGuide(
              tourGuideID: json['id_tourguide'],
              name: json['tourguide_name'],
              profilePicture: json['tourguide_picture'],
              hp: json['tourguide_contact'],
              email: json['tourguide_email']),
          user: User(json['id_user'], json['user_email'],
              name: json['user_name'],
              profilePicture: json['user_picture'],
              hp: json['user_contact']),
          destinations: json['destinations'],
          totalPrice: int.tryParse(json['total_price']),
          comment: json['comment'],
          rating: double.tryParse(json['rating']));

  @override
  List<Object> get props => [
        bookingCode,
        dateTime,
        tourGuide,
        user,
        destinations,
        totalPrice,
        comment,
        rating
      ];
}
