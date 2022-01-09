import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({
    Key? key,
    this.width = double.infinity,
    this.height = double.infinity,
    this.radius = 10,
  }) : super(key: key);

  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Shimmer.fromColors(
        period: const Duration(
          milliseconds: 700,
        ),
        baseColor: Colors.grey[200]!,
        highlightColor: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    );
  }
}
