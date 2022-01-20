import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_route.dart';
import 'package:gocery/core/config/app_theme.dart';
import 'package:gocery/dependency.dart';
import 'package:gocery/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
