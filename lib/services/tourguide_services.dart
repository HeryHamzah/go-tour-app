part of 'services.dart';

class TourGuideServices {
  static Future<void> tourGuideSignIn(
      String email, String password, BuildContext context) async {
    try {
      final response = await http.post(BaseUrl.tourGuideSignIn,
          body: {'email': email, 'password': password});
      final data = jsonDecode(response.body);
      if (data['value'] == 1) {
        saveData(data['value'], data['id']);
        Get.offAllNamed('/tourGuideHome', arguments: data['id']);
      } else {
        showSnackBar(context, data['message']);
      }
      print(data['message']);
    } catch (e) {
      print("error Tour Guide Sign In: " + e.toString());
    }
  }

  static Future<TourGuide> getTourGuide(String id) async {
    try {
      final response =
          await http.post(BaseUrl.getTourGuide, body: {'id_tourguide': id});
      final data = jsonDecode(response.body);
      final tourGuide = data['result'] as Map<String, dynamic>;
      return TourGuide.fromJon(tourGuide);
    } catch (e) {
      print("error get Tour Guide: " + e.toString());
      return null;
    }
  }

  static Future<void> tourGuideSignOut() async {
    Get.offAllNamed('/');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("value", 0);
    prefs.setString("id", '');
  }

  static Future<void> changeStatus(String id, bool status) async {
    try {
      final response = await http.post(BaseUrl.changeStatus,
          body: {'id': id, 'status': status ? 'on' : 'off'});
      final data = jsonDecode(response.body);
      print(data['message']);
    } catch (e) {
      print("error change status: " + e.toString());
    }
  }

  static Future<void> updateTourGuide(TourGuide tourGuide) async {
    try {
      final response = await http.post(BaseUrl.updateTourGuide, body: {
        'id_tourguide': tourGuide.tourGuideID,
        'name': tourGuide.name,
        'email': tourGuide.email,
        'hp': tourGuide.hp,
        'image': tourGuide.profilePicture,
        'password': tourGuide.password
      });
      final data = jsonDecode(response.body);
      print(data['message']);
    } catch (e) {
      print("error update Tour Guide: " + e.toString());
    }
  }

  static Future<void> uploadTourGuideImage(
      {File imageFile, String tourGuideID}) async {
    try {
      var uri = Uri.parse(BaseUrl.uploadTourGuideImage);
      var request = http.MultipartRequest("POST", uri);

      request.fields['id_tourguide'] = tourGuideID;

      var stream = http.ByteStream(imageFile.openRead());
      stream.cast();
      var length = await imageFile.length();
      request.files.add(http.MultipartFile('image', stream, length,
          filename: path.basename(imageFile.path)));

      http.Response response =
          await http.Response.fromStream(await request.send());
      final data = jsonDecode(response.body);
      String message = data["message"];
      print(message);
    } catch (e) {
      print("Error upload Tour Guide image:" + e.toString());
    }
  }
}
