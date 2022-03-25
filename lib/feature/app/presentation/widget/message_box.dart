import 'package:flutter/material.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';

class MessageBox extends StatelessWidget {
  const MessageBox(this.message, {Key? key}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kMediumPadding),
      decoration: BoxDecoration(
        color: kPrimaryColor100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            AppIcon.infocircle,
            color: Colors.amber,
          ),
          const SizedBox(width: kSmallPadding),
          Expanded(
            child: Text(message),
          ),
        ],
      ),
    );
  }
}
