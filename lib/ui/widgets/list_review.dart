part of 'widgets.dart';

class ListReview extends StatelessWidget {
  final Iterable<Ticket> tickets;
  final Iterable<TourGuideTicket> tourGuideTickets;

  ListReview({this.tickets, this.tourGuideTickets});

  @override
  Widget build(BuildContext context) {
    return tickets != null
        ? generateListDestinationReview(tickets)
        : generateListTourGuideReview(tourGuideTickets);
  }

  Widget generateListDestinationReview(Iterable<Ticket> tickets) {
    if (tickets.length > 0) {
      return ListView(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 20),
            child: Column(
              children: tickets
                  .map((ticket) => Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                    radius: 15,
                                    backgroundImage: (ticket.userImage == "")
                                        ? AssetImage("assets/avatar.png")
                                        : NetworkImage(BaseUrl.getUserImages +
                                            ticket.userImage)),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  ticket.userName,
                                  style: themeFont.copyWith(
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Rating(rating: ticket.rating),
                            SizedBox(
                              height: 6,
                            ),
                            Text(ticket.comment)
                          ],
                        ),
                      )))
                  .toList(),
            ),
          )
        ],
      );
    } else {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/no_data.png"),
          Text("Belum Ada Ulasan"),
        ],
      ));
    }
  }

  Widget generateListTourGuideReview(
      Iterable<TourGuideTicket> tourGuideTickets) {
    if (tourGuideTickets.length > 0) {
      return ListView(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 20),
            child: Column(
              children: tourGuideTickets
                  .map((tourGuideTicket) => Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                    radius: 15,
                                    backgroundImage:
                                        (tourGuideTicket.userPicture == "")
                                            ? AssetImage("assets/avatar.png")
                                            : NetworkImage(BaseUrl
                                                    .getUserImages +
                                                tourGuideTicket.userPicture)),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  tourGuideTicket.userName,
                                  style: themeFont.copyWith(
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Rating(rating: tourGuideTicket.rating),
                            SizedBox(
                              height: 6,
                            ),
                            Text(tourGuideTicket.comment)
                          ],
                        ),
                      )))
                  .toList(),
            ),
          )
        ],
      );
    } else {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/no_data.png"),
          Text("Belum Ada Ulasan"),
        ],
      ));
    }
  }
}
