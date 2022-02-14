part of 'tourguide_ticket_bloc.dart';

class TourguideTicketState extends Equatable {
  final List<TourGuideTicket> tourGuideTickets;

  TourguideTicketState(this.tourGuideTickets);

  @override
  List<Object> get props => [tourGuideTickets];
}
