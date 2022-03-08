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
      print("Error marker: " + e.toString());
    }
  }

  GoogleMapController _googleMapController;

  // Future<void> getCurrentLocation() async {
  //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //       .then((Position position) {
  //     setState(() {
  //       _currentPosition = position;
  //     });
  //     _googleMapController
  //         .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //       target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
  //       zoom: 14,
  //     )));
  //   }).catchError((e) {
  //     print("Error get Current Location: " + e.toString());
  //   });
  // }

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

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
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
