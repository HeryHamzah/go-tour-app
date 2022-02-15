part of '../pages.dart';

class SuccesBookingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    Ticket ticket = data[0];
    String userID = data[1];
    return Scaffold(
      backgroundColor: backColor,
      body: FutureBuilder(
          future: processingTransaction(context, ticket, userID),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      width: 180,
                      height: 180,
                      margin: EdgeInsets.only(bottom: 70),
                      child: SvgPicture.asset("assets/traveling.svg",
                          fit: BoxFit.contain),
                    ),
                  ),
                  Text(
                    "Horeeeeee!",
                    style: themeFont.copyWith(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  Text("Anda telah berhasil\nmelakukan pembelian tiket",
                      textAlign: TextAlign.center,
                      style: themeFont.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w300)),
                  SizedBox(
                    height: 70,
                  ),
                  Container(
                    width: 250,
                    height: 46,
                    margin: EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16))),
                        onPressed: () {
                          Get.offAllNamed('/activity');
                        },
                        child: Text(
                          "Tiketku",
                          style: themeFont.copyWith(
                              fontSize: 16, color: Colors.white),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Beli tiket lain? "),
                      InkWell(
                        onTap: () {
                          Get.offAllNamed("/home");
                        },
                        child: Text("Kembali ke Home",
                            style: themeFont.copyWith(color: mainColor)),
                      )
                    ],
                  )
                ],
              );
            } else {
              return SpinKitFadingCircle(
                color: mainColor,
                size: 50,
              );
            }
          }),
    );
  }

  Future<void> processingTransaction(
      BuildContext context, Ticket ticket, String userID) async {
    context.bloc<UserBloc>().add(Purchase(ticket.totalPrice));
    context.bloc<TicketBloc>().add(BuyTicket(userID, ticket));

    // await UserServices.saveticket(ticket, userID);
    await UserServices.saveTransaction(GoTourTransaction(
        transactionID: "B${randomNumeric(10)}",
        userID: userID,
        picturePath: ticket.destination.images[0],
        title: ticket.destination.name,
        amount: -ticket.totalPrice,
        desc: ticket.destination.location,
        time: DateTime.now()));
  }
}
