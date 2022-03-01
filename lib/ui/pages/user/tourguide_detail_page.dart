part of '../pages.dart';

class TourGuideDetailPage extends StatefulWidget {
  @override
  _TourGuideDetailPageState createState() => _TourGuideDetailPageState();
}

class _TourGuideDetailPageState extends State<TourGuideDetailPage> {
  TourGuide tourGuide = Get.arguments;
  List<Destination> destinationChoices = [];
  DatePickerController _dateTimeController = DatePickerController();
  DateTime bookingTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backColor,
        body: SafeArea(
          child: Stack(
            children: [
              Hero(
                tag: tourGuide.tourGuideID,
                child: Container(
                  width: double.infinity,
                  height: (MediaQuery.of(context).size.height / 2) + 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(BaseUrl.getTourGuideImages +
                              tourGuide.profilePicture),
                          fit: BoxFit.cover)),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2,
                  padding:
                      EdgeInsets.fromLTRB(defaultMargin, 40, defaultMargin, 20),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                      color: backColor),
                  child: ListView(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width -
                            2 * defaultMargin,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tourGuide.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: themeFont.copyWith(
                                    fontSize: 24, fontWeight: FontWeight.w600),
                              ),
                              Text(tourGuide.location,
                                  style: themeFont.copyWith(fontSize: 20)),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text("Total Trip"),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        tourGuide.numberOfTrips,
                                        style: themeFont.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () => Get.toNamed('/reviewPage',
                                        arguments: [null, tourGuide]),
                                    child: Column(
                                      children: [
                                        Text("Rating"),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${tourGuide.rating.toString().substring(0, tourGuide.rating.toString().length < 4 ? tourGuide.rating.toString().length : 4)} (${tourGuide.numberOfReviews})",
                                          style: themeFont.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Text("Pilih destinasi",
                                  style: themeFont.copyWith(fontSize: 16)),
                              SizedBox(
                                height: 16,
                              ),
                              FutureBuilder(
                                  future: GeneralServices.getDestinations(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      Iterable<Destination> destinations =
                                          snapshot.data.where((destination) =>
                                              destination.locationID ==
                                              tourGuide.locationID);

                                      return Container(
                                        height: 150,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: destinations
                                              .map((e) => Container(
                                                    margin: EdgeInsets.only(
                                                        left: destinations
                                                                    .first ==
                                                                e
                                                            ? 0
                                                            : 16),
                                                    child: DestinationChoice(
                                                        destination: e,
                                                        onTap: () => Get.toNamed(
                                                            '/destinationDetail',
                                                            arguments: e),
                                                        isSelected:
                                                            destinationChoices
                                                                .contains(e),
                                                        onIconTap: () {
                                                          if (destinationChoices
                                                              .contains(e)) {
                                                            destinationChoices
                                                                .remove(e);
                                                          } else {
                                                            destinationChoices
                                                                .add(e);
                                                          }
                                                          setState(() {});
                                                        }),
                                                  ))
                                              .toList(),
                                        ),
                                      );
                                    } else {
                                      return SpinKitFadingCircle(
                                        color: mainColor,
                                      );
                                    }
                                  }),
                              SizedBox(
                                height: 20,
                              ),
                              Text("Pilih Tanggal",
                                  style: themeFont.copyWith(fontSize: 16)),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                children: [
                                  DatePicker(
                                    DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day + 1),
                                    initialSelectedDate: DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day + 1),
                                    controller: _dateTimeController,
                                    selectionColor: mainColor,
                                    daysCount: 10,
                                    locale: "id_ID",
                                    onDateChange: (dateTime) {
                                      bookingTime = dateTime;
                                    },
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                width: double.infinity,
                                height: 46,
                                child: ElevatedButton(
                                  onPressed: (destinationChoices.length <= 0)
                                      ? null
                                      : () {
                                          Get.toNamed('/tourGuideBookingPage',
                                              arguments: [
                                                tourGuide,
                                                destinationChoices,
                                                bookingTime
                                              ]);
                                        },
                                  child: Text(
                                    "Buat Trip dengan Tour Guide",
                                    style: themeFont.copyWith(color: backColor),
                                  ),
                                ),
                              )
                            ]),
                      )
                    ],
                  ),
                ),
              ),

              //NOTE: ICON BACK
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(top: 20, left: defaultMargin),
                  decoration: BoxDecoration(
                      color: backColor, borderRadius: BorderRadius.circular(5)),
                  child: Icon(Icons.arrow_back_ios_new),
                ),
              ),
            ],
          ),
        ));
  }
}
