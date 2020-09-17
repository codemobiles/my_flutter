import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _initLocation = CameraPosition(
    target: LatLng(13.7625754, 100.4938512),
    zoom: 12.4746,
  );

  Set<Marker> _markers;

  @override
  void initState() {
    _markers = Set();
    feedNetwork();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            markers: _markers,
            mapType: MapType.normal,
            initialCameraPosition: _initLocation,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
            trafficEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          FloatingActionButton(
            onPressed: () {
              oneTimeLocation();
            },
            child: Icon(Icons.my_location),
          )
        ],
      ),
    );
  }

  void feedNetwork() async {
    await Future.delayed(Duration(seconds: 5));
    final List<LatLng> dummyLocations = [];
    dummyLocations.add(LatLng(13.7625754, 100.4938512));
    dummyLocations.add(LatLng(13.728139, 100.5308373));

    dummyLocations.forEach((latLng) {
      Marker marker = Marker(
          markerId: MarkerId(UniqueKey().toString()),
          position: latLng,
          infoWindow: InfoWindow(
            title: "CM",
            snippet: "09:00 - 18:00",
          ));
      _markers.add(marker);
    });

    setState(() {});
  }

  oneTimeLocation() async {
    try {
      Location().getLocation().then((currentLocation) {
        final lat = currentLocation.latitude;
        final lng = currentLocation.longitude;
        animateCamera(position: LatLng(lat, lng));
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print('Permission denied');
      }
      print('oneTimeLocation error: ${e.message}');
    }
  }

  Future<void> animateCamera({LatLng position}) async {
    GoogleMapController google = await _controller.future;
    google.animateCamera(CameraUpdate.newLatLngZoom(position, 12));
  }
}
