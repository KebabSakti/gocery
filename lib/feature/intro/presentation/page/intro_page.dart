import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/feature/intro/presentation/getx/intro_page_controller.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: IntroPageController(),
        builder: (IntroPageController c) {
          return Scaffold(
            body: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Lagi siap siap',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
