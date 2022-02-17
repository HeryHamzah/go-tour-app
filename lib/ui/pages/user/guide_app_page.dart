part of '../pages.dart';

class GuidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => ZoomDrawer.of(context).open(),
            child: Icon(
              MaterialCommunityIcons.menu,
              color: backColor,
            )),
        centerTitle: true,
        title: Text("Panduan Aplikasi",
            style: themeFont.copyWith(color: backColor)),
      ),
      body: ListView(
        children: [
          Column(
            children: [],
          )
        ],
      ),
    );
  }
}
