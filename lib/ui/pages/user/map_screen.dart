part of '../pages.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

BitmapDescriptor destinationMarker;

class _MapScreenState extends State<MapScreen> {
  // Completer<GoogleMapController> _controller = Completer();
  Position _currentPosition =
      Position(latitude: -5.140362, longitude: 119.4830809);
  Marker _origin;
  Set<Marker> _destinations = {dest1, dest2, dest3};
  // String _currentAddress;

  void setCustomMarker() async {
    destinationMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/destination_marker.png');
  }

  GoogleMapController _googleMapController;

  Future<void> getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print("Error get Current Location: " + e.toString());
    });
  }

  static final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(-5.140362, 119.4830809),
    zoom: 14,
  );

  @override
  void initState() {
    getCurrentLocation();
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
          markers: _destinations,
          onMapCreated: (controller) => _googleMapController = controller),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.center_focus_strong,
            color: backColor,
          ),
          onPressed: () {
            _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(_initialCameraPosition));
          }),
    );
  }
}

Marker dest1 = Marker(
    markerId: MarkerId('3'),
    icon: destinationMarker,
    position: LatLng(-5.1403567000, 119.4808922000),
    draggable: true,
    onTap: () {
      print("Tapped");
    },
    infoWindow: InfoWindow(title: "Tes", snippet: "Tes"));

Marker dest2 = Marker(
    icon: destinationMarker,
    markerId: MarkerId('1'),
    position: LatLng(-5.1545372000, 119.4210330000),
    infoWindow: InfoWindow(title: "Tes2", snippet: "Tes2"));

Marker dest3 = Marker(
    icon: destinationMarker,
    markerId: MarkerId('2'),
    position: LatLng(-5.1384045000, 119.4824149000),
    infoWindow: InfoWindow(title: "Tes4", snippet: "Tes4"));
