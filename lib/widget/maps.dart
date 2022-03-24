import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

const double cameraZoom = 16;
const double cameraTilt = 80;
const double cameraBearing = 30;
const LatLng sourceLocation = LatLng(42.747932, -71.167889);
const LatLng destLocation = LatLng(37.335685, -122.0605916);

class MapsWidget extends StatefulWidget {
  const MapsWidget({Key? key}) : super(key: key);

  @override
  State<MapsWidget> createState() => _MapsWidgetState();
}

class _MapsWidgetState extends State<MapsWidget> {
  // late GoogleMapController mapController;
  LocationData? currentLocation;
  Location location = Location();

  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  late GoogleMapController _controller;
  Location _location = Location();

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
        ),
      );
    });
  }

  @override
  void initState() {
    location.onLocationChanged.listen((LocationData cLoc) {
      // cLoc contains the lat and long of the
      // current user's position in real time,
      // so we're holding on to it
      log(cLoc.longitude.toString());
      currentLocation = cLoc;
      // updatePinOnMap();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // CameraPosition initialCameraPosition = const CameraPosition(
    //     zoom: cameraZoom,
    //     tilt: cameraTilt,
    //     bearing: cameraBearing,
    //     target: sourceLocation);

    // if (currentLocation != null) {
    //   initialCameraPosition = CameraPosition(
    //       target:
    //           LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
    //       zoom: cameraZoom,
    //       tilt: cameraTilt,
    //       bearing: cameraBearing);
    // }

    return GoogleMap(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 740,
      ),
      initialCameraPosition: CameraPosition(target: _initialcameraposition),
      mapType: MapType.normal,
      onMapCreated: _onMapCreated,
      myLocationEnabled: true,
    );

    // return GoogleMap(
    //   padding: const EdgeInsets.only(bottom: 80),
    //   onMapCreated: _onMapCreated,
    //   initialCameraPosition: CameraPosition(
    //     target: _center,
    //     zoom: 11.0,
    //   ),
    // );
  }
}
