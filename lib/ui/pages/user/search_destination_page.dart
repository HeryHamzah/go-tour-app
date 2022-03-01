part of '../pages.dart';

class SearchDestination extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(
            Icons.clear,
          ),
          onPressed: () {
            query = "";
            showSuggestions(context);
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: GeneralServices.getDestinations(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Destination> destinations =
                (snapshot.data as List<Destination>)
                    .where((destination) => destination.name
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                    .toList();
            if (destinations.length == 0) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/no_data.png"),
                  Text("Destinasi tidak ditemukan"),
                ],
              ));
            } else {
              return ListView(
                  children: destinations
                      .map((e) => Container(
                          margin: EdgeInsets.only(
                              left: defaultMargin,
                              right: defaultMargin,
                              top: (e == destinations.first) ? 20 : 0,
                              bottom: 20),
                          child: DestinationCard(
                            destination: e,
                            onTap: () =>
                                Get.toNamed('/destinationDetail', arguments: e),
                          )))
                      .toList());
            }
          } else {
            return SpinKitFadingCircle(color: mainColor, size: 50);
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column(
      children: [],
    );
  }
}
