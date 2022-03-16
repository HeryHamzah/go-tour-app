part of 'pages.dart';

class Wrapper extends StatefulWidget {
  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    auth.User firebaseUser = Provider.of<auth.User>(context);

    if (firebaseUser == null) {
      if (tourGuideLoginStatus == TourGuideLoginStatus.notSignIn) {
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
