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

   static Future<List<Destination>> getDestinations(String idLocation) async {
    final response = await http
        .post(BaseUrl.getDestinations, body: {"id_location": idLocation});
    final data = json.decode(response.body);

    return (data as List).map((e) => Destination.fromJson(e)).toList();
  }

  static Future<Destination> getDetailDestination(String idDestination) async{
    final response = await http.post(BaseUrl.getDetailDestination, body: {
      "id_destination": idDestination
    });
    final data = json.decode(response.body);

    return Destination.fromJson(data);
  }
  
}