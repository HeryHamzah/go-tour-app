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

  void showConfirmAlertDialog(User user, TourGuideTicket tourGuideTicket) {
    AlertDialog alertDialog = AlertDialog(
      title: Text("Lanjut reservasi?",
          style: themeFont.copyWith(fontWeight: FontWeight.w500)),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
              height: 46,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.grey, onPrimary: Colors.white),
                  onPressed: () => Get.back(),
                  child: Text(
                    "Batal",
                  )),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              height: 46,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: mainColor, onPrimary: Colors.white),
                  onPressed: () {
                    Get.toNamed('/successTourGuideReservation',
                        arguments: [tourGuideTicket, user]);
                  },
                  child: Text(
                    "Konfirmasi",
                  )),
            ),
          )
        ],
      ),
    );

    showDialog(context: context, builder: (context) => alertDialog);
  }

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
                              style: ElevatedButton.styleFrom(
                                  primary: user.balance >= totalPrice
                                      ? mainColor
                                      : Colors.red),
                              onPressed: user.balance >= totalPrice
                                  ? () {
                                      showConfirmAlertDialog(
                                          user,
                                          TourGuideTicket(
                                              dateTime: bookingTime,
                                              userName: user.name,
                                              tourGuideID:
                                                  tourGuide.tourGuideID,
                                              tourGuideName: tourGuide.name,
                                              destinations:
                                                  destinationChoicesInString,
                                              totalPrice: totalPrice,
                                              image: tourGuide.profilePicture));
                                    }
                                  : () => Get.toNamed('/topUpPage',
                                      arguments: user),
                              child: Text(
                                user.balance >= totalPrice
                                    ? "Reservasi"
                                    : "Top Up Dompetku",
                                style: themeFont.copyWith(color: backColor),
                              )),
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
