part of 'tourguide_ticket_bloc.dart';

abstract class TourguideTicketEvent extends Equatable {
  const TourguideTicketEvent();
}

class BuyTourGuideTicket extends TourguideTicketEvent {
  final TourGuideTicket tourGuideTicket;

  BuyTourGuideTicket(this.tourGuideTicket);

  @override
  List<Object> get props => [tourGuideTicket];
}

class GetTourGuideTicket extends TourguideTicketEvent {
  @override
  List<Object> get props => [];
}

class ReviewTourGuideTicket extends TourguideTicketEvent {
  final TourGuideTicket tourGuideTicket;

  ReviewTourGuideTicket(this.tourGuideTicket);

  @override
  List<Object> get props => [tourGuideTicket];
}
