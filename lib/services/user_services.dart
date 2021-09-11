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
      final user = data['result'] as Map<String, dynamic>;

      return User(user['id'], user['email'],
          name: user['name'], profilePicture: user['image'], hp: user['hp']);
    } catch (e) {
      debugPrint("Error Get User: " + e.toString());
      return null;
    }
  }

  static Future<List<Location>> getLocation() async {
    final response = await http.get(BaseUrl.getLocation);
    final data = json.decode(response.body);

    return (data as List)
        .map((e) =>
            Location(id: e['id_location'], name: e['name'], image: e['image']))
        .toList();
  }
}
