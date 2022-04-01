import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_route.dart';
import 'package:gocery/core/config/app_theme.dart';
import 'package:gocery/core/service/map_api/map_api.dart';
import 'package:gocery/core/service/map_api/map_api_service.dart';
import 'package:gocery/core/service/websocket/websocket.dart';
import 'package:gocery/core/service/websocket/websocket_service.dart';
import 'package:gocery/dependency.dart';
import 'package:gocery/firebase_options.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/places.dart';

import 'core/config/app_const.dart';
import 'core/service/network/dio_client.dart';
import 'core/service/network/network.dart';
import 'core/service/storage/secure_storage_client.dart';
import 'core/service/storage/storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initServices();

  runApp(const Gocery());
}

class Gocery extends StatelessWidget {
  const Gocery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      opaqueRoute: true,
      initialBinding: Dependency(),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      getPages: AppRoute.routes,
      initialRoute: kIntroPage,
    );
  }
}

Future _initServices() async {
  Get.put(SecureStorageImpl(SecureStorageClient()));
  Get.put(NetworkImpl(DioClient()));
  Get.put(WebsocketImpl(implementation: WebsocketService()));

  Get.put(MapApiImpl(
    implementation: MapApiService(
      geocoding: GoogleMapsGeocoding(apiKey: kMapKey),
      places: GoogleMapsPlaces(apiKey: kMapKey),
    ),
  ));

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // SENTRY DNS : https://845349c05f934f409c1694f8d022cc85@o1130472.ingest.sentry.io/6174528

  // await SentryFlutter.init(
  //   (options) {
  //     options.dsn =
  //         'https://123845349c05f934f409c1694f8d022cc85@o1130472.ingest.sentry.io/6174528';
  //     // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
  //     // We recommend adjusting this value in production.
  //     // options.tracesSampleRate = 1.0;
  //   },
  //   appRunner: () => runApp(const Gocery()),
  // );
}
