part of 'services.dart';

class UserServices {
  static CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> regisUserFirebase(User user) async {
    await _userCollection
        .doc(user.id)
        .set({'email': user.email, 'favorites': user.favorites});
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

    //Note: GET USER FROM MYSQL DATABASE
    try {
      final response = await http.post(BaseUrl.getUser, body: {"id_user": id});
      final data = jsonDecode(response.body);
      final user = data['result'] as Map<String, dynamic>;

      return User(id, user['email'],
          name: user['name'],
          profilePicture: user['image'],
          hp: user['hp'],
          balance: int.tryParse(user['balance']),
          favorites: (snapshot.data()['favorites'] as List)
              .map((e) => e as String)
              .toList());
    } catch (e) {
      debugPrint("Error Get User: " + e.toString());
      return null;
    }
  }

  static Future<void> uploadImage({File imageFile, String userID}) async {
    try {
      var uri = Uri.parse(BaseUrl.uploadUserImage);
      var request = http.MultipartRequest("POST", uri);

      request.fields['id_user'] = userID;

      var stream =
          http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      request.files.add(http.MultipartFile('image', stream, length,
          filename: path.basename(imageFile.path)));

      http.Response response =
          await http.Response.fromStream(await request.send());
      final data = jsonDecode(response.body);
      String message = data["message"];
      print(message);
    } catch (e) {
      print("Error upload image:" + e.toString());
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
        "image": user.profilePicture,
        "balance": user.balance.toString()
      });

      //UPDATE TO FIREBASE
      await _userCollection
          .doc(user.id)
          .set({'email': user.email, 'favorites': user.favorites});

      return user;
    } catch (e) {
      debugPrint("Error update user: $e");
      return null;
    }
  }

  static Future<List<Destination>> getFavorites(String userID) async {
    try {
      DocumentSnapshot snapshots = await _userCollection.doc(userID).get();

      List<Destination> favorites = [];

      for (var snapshot in snapshots.data()['favorites']) {
        Destination destination =
            await GeneralServices.getDetailDestination(snapshot);

        favorites.add(destination);
      }
      return favorites;
    } catch (e) {
      print("Error get favorites: " + e.toString());
      return null;
    }
  }

  static Future<void> saveTransaction(GoTourTransaction transaction) async {
    try {
      await http.post(BaseUrl.saveTransaction, body: {
        "id_transaction": transaction.transactionID,
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

  static Future<void> saveticket(Ticket ticket) async {
    try {
      await http.post(BaseUrl.saveTicket, body: {
        "booking_code": ticket.bookingCode,
        "id_user": ticket.userID,
        "id_destination": ticket.destination.id,
        "total_ticket": ticket.totalTicket.toString(),
        "time": ticket.time.millisecondsSinceEpoch.toString(),
        "total_price": ticket.totalPrice.toString()
      });
    } catch (e) {
      print("Error save ticket: " + e.toString());
    }
  }

  static Future<List<Ticket>> getTickets() async {
    try {
      final response = await http.get(BaseUrl.getTickets);
      final data = json.decode(response.body);

      List<Ticket> tickets = [];

      for (var dt in data) {
        Destination destination =
            await GeneralServices.getDetailDestination(dt['id_destination']);

        tickets.add(Ticket.fromJson(dt, destination));
      }

      return tickets;
    } catch (e) {
      print("Error get tickets: " + e.toString());
      return null;
    }
  }

  static Future<void> saveTourGuideTicket(
      TourGuideTicket tourGuideTicket) async {
    try {
      await http.post(BaseUrl.saveTourGuideTicket, body: {
        "booking_code": tourGuideTicket.bookingCode,
        "id_user": tourGuideTicket.userID,
        "id_tourguide": tourGuideTicket.tourGuide.tourGuideID,
        "date_time": tourGuideTicket.dateTime.millisecondsSinceEpoch.toString(),
        "destinations": tourGuideTicket.destinations,
        "total_price": tourGuideTicket.totalPrice.toString(),
      });
    } catch (e) {
      print("Error save Tour Guide ticket: " + e.toString());
    }
  }

  static Future<List<TourGuideTicket>> getTourGuideTickets() async {
    try {
      final response = await http.get(BaseUrl.getTourGuideTickets);
      final data = json.decode(response.body);

      return (data as List).map((e) => TourGuideTicket.fromJson(e)).toList();
    } catch (e) {
      print("Error get Tour Guide Tickets: " + e.toString());
      return null;
    }
  }

  static Future<void> addDestinationReview(
      String bookingCode, String comment, double rating) async {
    try {
      final response = await http.post(BaseUrl.addDestinationReview, body: {
        "booking_code": bookingCode,
        "comment": comment,
        "rating": rating.toString()
      });
      final data = jsonDecode(response.body);
      print(data['message']);
    } catch (e) {
      print("Error add Destination Review: " + e.toString());
    }
  }

  static Future<void> addTourGuideReview(
      String id, String comment, double rating) async {
    try {
      final response = await http.post(BaseUrl.addTourGuideReview,
          body: {"id": id, "comment": comment, "rating": rating.toString()});
      final data = jsonDecode(response.body);
      print(data['message']);
    } catch (e) {
      print("Error add Tour Guide Review: " + e.toString());
    }
  }
}
