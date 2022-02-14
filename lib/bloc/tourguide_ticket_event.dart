part of 'tourguide_ticket_bloc.dart';

abstract class TourguideTicketEvent extends Equatable {
  const TourguideTicketEvent();
}

class BuyTourGuideTicket extends TourguideTicketEvent {
  final TourGuideTicket tourGuideTicket;
  final User user;

  BuyTourGuideTicket(this.tourGuideTicket, this.user);

  @override
  List<Object> get props => [tourGuideTicket, user];
}

class GetTourGuideTicket extends TourguideTicketEvent {
  final String userID;

  GetTourGuideTicket(this.userID);

  @override
  List<Object> get props => [userID];
}
