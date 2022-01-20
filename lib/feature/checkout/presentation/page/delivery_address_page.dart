import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/feature/checkout/presentation/getx/controller/delivery_address_page_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DeliveryAddressPage extends GetView<DeliveryAddressPageController> {
  const DeliveryAddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0,
        title: Container(
          height: 44,
          width: double.infinity,
          margin: const EdgeInsets.only(right: kBigPadding),
          padding:
              const EdgeInsets.only(left: kBigPadding, right: kSmallPadding),
          decoration: BoxDecoration(
            color: kLightColor,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: TextField(
            controller: controller.searchField,
            textInputAction: TextInputAction.search,
            style: Get.textTheme.bodyText1,
            decoration: InputDecoration(
              hintText: 'Cari alamat di sini',
              hintStyle: Get.theme.textTheme.bodyText2,
              contentPadding: const EdgeInsets.only(right: 8, top: 4),
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              suffixIconConstraints:
                  const BoxConstraints(maxWidth: 32, maxHeight: 32),
              suffixIcon: SizedBox(
                width: 32,
                height: 32,
                child: Material(
                  color: Get.theme.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    child: const Icon(
                      AppIcon.search,
                      color: kLightColor,
                      size: 20,
                    ),
                    onTap: () {},
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SlidingUpPanel(
        controller: controller.panelController,
        parallaxEnabled: false,
        parallaxOffset: 0.5,
        minHeight: 110,
        maxHeight: 360,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(1, 1), // changes position of shadow
          ),
        ],
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        header: _panelHeader(),
        panel: _panel(),
        body: _panelBody(controller: controller),
      ),
    );
  }
}

Widget _panelHeader() {
  return Container(
    width: Get.size.width,
    alignment: Alignment.center,
    child: Icon(
      Icons.drag_handle_rounded,
      color: Colors.grey[400],
      size: 30,
    ),
  );
}

Widget _panel() {
  return Padding(
    padding: const EdgeInsets.all(kMediumPadding),
    child: Column(
      children: [
        const SizedBox(height: kBigPadding),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 30,
                  child: Icon(
                    AppIcon.mapmarker,
                    color: kLightColor100,
                  ),
                ),
                const SizedBox(width: kTinyPadding),
                Expanded(
                  child: Text(
                    'Perumahan Grand Tsamara, No 27 Pangkalan Gas 3 Kg dalam bumi sempaja griya mukti pm noor',
                    style: Get.textTheme.bodyText1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: kMediumPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 30,
                  child: Icon(
                    AppIcon.user,
                    color: kLightColor100,
                  ),
                ),
                const SizedBox(width: kTinyPadding),
                Expanded(
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: 'Nama',
                      hintStyle: Get.textTheme.bodyText2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: kMediumPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 30,
                  child: Icon(
                    AppIcon.phone,
                    color: kLightColor100,
                    size: 20,
                  ),
                ),
                const SizedBox(width: kTinyPadding),
                Expanded(
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'No Hp',
                      hintStyle: Get.textTheme.bodyText2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: kMediumPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 30,
                  child: Icon(
                    AppIcon.note,
                    color: kLightColor100,
                    size: 20,
                  ),
                ),
                const SizedBox(width: kTinyPadding),
                Expanded(
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: 'Catatan',
                      hintStyle: Get.textTheme.bodyText2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: kBigPadding),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Simpan'),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Widget _panelBody({required DeliveryAddressPageController controller}) {
  return Stack(
    children: [
      GoogleMap(
        mapToolbarEnabled: false,
        rotateGesturesEnabled: false,
        tiltGesturesEnabled: false,
        zoomControlsEnabled: false,
        compassEnabled: false,
        myLocationButtonEnabled: false,
        myLocationEnabled: true,
        initialCameraPosition: controller.mapInitialCameraPosition(),
        onMapCreated: controller.onMapCreated,
      ),
      Obx(() {
        return (!controller.searchMode())
            ? const SizedBox.shrink()
            : Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                    left: kMediumPadding, right: kMediumPadding, top: 80),
                constraints: const BoxConstraints(maxHeight: 350),
                decoration: BoxDecoration(
                  color: kLightColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(1, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Builder(builder: (context) {
                  return MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.separated(
                      itemCount: 10,
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1),
                      itemBuilder: (context, index) {
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: Ink(
                              padding: const EdgeInsets.all(kMediumPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Jl. Dr. Sutomo',
                                    style: Get.textTheme.bodyText1,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Jl. Gerilya, Sungai Pinang Dalam, Kota Samarinda, Kalimantan Timur, Indonesia',
                                    style: Get.textTheme.bodyText2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              );
      })
    ],
  );
}
