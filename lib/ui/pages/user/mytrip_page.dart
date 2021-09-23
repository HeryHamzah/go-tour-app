part of '../pages.dart';

class MyTripPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              ZoomDrawer.of(context).open();
            },
            icon: Icon(MaterialCommunityIcons.menu)),
      ),
    );
  }
}
