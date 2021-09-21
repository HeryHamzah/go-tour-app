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
        future: UserServices.getDestinations(location.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return DestinationsList(snapshot.data);
          } else {
            return SpinKitFadingCircle(color: mainColor, size: 50);
          }
        },
      ),
    );
  }
}

class DestinationsList extends StatelessWidget {
  final List<Destination> destination;

  DestinationsList(this.destination);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: destination.length,
        itemBuilder: (context, i) {
          return Container(
              margin: EdgeInsets.only(
                  left: defaultMargin,
                  right: defaultMargin,
                  top: (i == 0) ? 20 : 0,
                  bottom: (i == destination.length - 1) ? 40 : 20),
              child: DestinationCard(
                destination: destination[i],
                onTap: () => Get.toNamed('/destinationDetail',
                    arguments: destination[i]),
              ));
        });
  }
}
