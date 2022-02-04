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
                  "Newest",
                  style: themeFont.copyWith(fontSize: 16),
                ),
              ),
              Tab(
                child: Text(
                  "Oldest",
                  style: themeFont.copyWith(fontSize: 16),
                ),
              )
            ],
          ),
        ),
        // body: FutureBuilder(
        //   future: UserServices.getTickets(, destination),
        //   builder: builder),
      ),
    );
  }
}
