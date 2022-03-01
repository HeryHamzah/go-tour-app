part of 'models.dart';

class Ticket extends Equatable {
  final String bookingCode;
  final Destination destination;
  final DateTime time;
  final String userID;
  final String userName;
  final String userImage;
  final int totalTicket;
  final int totalPrice;
  final String comment;
  final double rating;

  Ticket(
      {this.bookingCode,
      this.destination,
      this.time,
      this.userID,
      this.userName,
      this.userImage,
      this.totalTicket,
      this.totalPrice,
      this.comment,
      this.rating});

  Ticket copyWith(
          {String bookingCode,
          Destination destination,
          DateTime time,
          String userID,
          String userName,
          String userImage,
          int totalTicket,
          int totalPrice,
          String comment,
          double rating}) =>
      Ticket(
          bookingCode: this.bookingCode,
          destination: this.destination,
          time: this.time,
          userID: this.userID,
          userName: this.userName,
          userImage: this.userImage,
          totalTicket: this.totalTicket,
          totalPrice: this.totalPrice,
          comment: comment ?? this.comment,
          rating: rating ?? this.rating);

  factory Ticket.fromJson(Map<String, dynamic> json, Destination destination) =>
      Ticket(
          bookingCode: json["booking_code"],
          destination: destination,
          userID: json["id_user"],
          userName: json["user_name"],
          userImage: json["profile_picture"],
          totalTicket: int.tryParse(json["total_ticket"]),
          totalPrice: int.tryParse(json["total_price"]),
          time: DateTime.fromMillisecondsSinceEpoch(int.tryParse(json["time"])),
          comment: json["comment"],
          rating: double.tryParse(json["rating"]));

  @override
  List<Object> get props => [
        bookingCode,
        destination,
        time,
        userID,
        userName,
        userImage,
        totalTicket,
        totalPrice,
        comment,
        rating
      ];
}
