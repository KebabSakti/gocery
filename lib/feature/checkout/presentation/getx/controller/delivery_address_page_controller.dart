import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/utility/mtoast.dart';
import 'package:gocery/core/utility/utility.dart';
import 'package:gocery/feature/checkout/domain/entity/shipping_address_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DeliveryAddressPageController extends GetxController {
  GoogleMapController? mapController;
  CameraPosition? mCameraPosition;

  String? name;
  String? phone;
  String? note;

  final Completer<GoogleMapController> completer = Completer();
  final PanelController panelController = PanelController();
  final TextEditingController searchField = TextEditingController();

  final addressEntity = ShippingAddressEntity().obs;
  final searchMode = false.obs;

  CameraPosition mapInitialCameraPosition() {
    LatLng defaultLocation =
        const LatLng(-0.49732531314209866, 117.14187383609166);

    return CameraPosition(target: defaultLocation, zoom: 12.0);
  }

  void onMapCreated(GoogleMapController controller) async {
    completer.complete(controller);

    mapController = await completer.future;

    if (Get.arguments == null) {
      deviceLocation();
    } else {
      editDeliveryInfo();
    }
  }

  void onMapCameraMoveStarted() {
    searchMode(true);
  }

  void onMapCameraIdle() {
    _geocoding();
  }

  void onMapCameraMove(CameraPosition cameraPosition) {
    mCameraPosition = cameraPosition;
  }

  void saveDeliveryInfo() {
    if (name == null || phone == null) {
      MToast.show('Nama atau No Telp tidak boleh kosong');
    } else {
      var result =
          addressEntity().copyWith(name: name, phone: phone, note: note);

      Get.back(result: result);
    }
  }

  void editDeliveryInfo() {
    final ShippingAddressEntity? argument = Get.arguments;

    if (argument != null) {
      name = argument.name;
      phone = argument.phone;
      note = argument.note;

      addressEntity(argument);

      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(
          double.parse(argument.latitude!),
          double.parse(argument.longitude!),
        ),
        zoom: 16,
      );

      animateCamera(cameraPosition: cameraPosition);
    }
  }

  void animateCamera({required CameraPosition cameraPosition}) {
    mapController
        ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  void deviceLocation() async {
    Position _currentPosition = await Geolocator.getCurrentPosition();

    CameraPosition _cameraPosition = CameraPosition(
      target: LatLng(
        _currentPosition.latitude,
        _currentPosition.longitude,
      ),
      zoom: 16,
    );

    animateCamera(cameraPosition: _cameraPosition);
  }

  void _geocoding() async {
    if (mCameraPosition != null) {
      double latitude = mCameraPosition!.target.latitude;
      double longitude = mCameraPosition!.target.longitude;

      List<Placemark> placemark = await placemarkFromCoordinates(
        latitude,
        longitude,
        localeIdentifier: 'id',
      );

      String address = Utility.placemarkToString(placemark: placemark);

      addressEntity(addressEntity().copyWith(
        address: address,
        latitude: latitude.toString(),
        longitude: longitude.toString(),
      ));

      searchMode(false);
    }
  }

  void toSearchAddressPage() async {
    var result = await Get.toNamed(kSearchAddressPage);

    if (result != null) {
      addressEntity(result);

      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(
          double.parse(result.latitude!),
          double.parse(result.longitude!),
        ),
        zoom: 16,
      );

      animateCamera(cameraPosition: cameraPosition);
    }
  }

  @override
  void onInit() {
    searchField.addListener(() {
      searchMode(searchField.text.isNotEmpty);
    });

    ever(searchMode, (bool value) {
      if (value) {
        panelController.close();
      } else {
        panelController.open();
      }
    });

    super.onInit();
  }
}
