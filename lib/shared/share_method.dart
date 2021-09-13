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
