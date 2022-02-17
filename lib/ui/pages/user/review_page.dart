part of '../pages.dart';

class ReviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    Destination destination = data[0];
    TourGuide tourGuide = data[1];

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: InkWell(
            onTap: () => Get.back(),
            child: Icon(Icons.arrow_back_ios_new),
          ),
          title: Text(destination == null ? tourGuide.name : destination.name)),
      body: FutureBuilder(
          future: (destination == null)
              ? GeneralServices.getTourGuideReviews(tourGuide.tourGuideID)
              : GeneralServices.getDestinationReviews(destination.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Review> reviews = snapshot.data;
              if (reviews.length > 0) {
                return ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          defaultMargin, 20, defaultMargin, 20),
                      child: Column(
                        children: reviews
                            .map((e) => Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: ReviewCard(e)))
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
            } else {
              return SpinKitFadingCircle(color: mainColor, size: 50);
            }
          }),
    );
  }
}
