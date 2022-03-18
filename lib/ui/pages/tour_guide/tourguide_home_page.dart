part of "../pages.dart";

class TourGuideHomePage extends StatefulWidget {
  @override
  State<TourGuideHomePage> createState() => _TourGuideHomePageState();
}

class _TourGuideHomePageState extends State<TourGuideHomePage> {
  Future<void> tourGuideSignOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("value", 0);
    setState(() {
      tourGuideLoginStatus = TourGuideLoginStatus.notSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await tourGuideSignOut();
          },
          child: Text("logout"),
        ),
      ),
    );
  }
}
