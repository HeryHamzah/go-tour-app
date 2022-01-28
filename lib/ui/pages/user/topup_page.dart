part of "../pages.dart";

class TopUpPage extends StatefulWidget {
  @override
  _TopUpPageState createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () => Get.back(), child: Icon(Icons.arrow_back_ios_new)),
        title: Text("Top Up"),
      ),
    );
  }
}
