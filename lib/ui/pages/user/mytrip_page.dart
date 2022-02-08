part of '../pages.dart';

class MyTripPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                ZoomDrawer.of(context).open();
              },
              icon: Icon(
                MaterialCommunityIcons.menu,
                color: backColor,
              )),
          title: Text(
            "Trip dengan Tour Guide",
            style: themeFont.copyWith(color: backColor),
          ),
        ),
        body: FutureBuilder(
            future: GeneralServices.getTourGuides(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<TourGuide> tourGuides = snapshot.data;

                return ListView(children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        defaultMargin, 20, defaultMargin, 20),
                    child: Wrap(
                      spacing: 24,
                      runSpacing: 16,
                      children: tourGuides
                          .map((e) => TourGuideCard(
                                tourGuide: e,
                                width: (MediaQuery.of(context).size.width -
                                        2 * defaultMargin -
                                        24) /
                                    2,
                                onTap: () => Get.toNamed('/tourGuideDetailPage',
                                    arguments: e),
                              ))
                          .toList(),
                    ),
                  ),
                ]);
              } else {
                return SpinKitFadingCircle(
                  color: mainColor,
                );
              }
            }));
  }
}
