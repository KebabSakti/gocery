import 'package:flutter/material.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';

class SmallRefreshButton extends StatelessWidget {
  const SmallRefreshButton({
    Key? key,
    this.label = 'Muat Ulang',
    required this.onTap,
  }) : super(key: key);

  final String label;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [
          const Icon(AppIcon.refreshleft, size: 14, color: kPrimaryColor),
          const SizedBox(width: 2),
          Text(
            label,
            style: const TextStyle(fontSize: kSmallFont, color: kPrimaryColor),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
