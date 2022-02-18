import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DeliveryAddressPageController extends GetxController {
  late GoogleMapController _mapController;

  final Completer<GoogleMapController> _completer = Completer();
  final PanelController panelController = PanelController();
  final TextEditingController searchField = TextEditingController();

  LatLng _myLocation =
      const LatLng(-0.49732531314209866, 117.14187383609166); //Samarinda

  final searchMode = false.obs;

  CameraPosition mapInitialCameraPosition() {
    return CameraPosition(target: _myLocation, zoom: 12.0);
  }

  void onMapCreated(GoogleMapController controller) async {
    _completer.complete(controller);

    _mapController = await _completer.future;

    _deviceLocation();
  }

  void onMapCameraMoveStarted() {
    panelController.close();
  }

  void onMapCameraIdle() {
    panelController.animatePanelToPosition(0.32);
  }

  void onMapCameraMove(CameraPosition cameraPosition) {}

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

  @override
  void onInit() {
    searchField.addListener(() {
      searchMode(searchField.text.isNotEmpty);
    });

    ever(searchMode, (bool value) {
      if (value) {
        panelController.close();
      }
    });

    super.onInit();
  }
}
