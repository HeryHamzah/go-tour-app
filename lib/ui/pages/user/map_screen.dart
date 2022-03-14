part of '../pages.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Position _currentPosition =
      Position(latitude: -5.140362, longitude: 119.4830809);
  List<Destination> destinations = [];
  BitmapDescriptor destinationMarker;
  Set<Marker> _markers = {};

  void setCustomMarker() async {
    try {
      destinationMarker = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 2.5),
          'assets/destination_marker.png');
    } catch (e) {
      print("Error custom marker: " + e.toString());
    }
  }

  GoogleMapController _googleMapController;

  Future<void> getDestinations() async {
    destinations = await GeneralServices.getDestinations();
    for (var dest in destinations) {
      _markers.add(
        Marker(
          markerId: MarkerId("id-" + dest.id),
          position: LatLng(dest.position.latitude, dest.position.longitude),
          icon: destinationMarker,
          infoWindow: InfoWindow(
              title: dest.name,
              snippet: dest.locationName,
              onTap: () {
                Get.toNamed('/destinationDetail', arguments: dest);
              }),
        ),
      );
    }
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      _markers.add(
        Marker(
          markerId: MarkerId("id-user"),
          position:
              LatLng(_currentPosition.latitude, _currentPosition.longitude),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        ),
      );
      _googleMapController
          .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
        zoom: 15,
      )));
    }).catchError((e) {
      print("Error get Current Location: " + e.toString());
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    setCustomMarker();
    getDestinations();
    super.initState();
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: backColor,
          ),
        ),
        title: Text(
          "Google Maps",
          style: themeFont.copyWith(color: backColor),
        ),
      ),
      body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target:
                LatLng(_currentPosition.latitude, _currentPosition.longitude),
            zoom: 14,
          ),
          markers: _markers,
          onMapCreated: (controller) => _googleMapController = controller),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.center_focus_strong,
            color: backColor,
          ),
          onPressed: () {
            getCurrentLocation();
          }),
    );
  }
}
