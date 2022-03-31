part of '../pages.dart';

class ReviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    Destination destination = data[0];
    TourGuide tourGuide = data[1];

    return Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            leading: InkWell(
              onTap: () => Get.back(),
              child: Icon(Icons.arrow_back_ios_new),
            ),
            title:
                Text(destination == null ? tourGuide.name : destination.name)),
        body: BlocBuilder<TourguideTicketBloc, TourguideTicketState>(
          builder: (context, tourGuideTicketState) {
            Iterable<TourGuideTicket> tourGuideTickets = (tourGuide != null)
                ? tourGuideTicketState.tourGuideTickets
                    .where((tourGuideTicket) =>
                        tourGuideTicket.tourGuide.tourGuideID ==
                        tourGuide.tourGuideID)
                    .where((tourGuideTicket) => tourGuideTicket.rating > 0)
                : [];

            return BlocBuilder<TicketBloc, TicketState>(
              builder: (context, ticketState) {
                Iterable<Ticket> tickets = (destination != null)
                    ? ticketState.tickets
                        .where(
                            (ticket) => ticket.destination.id == destination.id)
                        .where((ticket) => ticket.rating > 0)
                    : [];

                return (destination != null)
                    ? ListReview(
                        tickets: tickets,
                        tourGuideTickets: null,
                      )
                    : ListReview(
                        tickets: null, tourGuideTickets: tourGuideTickets);
              },
            );
          },
        ));
  }
}
