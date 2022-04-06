part of '../pages.dart';

class SuccesTourGuideReservation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TourGuideTicket tourGuideTicket = Get.arguments;

    return Scaffold(
      backgroundColor: backColor,
      body: FutureBuilder(
          future: processingTransaction(context, tourGuideTicket),
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
                      child: SvgPicture.asset("assets/tourguide.svg",
                          fit: BoxFit.contain),
                    ),
                  ),
                  Text(
                    "Horeeeeee!",
                    style: themeFont.copyWith(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  Text("Anda telah berhasil\nmelakukan reservasi Tour Guide",
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
                          // Get.offAllNamed('/activity');
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
                          //kembali ke page route tourguide page
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                          //mengubah index drawer tourguide page ke home page
                          context.bloc<NavdrawerBloc>().add(ChangePage(1));
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
      BuildContext context, TourGuideTicket tourGuideTicket) async {
    context.bloc<UserBloc>().add(Purchase(tourGuideTicket.totalPrice));
    context
        .bloc<TourguideTicketBloc>()
        .add(BuyTourGuideTicket(tourGuideTicket));

    await UserServices.saveTransaction(GoTourTransaction(
        transactionID: "C${randomNumeric(10)}",
        userID: tourGuideTicket.userID,
        picturePath: tourGuideTicket.tourGuide.profilePicture,
        title: tourGuideTicket.tourGuide.name,
        amount: -tourGuideTicket.totalPrice,
        desc: tourGuideTicket.destinations,
        time: DateTime.now()));
  }
}
