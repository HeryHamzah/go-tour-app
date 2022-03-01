part of 'models.dart';

class TourGuideTicket extends Equatable {
  final String bookingCode;
  final DateTime dateTime;
  final String userName;
  final TourGuide tourGuide;
  // final String tourGuideID;
  // final String tourGuideName;
  final String destinations;
  final int totalPrice;
  // final String image;
  final String userID;
  final String userPicture;
  final String comment;
  final double rating;

  TourGuideTicket(
      {this.bookingCode,
      this.dateTime,
      this.userName,
      this.tourGuide,
      this.destinations,
      this.totalPrice,
      this.userID,
      this.userPicture,
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
          userName: this.userName,
          tourGuide: this.tourGuide,
          destinations: this.destinations,
          totalPrice: this.totalPrice,
          userID: this.userID,
          userPicture: this.userPicture,
          comment: comment ?? this.comment,
          rating: rating ?? this.rating);

  factory TourGuideTicket.fromJson(Map<String, dynamic> json) =>
      TourGuideTicket(
          bookingCode: json['id'],
          dateTime: DateTime.fromMillisecondsSinceEpoch(
              int.tryParse(json["date_time"])),
          userName: json['user_name'],
          tourGuide: TourGuide(
              name: json['tourguide_name'],
              profilePicture: json['tourguide_picture']),
          // tourGuideName: json['tourguide_name'],
          destinations: json['destinations'],
          totalPrice: int.tryParse(json['total_price']),
          // image: json['profile_picture'],
          userPicture: json['user_picture'],
          userID: json['id_user'],
          comment: json['comment'],
          rating: double.tryParse(json['rating']));

  @override
  List<Object> get props => [
        bookingCode,
        dateTime,
        userName,
        tourGuide,
        destinations,
        totalPrice,
        userID,
        userPicture,
        comment,
        rating
      ];
}
