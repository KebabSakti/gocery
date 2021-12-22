import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/feature/landing/presentation/getx/landing_page_controller.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: LandingPageController(),
        builder: (LandingPageController c) {
          return const Scaffold(
            body: Center(
              child: Text('Landing Page'),
            ),
          );
        });
  }
}
