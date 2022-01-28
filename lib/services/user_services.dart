part of 'services.dart';

class UserServices {
  static CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> regisUserFirebase(User user) async {
    await _userCollection.doc(user.id).set({
      'email': user.email,
      'favorites': user.favorites,
      'myTrips': user.myTrips
    });
  }

  static Future<void> regisUser(User user) async {
    try {
      await http.post(BaseUrl.regisUser, body: {
        "id": user.id,
        "email": user.email,
        "name": user.name,
        "hp": user.hp,
        "balance": user.balance.toString()
      });
    } catch (e) {
      print("Error : $e");
    }
  }

  static Future<User> getUser(String id) async {
    //Note: GET USER FROM FIREBASE
    DocumentSnapshot snapshot = await _userCollection.doc(id).get();

    //Note: GET USER FROM DATABASE
    try {
      final response = await http.post(BaseUrl.getUser, body: {"id_user": id});
      final data = jsonDecode(response.body);
      final user = data['result'] as Map<String, dynamic>;

      return User(
        id,
        user['email'],
        name: user['name'],
        profilePicture: user['image'],
        hp: user['hp'],
        balance: int.tryParse(user['balance']),
        favorites: (snapshot.data()['favorites'] as List)
            .map((e) => e as String)
            .toList(),
        myTrips: (snapshot.data()['myTrips'] as List)
            .map((e) => e as String)
            .toList(),
      );
    } catch (e) {
      debugPrint("Error Get User: " + e.toString());
      return null;
    }
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
    //UPDATE TO MYSQL
    try {
      await http.post(BaseUrl.userUpdate, body: {
        "id": user.id,
        "email": user.email,
        "name": user.name,
        "hp": user.hp,
        "image": user.profilePicture
      });

      // await AuthServices.updateEmailFirebase(user.email);

      //UPDATE TO FIREBASE
      await _userCollection.doc(user.id).set({
        'email': user.email,
        'favorites': user.favorites,
        'myTrips': user.myTrips
      });

      return user;
    } catch (e) {
      debugPrint("Error update user: $e");
      return null;
    }
  }

  // static Future<void> addToFavorites(
  //     String idUser, String idDestination) async {
  //   try {
  //     final response = await http.post(BaseUrl.addToFavorites,
  //         body: {"id_user": idUser, "id_destination": idDestination});
  //     final data = jsonDecode(response.body);
  //     // int value = data["value"];
  //     String message = data["message"];
  //     print(message);
  //   } catch (e) {
  //     print("Error Add to Favorites: $e");
  //   }
  // }

  // static Future<void> removeFromFavorites(
  //     String idUser, String idDestination) async {
  //   try {
  //     final response = await http.post(BaseUrl.removeFromFavorites,
  //         body: {"id_destination": idDestination, "id_user": idUser});
  //     final data = jsonDecode(response.body);
  //     // int value = data["value"];
  //     String message = data["message"];
  //     print(message);
  //   } catch (e) {
  //     print("Error Remove from Favorites: $e");
  //   }
  // }

  static Future<List<Destination>> getFavorites(String userID) async {
    // try {
    //   final response =
    //       await http.post(BaseUrl.getFavorites, body: {"id_user": idUser});
    //   final data = jsonDecode(response.body);

    //   return (data as List).map((e) => Destination.fromJson(e)).toList();
    // } catch (e) {
    //   print("Error Get Favorites: $e");
    //   return null;
    // }

    DocumentSnapshot snapshots = await _userCollection.doc(userID).get();

    List<Destination> favorites = [];

    for (var snapshot in snapshots.data()['favorites']) {
      Destination destination =
          await GeneralServices.getDetailDestination(snapshot);

      favorites.add(destination);
    }
    return favorites;
  }

  static Future<List<Destination>> getMyTrips(String userID) async {
    DocumentSnapshot snapshots = await _userCollection.doc(userID).get();

    List<Destination> myTrips = [];

    for (var snapshot in snapshots.data()['myTrips']) {
      Destination destination =
          await GeneralServices.getDetailDestination(snapshot);

      myTrips.add(destination);
    }
    return myTrips;
  }

  static Future<void> saveTransaction(GoTourTransaction transaction) async {
    try {
      await http.post(BaseUrl.saveTransaction, body: {
        "id_user": transaction.userID,
        "title": transaction.title,
        "picture_path": transaction.picturePath,
        "amount": transaction.amount.toString(),
        "time": transaction.time.millisecondsSinceEpoch.toString(),
        "description": transaction.desc
      });
    } catch (e) {
      print("Error save transaction: " + e.toString());
    }
  }

  static Future<List<GoTourTransaction>> getTransactions(String userID) async {
    try {
      final response =
          await http.post(BaseUrl.getTransactions, body: {"id_user": userID});
      final data = jsonDecode(response.body);

      return (data as List).map((e) => GoTourTransaction.fromJson(e)).toList();
    } catch (e) {
      print("Error get transactions: " + e.toString());
      return null;
    }
  }
}
