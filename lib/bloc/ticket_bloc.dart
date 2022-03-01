import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_tourguide_app/models/models.dart';
import 'package:travel_tourguide_app/services/services.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketBloc() : super(TicketState([]));

  @override
  Stream<TicketState> mapEventToState(
    TicketEvent event,
  ) async* {
    if (event is BuyTicket) {
      await UserServices.saveticket(event.ticket);

      List<Ticket> tickets = state.tickets + [event.ticket];

      yield TicketState(tickets);
    } else if (event is GetTickets) {
      List<Ticket> tickets = await UserServices.getTickets();
      yield TicketState(tickets);
    } else if (event is ReviewTicket) {
      await UserServices.addDestinationReview(
          event.ticket.bookingCode, event.ticket.comment, event.ticket.rating);

      Ticket ticket = event.ticket;
      List<Ticket> tickets = state.tickets;
      tickets.removeWhere(
          (ticket) => ticket.bookingCode == event.ticket.bookingCode);
      tickets.add(ticket);

      yield TicketState(tickets);
    }
  }
}
