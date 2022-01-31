part of '../pages.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  Destination destination = Get.arguments;
  DatePickerController _dateTimeController = DatePickerController();
  int totalTicket = 0;
  int price = 0;
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
                            DateTime.now(),
                            initialSelectedDate: DateTime.now(),
                            controller: _dateTimeController,
                            selectionColor: mainColor,
                            daysCount: 30,
                            locale: "id_ID",
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
                                  color: mainColor,
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
                                      ? Color((0XFF567DF4))
                                      : Colors.red,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ));
  }
}
