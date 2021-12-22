import 'package:get/get.dart';
import 'package:gocery/feature/intro/presentation/page/intro_page.dart';

class AppRoute {
  static const introPage = '/';
  static const landingPage = '/landing';

  static final routes = [
    GetPage(name: introPage, page: () => const IntroPage()),
    GetPage(name: landingPage, page: () => const IntroPage()),
  ];
}
