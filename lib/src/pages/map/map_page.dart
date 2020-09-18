import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:my_flutter/src/commons/constants.dart';
import 'package:url_launcher/url_launcher.dart';

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

  StreamSubscription<LocationData> _locationSubscription;

  double _height;

  @override
  void initState() {
    _markers = Set();
    feedNetwork();
    super.initState();
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: new Scaffold(
        body: Stack(
          alignment: Alignment.bottomRight,
          children: [
            GoogleMap(
              markers: _markers,
              mapType: MapType.normal,
              initialCameraPosition: _initLocation,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              trafficEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Container(
              margin: EdgeInsets.all(18),
              child: FloatingActionButton(
                onPressed: () {
                  //oneTimeLocation();
                  trackingLocation();
                },
                backgroundColor: _locationSubscription != null ? Colors.red : null,
                child:  Icon(Icons.my_location),
              ),
            )
          ],
        ),
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

  trackingLocation() async {
    if (_locationSubscription != null) {
      setState(() {
        _locationSubscription.cancel();
        _locationSubscription = null;
        _markers?.clear();
      });
    } else {
      final Location _locationService = Location();
      await _locationService.changeSettings(
        accuracy: LocationAccuracy.high,
        interval: 800,
        distanceFilter: 100,
      ); // meters.

      try {
        if (await _locationService.serviceEnabled()) {
          if (await _locationService.requestPermission() ==
              PermissionStatus.granted) {
            _locationSubscription = _locationService.onLocationChanged.listen(
              (LocationData result) async {
                _markers?.clear();
                final latLng = LatLng(result.latitude, result.longitude);
                await addMarker(
                  latLng,
                  isShowInfo: true,
                );
                setState(() {
                  animateCamera(position: latLng);
                });

                print(latLng);
              },
            );
          } else {
            print('Permission denied');
          }
        } else {
          bool serviceStatusResult = await _locationService.requestService();
          print("Service status activated after request: $serviceStatusResult");
          if (serviceStatusResult) {
            trackingLocation();
          } else {
            print('Service denied');
          }
        }
      } on PlatformException catch (e) {
        print('trackingLocation error: ${e.message}');

        if (e.code == 'PERMISSION_DENIED') {
          return print('Permission denied');
        }

        if (e.code == 'SERVICE_STATUS_ERROR') {
          return print('Service error');
        }
      }
    }
  }

  addMarker(
    LatLng position, {
    String title = 'none',
    String snippet = 'none',
    String pinAsset = "assets/images/biker.png",
    bool isShowInfo = false,
  }) async {
    final Uint8List markerIcon = await getBytesFromAsset(
      pinAsset,
      width: _height * 20 ~/ 100,
    );
    final BitmapDescriptor bitmap = BitmapDescriptor.fromBytes(markerIcon);

    _markers.add(
      Marker(
        markerId: MarkerId(position.toString()),
        // important. unique id
        position: position,
        infoWindow: isShowInfo
            ? InfoWindow(
                title: title,
                snippet: snippet,
                onTap: () {
                  _launchMaps(
                    lat: position.latitude,
                    lng: position.longitude,
                  );
                },
              )
            : null,
        icon: bitmap,
        onTap: () {
          print('lat: ${position.latitude}, lng: ${position.longitude}');
        },
      ),
    );
  }

  Future<Uint8List> getBytesFromAsset(
    String path, {
    int width,
  }) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  _launchMaps({double lat, double lng}) async {
    // Set Google Maps URL Scheme for iOS in info.plist (comgooglemaps)

    const googleMapSchemeIOS = 'comgooglemaps://';
    const googleMapURL = 'https://maps.google.com/';
    const appleMapURL = 'https://maps.apple.com/';
    final parameter = '?z=16&q=$lat,$lng';

    if (Platform.isIOS) {
      if (await canLaunch(googleMapSchemeIOS)) {
        return await launch(googleMapSchemeIOS + parameter);
      }

      if (await canLaunch(appleMapURL)) {
        return await launch(appleMapURL + parameter);
      }
    } else {
      if (await canLaunch(googleMapURL)) {
        return await launch(googleMapURL + parameter);
      }
    }

    throw 'Could not launch url';
  }
}
