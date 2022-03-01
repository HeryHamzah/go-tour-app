import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_tourguide_app/models/models.dart';
import 'package:travel_tourguide_app/services/services.dart';

part 'tourguide_ticket_event.dart';
part 'tourguide_ticket_state.dart';

class TourguideTicketBloc
    extends Bloc<TourguideTicketEvent, TourguideTicketState> {
  TourguideTicketBloc() : super(TourguideTicketState([]));

  @override
  Stream<TourguideTicketState> mapEventToState(
    TourguideTicketEvent event,
  ) async* {
    if (event is BuyTourGuideTicket) {
      await UserServices.saveTourGuideTicket(event.tourGuideTicket);

      List<TourGuideTicket> tourGuideTickets =
          state.tourGuideTickets + [event.tourGuideTicket];

      yield TourguideTicketState(tourGuideTickets);
    } else if (event is GetTourGuideTicket) {
      List<TourGuideTicket> tourGuideTickets =
          await UserServices.getTourGuideTickets();

      yield TourguideTicketState(tourGuideTickets);
    } else if (event is ReviewTourGuideTicket) {
      await UserServices.addTourGuideReview(event.tourGuideTicket.bookingCode,
          event.tourGuideTicket.comment, event.tourGuideTicket.rating);

      List<TourGuideTicket> tourGuideTickets = state.tourGuideTickets;
      tourGuideTickets.removeWhere((tourGuideTicket) =>
          tourGuideTicket.bookingCode == event.tourGuideTicket.bookingCode);

      tourGuideTickets.add(event.tourGuideTicket);
      yield TourguideTicketState(tourGuideTickets);
    }
  }
}
