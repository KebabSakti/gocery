import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/feature/tracking/presentation/getx/controller/tracking_page_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackingPage extends GetView<TrackingPageController> {
  const TrackingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Obx(() {
        return GoogleMap(
          mapToolbarEnabled: false,
          rotateGesturesEnabled: false,
          tiltGesturesEnabled: false,
          zoomControlsEnabled: false,
          compassEnabled: false,
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          initialCameraPosition: controller.mapInitialCameraPosition(),
          onMapCreated: controller.onMapCreated,
          markers: Set<Marker>.of(controller.markers.values),
        );
      }),
    );
  }
}
