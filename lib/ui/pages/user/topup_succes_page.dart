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
          future: processingTransaction(context, user, amount),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(child: Text("OK"));
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
      BuildContext context, User user, int amount) async {
    context.bloc<UserBloc>().add(TopUp(amount));
    //TODO: Lengkapi data
    UserServices.saveTransaction(GoTourTransaction(
        userID: user.id,
        picturePath: "",
        title: "Top Up",
        amount: amount,
        desc: "",
        time: DateTime.now()));
  }
}
