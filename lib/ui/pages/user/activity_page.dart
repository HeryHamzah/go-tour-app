part of "../pages.dart";

class ActivityPage extends StatefulWidget {
  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  String val = "Destinasi";

  void showRatingDialog(Ticket ticket, TourGuideTicket tourGuideTicket) {
    final _dialog = RatingDialog(
      title: Text(
        ticket != null
            ? ticket.destination.name
            : tourGuideTicket.tourGuide.name,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      message: Text(
        'Feedback Anda membantu Kami untuk lebih baik ke depannya',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15),
      ),
      image: Container(
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(ticket != null
                      ? BaseUrl.getAssets + ticket.destination.images[0]
                      : BaseUrl.getTourGuideImages +
                          tourGuideTicket.tourGuide.profilePicture),
                  fit: BoxFit.cover))),
      submitButtonText: 'Kirim',
      commentHint: 'Komentar',
      onCancelled: () => print('Batal'),
      onSubmitted: (response) async {
        print('rating: ${response.rating}, comment: ${response.comment}');

        ticket != null
            ? context.bloc<TicketBloc>().add(ReviewTicket(ticket.copyWith(
                comment: response.comment, rating: response.rating)))
            : context.bloc<TourguideTicketBloc>().add(ReviewTourGuideTicket(
                tourGuideTicket.copyWith(
                    comment: response.comment, rating: response.rating)));
       
      },
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => _dialog,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          backgroundColor: backColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: DropdownButton(
                dropdownColor: backColor,
                elevation: 0,
                value: val,
                iconSize: 30,
                items: [
                  DropdownMenuItem(
                    child: Text("Destinasi",
                        style: themeFont.copyWith(fontSize: 20)),
                    value: "Destinasi",
                  ),
                  DropdownMenuItem(
                    child: Text("Tour Guide",
                        style: themeFont.copyWith(fontSize: 20)),
                    value: "Tour Guide",
                  )
                ],
                onChanged: (value) {
                  setState(() {
                    val = value;
                  });
                }),
            bottom: TabBar(
              indicatorColor: mainColor,
              tabs: [
                Tab(
                  child: Text(
                    "Terbaru",
                    style: themeFont.copyWith(fontSize: 16),
                  ),
                ),
                Tab(
                  child: Text(
                    "Kedaluwarsa",
                    style: themeFont.copyWith(fontSize: 16),
                  ),
                )
              ],
            ),
          ),
          body: BlocBuilder<UserBloc, UserState>(
            builder: (_, userState) {
              User user = (userState as UserLoaded).user;
              return BlocBuilder<TourguideTicketBloc, TourguideTicketState>(
                builder: (_, tourGuideTicketState) {
                  return BlocBuilder<TicketBloc, TicketState>(
                      builder: (_, ticketState) {
                    return (val == "Destinasi")
                        ? generateDestination(ticketState, user.id)
                        : generateTourGuide(tourGuideTicketState, user.id);
                  });
                },
              );
            },
          )),
    );
  }

  //FIXME: isAfter tiket perbaiki

  TabBarView generateDestination(TicketState ticketState, String userID) {
    List<Ticket> newestTicket = ticketState.tickets
        .where(
          (ticket) => ticket.time.isAfter(
            DateTime.now(),
          ),
        )
        .where((ticket) => ticket.userID == userID)
        .toList();
    newestTicket.sort((a, b) => a.time.compareTo(b.time));

    List<Ticket> oldestTicket = ticketState.tickets
        .where(
          (ticket) => !ticket.time.isAfter(
            DateTime.now(),
          ),
        )
        .where((ticket) => ticket.userID == userID)
        .toList();
    oldestTicket.sort((a, b) => a.time.compareTo(b.time));

    return TabBarView(children: [
      ListView(
        children: newestTicket.length == 0
            ? [emptyTicket()]
            : newestTicket
                .map((e) => Container(
                    margin: EdgeInsets.only(
                        top: (e == newestTicket.first) ? 20 : 0,
                        left: defaultMargin,
                        right: defaultMargin,
                        bottom: (e == newestTicket.last) ? 100 : 20),
                    child: TicketCard(
                      ticket: e,
                      onTap: () =>
                          Get.toNamed('/ticketDetailPage', arguments: e),
                    )))
                .toList(),
      ),
      ListView(
        children: oldestTicket.length == 0
            ? [emptyTicket()]
            : oldestTicket
                .map((e) => Container(
                      margin: EdgeInsets.only(
                          top: (e == oldestTicket.first) ? 20 : 0,
                          left: defaultMargin,
                          right: defaultMargin,
                          bottom: (e == oldestTicket.last) ? 100 : 20),
                      child: Stack(
                        children: [
                          TicketCard(
                            ticket: e,
                            onTap: () =>
                                Get.toNamed('/ticketDetailPage', arguments: e),
                          ),
                          e.rating > 0
                              ? SizedBox()
                              : Positioned(
                                  top: 0,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {
                                      showRatingDialog(e, null);
                                    },
                                    child: Icon(
                                      MaterialCommunityIcons.pencil,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ))
                .toList(),
      )
    ]);
  }

  TabBarView generateTourGuide(
      TourguideTicketState tourGuideTicketState, String userID) {
    List<TourGuideTicket> newestTourGuideTicket = tourGuideTicketState
        .tourGuideTickets
        .where((element) => element.dateTime.isAfter(DateTime.now()))
        .where((element) => element.userID == userID)
        .toList();
    newestTourGuideTicket.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    List<TourGuideTicket> oldestTourGuideTicket = tourGuideTicketState
        .tourGuideTickets
        .where((element) => !element.dateTime.isAfter(DateTime.now()))
        .where((element) => element.userID == userID)
        .toList();
    oldestTourGuideTicket.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    return TabBarView(children: [
      ListView(
        children: newestTourGuideTicket.length == 0
            ? [emptyTicket()]
            : newestTourGuideTicket
                .map((e) => Container(
                    margin: EdgeInsets.only(
                        top: (e == newestTourGuideTicket.first) ? 20 : 0,
                        left: defaultMargin,
                        right: defaultMargin,
                        bottom: (e == newestTourGuideTicket.last) ? 100 : 20),
                    child: TourGuideTicketCard(
                      tourGuideTicket: e,
                      onTap: () => Get.toNamed('/tourGuideTicketDetailPage',
                          arguments: e),
                    )))
                .toList(),
      ),
      ListView(
        children: oldestTourGuideTicket.length == 0
            ? [emptyTicket()]
            : oldestTourGuideTicket
                .map((e) => Container(
                      margin: EdgeInsets.only(
                          top: (e == oldestTourGuideTicket.first) ? 20 : 0,
                          left: defaultMargin,
                          right: defaultMargin,
                          bottom: (e == oldestTourGuideTicket.last) ? 100 : 20),
                      child: Stack(
                        children: [
                          TourGuideTicketCard(
                            tourGuideTicket: e,
                            onTap: () => Get.toNamed(
                                '/tourGuideTicketDetailPage',
                                arguments: e),
                          ),
                          e.rating > 0
                              ? SizedBox()
                              : Positioned(
                                  top: 0,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {
                                      showRatingDialog(null, e);
                                    },
                                    child: Icon(
                                      MaterialCommunityIcons.pencil,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ))
                .toList(),
      )
    ]);
  }

  Column emptyTicket() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/no_data.png"),
        Text("Belum Ada Tiket"),
      ],
    );
  }
}
