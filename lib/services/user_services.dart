part of 'services.dart';

class UserServices {
  static Future<void> regisUser(User user) async {
    try {
      await http.post(BaseUrl.regisUser, body: {
        "id": user.id,
        "email": user.email,
        "name": user.name,
        "hp": user.hp
      });
    } catch (e) {
      print("Error : $e");
    }
  }
}
