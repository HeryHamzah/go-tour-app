part of '../pages.dart';

class TourGuideBookingPage extends StatefulWidget {
  @override
  _TourGuideBookingPageState createState() => _TourGuideBookingPageState();
}

class _TourGuideBookingPageState extends State<TourGuideBookingPage> {
  TourGuide tourGuide = Get.arguments[0];
  List<Destination> destinations = Get.arguments[1];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () => Get.back(),
              child: Icon(Icons.arrow_back_ios_new, color: backColor)),
          title: Text(
            "Form Trip Tour Guide",
            style: themeFont.copyWith(color: backColor),
          ),
        ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 75,
                        height: 90,
                        margin: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: NetworkImage(BaseUrl.getTourGuideImages +
                                    tourGuide.profilePicture),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width -
                            2 * defaultMargin -
                            75 -
                            16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tourGuide.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: themeFont.copyWith(
                                  fontSize: 16,
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              tourGuide.location,
                              maxLines: 1,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Rating(7.9)
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 2,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                      children: destinations
                          .map((e) => CheckboxListTile(
                                contentPadding: EdgeInsets.all(0),
                                value: false,
                                onChanged: (onChanged) {},
                                title: Text(e.name),
                              ))
                          .toList())
                ],
              ),
            )
          ],
        ));
  }
}
