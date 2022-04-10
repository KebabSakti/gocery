import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MDialog {
  static loading({String text = 'Loading..', bool dismiss = true}) {
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
      barrierDismissible: dismiss,
    );
  }

  static exitPrompt() {
    Get.dialog(
      AlertDialog(
        content: Text(
          'Keluar dari aplikasi ?',
          style: Get.textTheme.bodyText1,
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Batal'),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: const Text('Keluar'),
            onPressed: () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
          ),
        ],
      ),
    );
  }

  static prompt(String message, {required Function onOk}) {
    Get.dialog(
      AlertDialog(
        content: Text(
          message,
          style: Get.textTheme.bodyText1,
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Batal'),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: const Text('Lanjutkan'),
            onPressed: () {
              onOk();
            },
          ),
        ],
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
