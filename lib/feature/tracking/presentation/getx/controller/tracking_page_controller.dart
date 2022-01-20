import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackingPageController extends GetxController {
  late GoogleMapController _mapController;
  // BitmapDescriptor? _mapMarker;

  final Completer<GoogleMapController> _completer = Completer();

  LatLng _myLocation =
      const LatLng(-0.49732531314209866, 117.14187383609166); //Samarinda

  final searchMode = false.obs;
  final markers = <MarkerId, Marker>{}.obs;

  CameraPosition mapInitialCameraPosition() {
    return CameraPosition(target: _myLocation, zoom: 12.0);
  }

  void onMapCreated(GoogleMapController controller) async {
    _completer.complete(controller);

    _mapController = await _completer.future;

    _deviceLocation();

    _liveLocation();
  }

  void _deviceLocation() async {
    Position _currentPosition = await Geolocator.getCurrentPosition();

    LatLng _newPosition = LatLng(
      _currentPosition.latitude,
      _currentPosition.longitude,
    );

    CameraPosition _cameraPosition = CameraPosition(
      target: _newPosition,
      zoom: 16,
    );

    _myLocation = _newPosition;

    _mapController
        .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }

  void _animateCamera(LatLng target, double zoom, double bearing) {
    CameraPosition _cameraPosition = CameraPosition(
      target: target,
      zoom: zoom,
      // bearing: bearing,
    );

    _mapController
        .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }

  Future _addMarker(Position position) async {
    final LatLng location = LatLng(position.latitude, position.longitude);

    const MarkerId markerId = MarkerId('user');

    // if (_mapMarker == null) {
    //   final ImageConfiguration imageConfiguration =
    //       createLocalImageConfiguration();

    //   _mapMarker = await BitmapDescriptor.fromAssetImage(
    //       imageConfiguration, KURIR_MARKER);
    // }

    final Marker marker = Marker(
      markerId: markerId,
      position: location,
      rotation: position.heading,
      // icon: _mapMarker,
    );

    markers({markerId: marker});

    _animateCamera(location, 19, position.heading);
  }

  void _liveLocation() {
    Geolocator.getPositionStream().listen((event) async {
      await _addMarker(event);

      debugPrint('\x1B[32m$event\x1B[0m');
    });
  }
}
