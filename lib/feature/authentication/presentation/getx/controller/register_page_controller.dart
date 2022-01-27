import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterPageController extends GetxController {
  final formKey = GlobalKey<FormState>();

  void formOnSubmit() {
    if (formKey.currentState!.validate()) {
      debugPrint('Submit');
    }
  }
}
