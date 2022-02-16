part of "../pages.dart";

class ActivityPage extends StatefulWidget {
  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  String val = "Destinasi";
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
        body: BlocBuilder<TourguideTicketBloc, TourguideTicketState>(
          builder: (_, tourGuideTicketState) {
            return BlocBuilder<TicketBloc, TicketState>(
                builder: (_, ticketState) {
              return (val == "Destinasi")
                  ? generateDestination(ticketState)
                  : generateTourGuide(tourGuideTicketState);
            });
          },
        ),
      ),
    );
  }

  TabBarView generateDestination(TicketState ticketState) {
    List<Ticket> newestTicket = ticketState.tickets
        .where(
          (ticket) => ticket.time.isAfter(
            DateTime.now(),
          ),
        )
        .toList();
    newestTicket.sort((a, b) => a.time.compareTo(b.time));

    List<Ticket> oldestTicket = ticketState.tickets
        .where(
          (ticket) => !ticket.time.isAfter(
            DateTime.now(),
          ),
        )
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
                      child: TicketCard(
                        ticket: e,
                        onTap: () =>
                            Get.toNamed('/ticketDetailPage', arguments: e),
                      ),
                    ))
                .toList(),
      )
    ]);
  }

  TabBarView generateTourGuide(TourguideTicketState tourGuideTicketState) {
    List<TourGuideTicket> newestTourGuideTicket = tourGuideTicketState
        .tourGuideTickets
        .where((element) => element.dateTime.isAfter(DateTime.now()))
        .toList();
    newestTourGuideTicket.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    List<TourGuideTicket> oldestTourGuideTicket = tourGuideTicketState
        .tourGuideTickets
        .where((element) => !element.dateTime.isAfter(DateTime.now()))
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
                      child: TourGuideTicketCard(
                        tourGuideTicket: e,
                        onTap: () => Get.toNamed('/tourGuideTicketDetailPage',
                            arguments: e),
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
