part of '../pages.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => ZoomDrawer.of(context).open(),
            child: Icon(MaterialCommunityIcons.menu)),
      ),
    );
  }
}
