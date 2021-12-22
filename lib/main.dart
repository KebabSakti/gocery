import 'package:flutter/material.dart';
import 'package:gocery/core/config/app_route.dart';
import 'package:gocery/core/config/app_theme.dart';
import 'package:get/get.dart';
import 'package:gocery/dependency.dart';

void main() {
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
      initialRoute: AppRoute.introPage,
    );
  }
}
