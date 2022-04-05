part of '../pages.dart';

class TripHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TourGuide tourGuide = Get.arguments;
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
              onTap: () => Get.back(),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: backColor,
              )),
          title:
              Text("Riwayat Trip", style: themeFont.copyWith(color: backColor)),
          bottom: TabBar(
            indicatorColor: mainColor,
            tabs: [
              Tab(
                child: Text(
                  "Terbaru",
                  style: themeFont.copyWith(fontSize: 16, color: backColor),
                ),
              ),
              Tab(
                child: Text(
                  "Kedaluwarsa",
                  style: themeFont.copyWith(fontSize: 16, color: backColor),
                ),
              )
            ],
          ),
        ),
        body: BlocBuilder<TourguideTicketBloc, TourguideTicketState>(
          builder: (context, tourGuideTicketState) {
            List<TourGuideTicket> newestTourGuideTicket = tourGuideTicketState
                .tourGuideTickets
                .where((element) => element.dateTime
                    .add(Duration(days: 1))
                    .isAfter(DateTime.now()))
                .where((element) =>
                    element.tourGuide.tourGuideID == tourGuide.tourGuideID)
                .toList();
            newestTourGuideTicket
                .sort((a, b) => a.dateTime.compareTo(b.dateTime));

            List<TourGuideTicket> oldestTourGuideTicket = tourGuideTicketState
                .tourGuideTickets
                .where((element) => !element.dateTime
                    .add(Duration(days: 1))
                    .isAfter(DateTime.now()))
                .where((element) =>
                    element.tourGuide.tourGuideID == tourGuide.tourGuideID)
                .toList();
            oldestTourGuideTicket
                .sort((a, b) => a.dateTime.compareTo(b.dateTime));
            return TabBarView(children: [
              ListView(
                children: newestTourGuideTicket.length == 0
                    ? [emptyTicket()]
                    : newestTourGuideTicket
                        .map((e) => Container(
                            margin: EdgeInsets.only(
                                top:
                                    (e == newestTourGuideTicket.first) ? 20 : 0,
                                left: defaultMargin,
                                right: defaultMargin,
                                bottom: (e == newestTourGuideTicket.last)
                                    ? 100
                                    : 20),
                            child: HistoryTicketCard(
                              tourGuideTicket: e,
                              onTap: () =>
                                  Get.toNamed('/historyDetail', arguments: e),
                            )))
                        .toList(),
              ),
              ListView(
                children: oldestTourGuideTicket.length == 0
                    ? [emptyTicket()]
                    : oldestTourGuideTicket
                        .map((e) => Container(
                              margin: EdgeInsets.only(
                                  top: (e == oldestTourGuideTicket.first)
                                      ? 20
                                      : 0,
                                  left: defaultMargin,
                                  right: defaultMargin,
                                  bottom: (e == oldestTourGuideTicket.last)
                                      ? 100
                                      : 20),
                              child: HistoryTicketCard(
                                tourGuideTicket: e,
                                onTap: () =>
                                    Get.toNamed('/historyDetail', arguments: e),
                              ),
                            ))
                        .toList(),
              )
            ]);
          },
        ),
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
