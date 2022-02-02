part of 'models.dart';

class Ticket extends Equatable {
  final Destination destination;
  final DateTime time;
  final String name;
  final int totalTicket;
  final int totalPrice;

  Ticket(
      {this.destination,
      this.time,
      this.name,
      this.totalTicket,
      this.totalPrice});

  @override
  List<Object> get props => [destination, time, name, totalTicket, totalPrice];
}
