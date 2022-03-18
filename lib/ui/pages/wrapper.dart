part of 'pages.dart';

class Wrapper extends StatefulWidget {
  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getInt("value");
    setState(() {
      tourGuideLoginStatus = (value == 1)
          ? TourGuideLoginStatus.signIn
          : TourGuideLoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    auth.User firebaseUser = Provider.of<auth.User>(context);

    if (firebaseUser == null) {
      // switch (tourGuideLoginStatus) {
      //   case TourGuideLoginStatus.notSignIn:
      //     return SplashPage();

      //   case TourGuideLoginStatus.signIn:
      //     print("TOUR GUIDE LOGIN");
      //     return TourGuideHomePage();
      // }
      if (tourGuideLoginStatus == TourGuideLoginStatus.notSignIn) {
        print("SPLASH SCREEN");
        return SplashPage();
      } else {
        print("TOUR GUIDE LOGIN");
        return TourGuideHomePage();
      }
    } else {
      print("USER LOGIN");
      context.bloc<UserBloc>().add(LoadUser(firebaseUser.uid));
      context.bloc<TicketBloc>().add(GetTickets());
      context.bloc<TourguideTicketBloc>().add(GetTourGuideTicket());

      return MainDrawer();
    }
  }
}
