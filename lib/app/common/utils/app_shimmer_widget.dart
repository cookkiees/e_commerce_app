import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmerWidget extends StatelessWidget {
  const AppShimmerWidget({
    super.key,
    this.height,
    this.width,
    required this.radius,
  });

  final double? height;
  final double? width;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.white,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 0),
          color: Colors.grey,
        ),
      ),
    );
  }
}
