part of '../pages.dart';

class SuccesTopUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    User user = data[0];
    int amount = data[1];
    return Scaffold(
      backgroundColor: backColor,
      body: FutureBuilder(
          future: processingTopUp(context, user, amount),
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
                      child: SvgPicture.asset("assets/topup.svg",
                          fit: BoxFit.contain),
                    ),
                  ),
                  Text(
                    "Yasssssh!",
                    style: themeFont.copyWith(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  Text("Anda telah berhasil\nmelakukan Top Up",
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
                          //kembali ke page route wallet page
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        },
                        child: Text(
                          "Dompetku",
                          style: themeFont.copyWith(
                              fontSize: 16, color: Colors.white),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Beli tiket? "),
                      InkWell(
                        onTap: () {
                          //kembali ke page route wallet page
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                          //mengubah index drawer wallet page ke home page
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

  Future<void> processingTopUp(
      BuildContext context, User user, int amount) async {
    context.bloc<UserBloc>().add(TopUp(amount));

    UserServices.saveTransaction(GoTourTransaction(
        transactionID: "A${randomNumeric(10)}",
        userID: user.id,
        picturePath: "",
        title: "Top Up",
        amount: amount,
        desc: "",
        time: DateTime.now()));
  }
}
