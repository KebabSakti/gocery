import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MDialog {
  static loading({String text = 'Loading..'}) {
    Get.dialog(
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(width: 20),
                  Text(text)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static close() {
    if (Get.isDialogOpen != null) {
      if (Get.isDialogOpen!) {
        Get.back();
      }
    }
  }
}
