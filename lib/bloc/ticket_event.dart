part of 'ticket_bloc.dart';

abstract class TicketEvent extends Equatable {
  const TicketEvent();
}

class BuyTicket extends TicketEvent {
  final Ticket ticket;

  BuyTicket(this.ticket);

  @override
  List<Object> get props => [ticket];
}

class GetTickets extends TicketEvent {
  @override
  List<Object> get props => [];
}

class ReviewTicket extends TicketEvent {
  final Ticket ticket;

  ReviewTicket(this.ticket);

  @override
  List<Object> get props => [ticket];
}
