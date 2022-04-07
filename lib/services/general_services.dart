part of 'services.dart';

class GeneralServices {
  static Future<List<Location>> getLocations() async {
    try {
      final response = await http.get(BaseUrl.getLocations);
      final data = json.decode(response.body);

      return (data as List)
          .map((e) => Location(
              id: e['id_location'], name: e['name'], image: e['image']))
          .toList();
    } catch (e) {
      print("Error get Locations: " + e.toString());
      return null;
    }
  }

  static Future<Destination> getDetailDestination(String idDestination) async {
    try {
      final response = await http.post(BaseUrl.getDetailDestination,
          body: {"id_destination": idDestination});
      final data = jsonDecode(response.body);
      final destination = data['result'] as Map<String, dynamic>;

      return Destination.fromJson(destination);
    } catch (e) {
      print("Error get Detail Destination: " + e.toString());
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
}
