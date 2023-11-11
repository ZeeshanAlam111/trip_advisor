
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  final double? latitude;
  final double? longitude;

  MapScreen({this.latitude, this.longitude});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  Set<Marker> _markers = {};
  Position? _currentPosition;
  Set<Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }

    try {
      _currentPosition = await Geolocator.getCurrentPosition();
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId('Current Location'),
            position: LatLng(
              _currentPosition!.latitude,
              _currentPosition!.longitude,
            ),
            infoWindow: InfoWindow(
              title: 'Current Location',
              snippet:
              'Latitude: ${_currentPosition!.latitude}, Longitude: ${_currentPosition!.longitude}',
            ),
          ),
        );
      });
      mapController.moveCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(
            _currentPosition!.latitude,
            _currentPosition!.longitude,
          ),
          11.0,
        ),
      );

      if (widget.latitude != null && widget.longitude != null) {
        _getPolyline();
      }
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _getPolyline() {
    // Get the start and end points of the polyline.
    LatLng startLatLng = LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
    LatLng endLatLng = LatLng(widget.latitude!, widget.longitude!);

    // Create a Polyline object with the start and end points.
    Polyline polyline = Polyline(
      polylineId: PolylineId("my_polyline"),
      points: [startLatLng, endLatLng],
      color: Colors.blue,
      width: 10,
    );

    // Create markers for start and end locations.
    Marker startMarker = Marker(
      markerId: MarkerId('Current Location'),
      position: startLatLng,
      infoWindow: InfoWindow(
        title: 'Current Location',
        snippet: 'Latitude: ${startLatLng.latitude}, Longitude: ${startLatLng.longitude}',
      ),
      icon: BitmapDescriptor.defaultMarker, // Red marker for current location
    );

    Marker endMarker = Marker(
      markerId: MarkerId('Target Location'),
      position: endLatLng,
      infoWindow: InfoWindow(
        title: 'Target Location',
        snippet: 'Latitude: ${endLatLng.latitude}, Longitude: ${endLatLng.longitude}',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue), // Blue marker for target location
    );

    // Add the polyline and markers to the map.
    setState(() {
      polylines.add(polyline);
      _markers.add(startMarker);
      _markers.add(endMarker);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            _currentPosition?.latitude ?? 0.0,
            _currentPosition?.longitude ?? 0.0,
          ),
          zoom: 11.0,
        ),
        markers: _markers,
        polylines: polylines,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
