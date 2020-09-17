import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
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
      body: GoogleMap(
        markers: _markers,
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
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
        )
      );
      _markers.add(marker);
    });

    setState(() {

    });
  }
}
