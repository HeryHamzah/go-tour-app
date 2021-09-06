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

  static Future<User> getUser(String id) async {
    try {
      final response = await http.post(BaseUrl.getUser, body: {"id_user": id});
      final data = jsonDecode(response.body);
      final user = data[0];

      return User(user['id'], user['email'],
          name: user['name'], profilePicture: user['image'], hp: user['hp']);
    } catch (e) {
      print("Err: " + e.toString());
      return null;
    }
  }
}
