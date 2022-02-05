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
        body:
            // FutureBuilder(
            //     future: UserServices.getTickets("V7sf6pkHiEduQ6jaKyXtHHxkfr73"),
            //     builder: (context, snapshot) {
            //       List<Ticket> tickets = snapshot.data;
            //       return TabBarView(
            //         children: [
            //           ListView(
            //               children: tickets
            //                   .map((e) => Text(e.destination.name))
            //                   .toList()),
            //           ListView(
            //               children: tickets.map((e) => Text(e.name)).toList()),
            //         ],
            //       );
            //     })
            BlocBuilder<TicketBloc, TicketState>(builder: (_, ticketState) {
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
                (ticket) => ticket.time.isBefore(
                  DateTime.now(),
                ),
              )
              .toList();
          oldestTicket.sort((a, b) => a.time.compareTo(b.time));

          return TabBarView(children: [
            ListView(
              children: newestTicket.length == 0
                  ? [Text("Belum ada Data")]
                  : newestTicket.map((e) => Text(e.destination.name)).toList(),
            ),
            ListView(
              children: oldestTicket.length == 0
                  ? [Text("Belum ada Data")]
                  : newestTicket.map((e) => Text(e.destination.name)).toList(),
            )
          ]);
        }),
      ),
    );
  }
}
