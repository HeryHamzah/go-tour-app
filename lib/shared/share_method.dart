part of 'shared.dart';

Future<File> galleryPhoto() async {
  try {
    final pickedFile = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    // if (pickedFile == null) {
    //   return null;
    // }

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

    // if (pickedFile == null) {
    //   return null;
    // }

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

// Future<void> getData() async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   var value = pref.getInt("value");
//   tourGuideLoginStatus =
//       value == 1 ? TourGuideLoginStatus.signIn : TourGuideLoginStatus.notSignIn;
// }
