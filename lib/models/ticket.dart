part of 'models.dart';

class Ticket extends Equatable {
  final Destination destination;
  final DateTime time;
  final String bookingCode;
  final String name;
  final int totalTicket;
  final int totalPrice;

  Ticket(this.destination, this.time, this.bookingCode, this.name,
      this.totalTicket, this.totalPrice);

  @override
  List<Object> get props =>
      [destination, time, bookingCode, name, totalTicket, totalPrice];
}
