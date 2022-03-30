part of "../pages.dart";

class TourGuideHomePage extends StatefulWidget {
  @override
  State<TourGuideHomePage> createState() => _TourGuideHomePageState();
}

class _TourGuideHomePageState extends State<TourGuideHomePage> {
  String tourGuideID = Get.arguments;

  @override
  Widget build(BuildContext context) {
    if (tourGuideID != '') {
      context.bloc<TourGuideBloc>().add(LoadTourGuide(tourGuideID));
      print('perintah ini jalan..');
    }

    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await TourGuideServices.tourGuideSignOut();
            context.bloc<TourGuideBloc>().add(SignOutTourGuide());
          },
          child: Text("logout"),
        ),
      ),
    );
  }
}
