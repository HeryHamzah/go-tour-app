part of 'services.dart';

class TourGuideServices {
  // static Future<void> signIn(String email, String password) async {
  //   try {
  //     final response = await http.post(BaseUrl.tourGuideSignIn,
  //         body: {'email': email, 'password': password});
  //     final data = jsonDecode(response.body);
  //     if (data['value'] == '1') {
  //       await saveData(int.tryParse(data['value']), data['id']);
  //       tourGuideLoginStatus = TourGuideLoginStatus.signIn;
  //     }
  //     print(data['message']);
  //   } catch (e) {
  //     print("error Tour Guide Sign In: " + e.toString());
  //   }
  // }

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("value", 0);
    prefs.setString("id", '');
    Get.offAllNamed('/');
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
}
