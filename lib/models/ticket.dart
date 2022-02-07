part of 'models.dart';

class Ticket extends Equatable {
  final String bookingCode;
  final Destination destination;
  final DateTime time;
  final String name;
  final int totalTicket;
  final int totalPrice;

  Ticket(
      {this.bookingCode,
      this.destination,
      this.time,
      this.name,
      this.totalTicket,
      this.totalPrice});

  factory Ticket.fromJson(Map<String, dynamic> json, Destination destination) =>
      Ticket(
          bookingCode: json["booking_code"],
          destination: destination,
          name: json["name"],
          totalTicket: int.tryParse(json["total_ticket"]),
          totalPrice: int.tryParse(json["total_price"]),
          time:
              DateTime.fromMillisecondsSinceEpoch(int.tryParse(json["time"])));

  @override
  List<Object> get props =>
      [bookingCode, destination, time, name, totalTicket, totalPrice];
}
