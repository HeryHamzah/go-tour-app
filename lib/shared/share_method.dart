part of 'shared.dart';

Future<File> galleryPhoto() async {
  final pickedFile = await ImagePicker.pickImage(
      source: ImageSource.gallery, imageQuality: 50);

  if (pickedFile == null) {
    return null;
  }

  return pickedFile;
}

Future<File> cameraPhoto() async {
  final pickedFile =
      await ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 50);

  if (pickedFile == null) {
    return null;
  }

  return pickedFile;
}
