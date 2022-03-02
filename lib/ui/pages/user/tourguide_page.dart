part of '../pages.dart';

class TourGuidePage extends StatefulWidget {
  @override
  State<TourGuidePage> createState() => _TourGuidePageState();
}

class _TourGuidePageState extends State<TourGuidePage> {
  String filterValue = "Lokasi";
  List<String> filters = ["Lokasi", "Rating", "Jumlah Trip", "Biaya"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
          elevation: 0,
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
        body: Stack(
          children: [
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      defaultMargin, 70, defaultMargin, 20),
                  child: FutureBuilder(
                      future: GeneralServices.getTourGuides(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<TourGuide> tourGuides = snapshot.data;

                          tourGuides.sort(
                            (a, b) => (filterValue == filters[1])
                                ? b.rating.compareTo(a.rating)
                                : (filterValue == filters[2])
                                    ? b.numberOfTrips.compareTo(a.numberOfTrips)
                                    : (filterValue == filters[3])
                                        ? a.cost.compareTo(b.cost)
                                        : a.locationID.compareTo(b.locationID),
                          );

                          return Wrap(
                            spacing: 24,
                            runSpacing: 16,
                            children: tourGuides
                                .map((e) => TourGuideCard(
                                      tourGuide: e,
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  2 * defaultMargin -
                                                  24) /
                                              2,
                                      onTap: () => Get.toNamed(
                                          '/tourGuideDetailPage',
                                          arguments: e),
                                    ))
                                .toList(),
                          );
                        } else {
                          return SpinKitFadingCircle(
                            color: mainColor,
                          );
                        }
                      }),
                ),
              ],
            ),
            Container(
              height: 50,
              color: mainColor,
              padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Urut berdasarkan",
                      style:
                          themeFont.copyWith(color: backColor, fontSize: 16)),
                  DropdownButton(
                      dropdownColor: backColor,
                      elevation: 0,
                      value: filterValue,
                      iconSize: 30,
                      style: themeFont.copyWith(fontSize: 16),
                      items: filters
                          .map((filter) => DropdownMenuItem(
                                child: Text(filter),
                                value: filter,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          filterValue = value;
                        });
                      })
                ],
              ),
            ),
          ],
        ));
  }
}
