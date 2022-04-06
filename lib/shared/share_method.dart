part of 'shared.dart';

Future<File> galleryPhoto() async {
  try {
    final pickedFile = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    return pickedFile;
  } catch (e) {
    print("error galery: " + e.toString());
    return null;
  }
}

Future<File> cameraPhoto() async {
  try {
    final pickedFile = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    return pickedFile;
  } catch (e) {
    print("error camera: " + e.toString());
    return null;
  }
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(backgroundColor: mainColor, content: Text(text)));
}

Future<void> saveData(int value, String id) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("value", value);
    prefs.setString("id", id);
    print("Data saved!");
  } catch (e) {
    print("error save data: " + e.toString());
  }
}

SpeedDial buildSpeedDial({String contact, String email}) {
  return SpeedDial(
    animatedIcon: AnimatedIcons.menu_close,
    animatedIconTheme: IconThemeData(size: 28.0, color: backColor),
    backgroundColor: mainColor,
    visible: true,
    curve: Curves.bounceInOut,
    children: [
      SpeedDialChild(
        child: Icon(MaterialCommunityIcons.whatsapp, color: backColor),
        backgroundColor: mainColor,
        onTap: () async {
          String url = "whatsapp://send?phone=$contact&text=Halo!";

          await canLaunch(url) ? launch(url) : print("Error Launch");
        },
        label: 'Whatsapp',
        labelStyle:
            themeFont.copyWith(fontWeight: FontWeight.w500, color: backColor),
        labelBackgroundColor: mainColor,
      ),
      SpeedDialChild(
        child: Icon(Icons.phone_enabled_outlined, color: backColor),
        backgroundColor: mainColor,
        onTap: () async {
          await launch('tel:$contact');
        },
        label: 'Telepon',
        labelStyle:
            themeFont.copyWith(fontWeight: FontWeight.w500, color: backColor),
        labelBackgroundColor: mainColor,
      ),
      SpeedDialChild(
        child: Icon(Icons.email_outlined, color: backColor),
        backgroundColor: mainColor,
        onTap: () async {
          await launch('mailto:$email');
        },
        label: 'Email',
        labelStyle:
            themeFont.copyWith(fontWeight: FontWeight.w500, color: backColor),
        labelBackgroundColor: mainColor,
      ),
    ],
  );
}
