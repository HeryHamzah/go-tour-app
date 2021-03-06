part of '../pages.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  Destination destination = Get.arguments;
  DatePickerController _dateTimeController = DatePickerController();
  DateTime bookingTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
  int totalTicket = 0;
  int price = 0;

  void showConfirmAlertDialog(Ticket ticket) {
    AlertDialog alertDialog = AlertDialog(
      title: Text("Lanjut pembelian?",
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
                    Get.toNamed('/succesBookingPage', arguments: ticket);
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
  Widget build(BuildContext context) {
    int totalPrice = price + totalTicket * 500;
    return Scaffold(
        backgroundColor: backColor,
        body: BlocBuilder<UserBloc, UserState>(
          builder: (_, userState) {
            User user = (userState as UserLoaded).user;
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultMargin, vertical: 20),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "FORM DETAIL PEMESANAN",
                          style: themeFont.copyWith(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                          "**Isi formulir di bawah ini dengan lengkap dan seksama untuk menyelesaikan prosedur pembayaran**"),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Pilih Tanggal",
                          style: themeFont.copyWith(fontSize: 18)),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          DatePicker(
                            DateTime(DateTime.now().year, DateTime.now().month,
                                DateTime.now().day + 1),
                            initialSelectedDate: DateTime(DateTime.now().year,
                                DateTime.now().month, DateTime.now().day + 1),
                            controller: _dateTimeController,
                            selectionColor: mainColor,
                            daysCount: 30,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Jumlah Tiket",
                            style: themeFont.copyWith(fontSize: 18),
                          ),

                          //TICKET COUNT BOX
                          Row(
                            children: [
                              Container(
                                height: 50,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: mainColor,
                                    borderRadius: BorderRadius.circular(25)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: Icon(FontAwesomeIcons.angleLeft),
                                      color: Colors.white,
                                      iconSize: 24,
                                      onPressed: () {
                                        if (totalTicket > 0) {
                                          setState(() {
                                            totalTicket -= 1;
                                            price = int.tryParse(
                                                    destination.price) *
                                                totalTicket;
                                          });
                                        }
                                      },
                                    ),
                                    Text(
                                      totalTicket.toString(),
                                      style: themeFont.copyWith(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                      icon: Icon(FontAwesomeIcons.angleRight),
                                      color: Colors.white,
                                      iconSize: 24,
                                      onPressed: () {
                                        setState(() {
                                          totalTicket += 1;
                                          price =
                                              int.tryParse(destination.price) *
                                                  totalTicket;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pembayaran:",
                            style: themeFont.copyWith(fontSize: 18),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              NumberFormat.currency(
                                      locale: "id_ID",
                                      decimalDigits: 0,
                                      symbol: "Rp")
                                  .format(price),
                              textAlign: TextAlign.end,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: themeFont.copyWith(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Biaya:",
                            style: themeFont.copyWith(fontSize: 18),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              NumberFormat.currency(
                                          locale: "id_ID",
                                          decimalDigits: 0,
                                          symbol: "Rp")
                                      .format(500) +
                                  " x $totalTicket",
                              textAlign: TextAlign.end,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: themeFont.copyWith(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total:",
                            style: themeFont.copyWith(fontSize: 18),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              NumberFormat.currency(
                                      locale: "id_ID",
                                      decimalDigits: 0,
                                      symbol: "Rp")
                                  .format(totalPrice),
                              textAlign: TextAlign.end,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: themeFont.copyWith(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 2,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Dompetku",
                            style: themeFont.copyWith(fontSize: 18),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              NumberFormat.currency(
                                      locale: "id_ID",
                                      decimalDigits: 0,
                                      symbol: "Rp")
                                  .format(user.balance),
                              textAlign: TextAlign.end,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: themeFont.copyWith(
                                  color: (user.balance >= totalPrice)
                                      ? mainColor
                                      : Colors.red,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Center(
                        child: Container(
                          width: 250,
                          height: 46,
                          child: ElevatedButton(
                              onPressed: totalTicket <= 0
                                  ? null
                                  : user.balance >= totalPrice
                                      ? () => showConfirmAlertDialog(Ticket(
                                            bookingCode: randomAlphaNumeric(10)
                                                .toUpperCase(),
                                            destination: destination,
                                            time: bookingTime,
                                            userID: user.id,
                                            userName: user.name,
                                            totalTicket: totalTicket,
                                            totalPrice: totalPrice,
                                          ))
                                      // Get.offAndToNamed(
                                      //         "/succesBookingPage",
                                      //         arguments: [
                                      //           Ticket(
                                      //             bookingCode:
                                      //                 randomAlphaNumeric(10)
                                      //                     .toUpperCase(),
                                      //             destination: destination,
                                      //             time: bookingTime,
                                      //             name: user.name,
                                      //             totalTicket: totalTicket,
                                      //             totalPrice: totalPrice,
                                      //           ),
                                      //           user.id
                                      //         ])
                                      : () => Get.toNamed("/topUpPage",
                                          arguments: user),
                              style: ElevatedButton.styleFrom(
                                  primary: user.balance >= totalPrice
                                      ? mainColor
                                      : Colors.red),
                              child: Text(
                                user.balance >= totalPrice
                                    ? "Pesan Sekarang"
                                    : "Top Up Dompetku",
                                style: themeFont.copyWith(
                                    color: Colors.white, fontSize: 16),
                              )),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ));
  }
}
