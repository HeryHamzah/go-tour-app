part of "../pages.dart";

class ActivityPage extends StatelessWidget {
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
          title: Text(
            "Aktivitas",
            style: themeFont.copyWith(fontSize: 20),
          ),
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
        body: BlocBuilder<TicketBloc, TicketState>(builder: (_, ticketState) {
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
                              bottom: 20),
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
                      .map((e) => TicketCard(
                            ticket: e,
                            onTap: () =>
                                Get.toNamed('/ticketDetailPage', arguments: e),
                          ))
                      .toList(),
            )
          ]);
        }),
      ),
    );
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
