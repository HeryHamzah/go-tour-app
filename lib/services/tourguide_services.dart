part of 'services.dart';

class TourGuideServices {
  static Future<void> signIn(String email, String password) async {
    try {
      final response = await http.post(BaseUrl.tourGuideSignIn,
          body: {'email': email, 'password': password});
      final data = jsonDecode(response.body);
      if (data['value'] == '1') {
        tourGuideLoginStatus = TourGuideLoginStatus.signIn;
        saveData(int.tryParse(data['value']), data['id']);
      }
      print(data['message']);
    } catch (e) {
      print("error Tour Guide Sign In: " + e.toString());
    }
  }

  static Future<TourGuide> getTourGuide(String id) async {
    try {
      final response = await http.post(BaseUrl.getTourGuide, body: {'id': id});
      final data = jsonDecode(response.body);
      return TourGuide.fromJon(data);
    } catch (e) {
      print("error get Tour Guide: " + e.toString());
      return null;
    }
  }
}

// class TourGuideSignInResult {
//   final TourGuide tourGuide;
//   final String message;

//   TourGuideSignInResult({this.tourGuide, this.message});
// }
