import 'package:flutter/material.dart';
import 'package:gocery/core/config/app_const.dart';

class IconLabel extends StatelessWidget {
  const IconLabel({Key? key, required this.label}) : super(key: key);

  final int label;

  @override
  Widget build(BuildContext context) {
    return (label == 0)
        ? const SizedBox.shrink()
        : ClipOval(
            child: Container(
              width: 15,
              height: 15,
              color: Colors.redAccent,
              child: Center(
                  child: Text(
                '$label',
                style: const TextStyle(
                  color: kLightColor,
                  fontSize: 7,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
          );
  }
}
