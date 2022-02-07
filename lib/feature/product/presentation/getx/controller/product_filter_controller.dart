import 'package:get/get.dart';

class ProductFilterController extends GetxController {
  final mValue = ''.obs;

  void setValue(String v) {
    mValue(v);
  }
}
