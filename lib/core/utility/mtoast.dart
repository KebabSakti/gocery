import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MToast {
  static show(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black54,
      fontSize: 16.0,
    );
  }

  static close() {
    Fluttertoast.cancel();
  }
}
