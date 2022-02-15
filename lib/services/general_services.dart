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

  static Future<List<Destination>> getDestinationsbyLocation(
      String idLocation) async {
    final response = await http.post(BaseUrl.getDestinationsbyLocation,
        body: {"id_location": idLocation});
    final data = json.decode(response.body);

    return (data as List).map((e) => Destination.fromJson(e)).toList();
  }

  static Future<Destination> getDetailDestination(String idDestination) async {
    final response = await http.post(BaseUrl.getDetailDestination,
        body: {"id_destination": idDestination});
    final data = jsonDecode(response.body);
    final destination = data['result'] as Map<String, dynamic>;

    return Destination.fromJson(destination);
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

  static Future<List<Destination>> getAllDestinations() async {
    try {
      final response = await http.get(BaseUrl.getAllDestinations);
      final data = json.decode(response.body);

      return (data as List).map((e) => Destination.fromJson(e)).toList();
    } catch (e) {
      print("Error get All Destinations : " + e.toString());
      return null;
    }
  }
}
