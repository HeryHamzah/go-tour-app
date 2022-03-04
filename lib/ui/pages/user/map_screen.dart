part of '../pages.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: backColor,
          ),
        ),
        title: Text(
          "Google Maps",
          style: themeFont.copyWith(color: backColor),
        ),
      ),
    );
  }
}
