part of 'services.dart';

class GeneralServices {
  static Future<List<Location>> getLocations() async {
    final response = await http.get(BaseUrl.getLocations);
    final data = json.decode(response.body);

    return (data as List)
        .map((e) =>
            Location(id: e['id_location'], name: e['name'], image: e['image']))
        .toList();
  }

  // static Future<List<Destination>> getDestinationsbyLocation(
  //     String idLocation) async {
  //   final response = await http.post(BaseUrl.getDestinationsbyLocation,
  //       body: {"id_location": idLocation});
  //   final data = json.decode(response.body);

  //   return (data as List).map((e) => Destination.fromJson(e)).toList();
  // }

  static Future<Destination> getDetailDestination(String idDestination) async {
    try {
      final response = await http.post(BaseUrl.getDetailDestination,
          body: {"id_destination": idDestination});
      final data = jsonDecode(response.body);
      final destination = data['result'] as Map<String, dynamic>;

      return Destination.fromJson(destination);
    } catch (e) {
      print("Error get Detail Destinations: " + e.toString());
      return null;
    }
  }

  static Future<List<TourGuide>> getTourGuides() async {
    try {
      final response = await http.get(BaseUrl.getTourGuides);
      final data = json.decode(response.body);

      return (data as List).map((e) => TourGuide.fromJon(e)).toList();
    } catch (e) {
      print("Error get Tour Guides : " + e.toString());
      return null;
    }
  }

  static Future<List<Destination>> getDestinations() async {
    try {
      final response = await http.get(BaseUrl.getDestinations);
      final data = json.decode(response.body);

      return (data as List).map((e) => Destination.fromJson(e)).toList();
    } catch (e) {
      print("Error get Destinations : " + e.toString());
      return null;
    }
  }

  // static Future<List<Review>> getTourGuideReviews(String tourGuideID) async {
  //   try {
  //     final response = await http.post(BaseUrl.getTourGuideReviews,
  //         body: {"id_tourguide": tourGuideID});
  //     final data = json.decode(response.body);

  //     return (data as List).map((e) => Review.fromJson(e)).toList();
  //   } catch (e) {
  //     print("Error get Tour Guide Reviews : " + e.toString());
  //     return null;
  //   }
  // }

  // static Future<List<Review>> getDestinationReviews(
  //     String destinationID) async {
  //   try {
  //     final response = await http.post(BaseUrl.getDestinationReviews,
  //         body: {"id_destination": destinationID});
  //     final data = json.decode(response.body);

  //     return (data as List).map((e) => Review.fromJson(e)).toList();
  //   } catch (e) {
  //     print("Error get Destination Reviews : " + e.toString());
  //     return null;
  //   }
  // }
}
