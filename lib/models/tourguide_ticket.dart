part of 'models.dart';

class TourGuideTicket extends Equatable {
  final String bookingCode;
  final DateTime dateTime;
  final String userName;
  final String tourGuideID;
  final String tourGuideName;
  final String destinations;
  final int totalPrice;
  final String image;

  TourGuideTicket(
      {this.bookingCode,
      this.dateTime,
      this.userName,
      this.tourGuideID,
      this.tourGuideName,
      this.destinations,
      this.totalPrice,
      this.image});

  factory TourGuideTicket.fromJson(Map<String, dynamic> json) =>
      TourGuideTicket(
          bookingCode: json['id'],
          dateTime: DateTime.fromMillisecondsSinceEpoch(
              int.tryParse(json["date_time"])),
          userName: json['user_name'],
          tourGuideName: json['tourguide_name'],
          destinations: json['destinations'],
          totalPrice: int.tryParse(json['total_price']),
          image: json['picture_path']);

  @override
  List<Object> get props => [
        bookingCode,
        dateTime,
        userName,
        tourGuideID,
        tourGuideName,
        destinations,
        totalPrice,
        image
      ];
}
