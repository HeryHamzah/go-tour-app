part of '../pages.dart';

class MyWalletPage extends StatefulWidget {
  @override
  _MyWalletPageState createState() => _MyWalletPageState();
}

class _MyWalletPageState extends State<MyWalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => ZoomDrawer.of(context).open(),
            child: Icon(MaterialCommunityIcons.menu)),
        title: Text("Dompetku"),
      ),
    );
  }
}
