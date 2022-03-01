part of '../pages.dart';

class DestinationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Location location = Get.arguments;
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Explore ${location.name}",
          style: themeFont.copyWith(fontSize: 18),
        ),
      ),
      body: FutureBuilder<List<Destination>>(
        future: GeneralServices.getDestinations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Iterable<Destination> destinations = snapshot.data
                .where((destination) => destination.locationID == location.id);
            return DestinationsList(destinations);
          } else {
            return SpinKitFadingCircle(color: mainColor, size: 50);
          }
        },
      ),
    );
  }
}

class DestinationsList extends StatelessWidget {
  final Iterable<Destination> destinations;

  DestinationsList(this.destinations);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: destinations.length,
        itemBuilder: (context, i) {
          return Container(
              margin: EdgeInsets.only(
                  left: defaultMargin,
                  right: defaultMargin,
                  top: (i == 0) ? 20 : 0,
                  bottom: (i == destinations.length - 1) ? 40 : 20),
              child: DestinationCard(
                destination: destinations.elementAt(i),
                onTap: () => Get.toNamed('/destinationDetail',
                    arguments: destinations.elementAt(i)),
              ));
        });
  }
}
