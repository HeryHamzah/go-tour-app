part of '../pages.dart';

class TourGuideBookingPage extends StatefulWidget {
  @override
  _TourGuideBookingPageState createState() => _TourGuideBookingPageState();
}

class _TourGuideBookingPageState extends State<TourGuideBookingPage> {
  TourGuide tourGuide = Get.arguments[0];
  List<Destination> destinationChoices = Get.arguments[1];
  DateTime bookingTime = Get.arguments[2];
  bool isChecked = false;

  String destinationChoicesInString = "";
  int ticketPrice = 0;
  int totalPrice = 0;

  @override
  void initState() {
    super.initState();
    for (var dest in destinationChoices) {
      destinationChoicesInString +=
          dest.name + (dest == destinationChoices.last ? "" : ", ");
      ticketPrice += int.tryParse(dest.price);
    }
    totalPrice = ticketPrice + tourGuide.cost;
  }

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
              child: BlocBuilder<UserBloc, UserState>(
                builder: (_, userState) {
                  User user = (userState as UserLoaded).user;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                    image: NetworkImage(
                                        BaseUrl.getTourGuideImages +
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
                                Rating(rating: tourGuide.rating)
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Destinasi",
                            style: themeFont.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(destinationChoicesInString,
                                  textAlign: TextAlign.end,
                                  style: themeFont.copyWith(fontSize: 16)))
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tanggal",
                            style: themeFont.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(bookingTime.dayAndDate,
                                  textAlign: TextAlign.end,
                                  style: themeFont.copyWith(fontSize: 16)))
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text("Pembayaran:",
                          style: themeFont.copyWith(fontSize: 18)),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tiket",
                            style: themeFont.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                  NumberFormat.currency(
                                          locale: 'id_iD',
                                          decimalDigits: 0,
                                          symbol: 'Rp')
                                      .format(ticketPrice),
                                  textAlign: TextAlign.end,
                                  style: themeFont.copyWith(fontSize: 16)))
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tour Guide",
                            style: themeFont.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                  NumberFormat.currency(
                                          locale: 'id_iD',
                                          decimalDigits: 0,
                                          symbol: 'Rp')
                                      .format(tourGuide.cost),
                                  textAlign: TextAlign.end,
                                  style: themeFont.copyWith(fontSize: 16)))
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: themeFont.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                  NumberFormat.currency(
                                          locale: 'id_iD',
                                          decimalDigits: 0,
                                          symbol: 'Rp')
                                      .format(totalPrice),
                                  textAlign: TextAlign.end,
                                  style: themeFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)))
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Dompetku",
                            style: themeFont.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                  NumberFormat.currency(
                                          locale: 'id_iD',
                                          decimalDigits: 0,
                                          symbol: 'Rp')
                                      .format(user.balance),
                                  textAlign: TextAlign.end,
                                  style: themeFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: user.balance >= totalPrice
                                          ? mainColor
                                          : Colors.red)))
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: Container(
                          width: 250,
                          height: 46,
                          child: ElevatedButton(
                              onPressed: () {}, child: Text("Reservasi")),
                        ),
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ));
  }
}
