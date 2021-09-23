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

      return User(id, user['email'],
          name: user['name'], profilePicture: user['image'], hp: user['hp']);
    } catch (e) {
      debugPrint("Error Get User: " + e.toString());
      return null;
    }
  }

  static Future<List<Location>> getLocations() async {
    final response = await http.get(BaseUrl.getLocations);
    final data = json.decode(response.body);

    return (data as List)
        .map((e) =>
            Location(id: e['id_location'], name: e['name'], image: e['image']))
        .toList();
  }

  static Future<void> uploadImage({File imageFile, String idUser}) async {
    try {
      var uri = Uri.parse(BaseUrl.uploadUserImage);
      var request = http.MultipartRequest("POST", uri);

      request.fields['id_user'] = idUser;

      var stream =
          http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      request.files.add(http.MultipartFile('image', stream, length,
          filename: path.basename(imageFile.path)));

      http.Response response =
          await http.Response.fromStream(await request.send());
      final data = jsonDecode(response.body);
      int value = data["value"];
      String message = data["message"];
      if (value == 1) {
        print(message);
        // return user.copyWith(profilePicture: path.basename(imageFile.path));
      } else {
        print(message);
        // return user;
      }
    } catch (e) {
      print("Error upload image:" + e.toString());
      // return user;
    }
  }

  static Future<User> updateUser(User user) async {
    try {
      await http.post(BaseUrl.userUpdate, body: {
        "id": user.id,
        "email": user.email,
        "name": user.name,
        "hp": user.hp,
        "image": user.profilePicture
      });

      // await AuthServices.updateEmailFirebase(user.email);

      return user;
    } catch (e) {
      debugPrint("Error update user: $e");
      return null;
    }
  }

  static Future<List<Destination>> getDestinations(String idLocation) async {
    final response = await http
        .post(BaseUrl.getDestinations, body: {"id_location": idLocation});
    final data = json.decode(response.body);

    return (data as List).map((e) => Destination.fromJson(e)).toList();
  }

  static Future<void> addToFavorites(
      String idUser, Destination destination) async {
    try {
      final response = await http.post(BaseUrl.addToFavorites,
          body: {"id_user": idUser, "id_destination": destination.id});
      final data = jsonDecode(response.body);
      int value = data["value"];
      String message = data["message"];
      if (value == 1) {
        print(message);
      } else {
        print(message);
      }
    } catch (e) {
      print("Error Add to Favorites: $e");
    }
  }

  static Future<void> removeFromFavorites(String idFavorite) async {
    try {
      final response = await http
          .post(BaseUrl.removeFromFavorites, body: {"id_favorite": idFavorite});
      final data = jsonDecode(response.body);
      int value = data["value"];
      String message = data["message"];
      if (value == 1) {
        print(message);
      } else {
        print(message);
      }
    } catch (e) {
      print("Error Remove from Favorites: $e");
    }
  }

  static Future<List<Destination>> getFavorites(String idUser) async {
    try {
      final response =
          await http.post(BaseUrl.getFavorites, body: {"id_user": idUser});
      final data = jsonDecode(response.body);

      return (data as List).map((e) => Destination.fromJson(e)).toList();
    } catch (e) {
      print("Error Get Favorites: $e");
      return null;
    }
  }
}
