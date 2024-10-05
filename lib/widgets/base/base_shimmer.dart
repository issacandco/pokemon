import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/app_size.dart';

class BaseShimmer extends StatelessWidget {
  final double width;
  final double height;
  final Color baseColor;
  final Color highlightColor;
  final Color containerColor;
  final ShapeBorder shapeBorder;

  BaseShimmer.rectangular({
    super.key,
    this.width = double.infinity,
    this.height = 16.0,
    Color? baseColor,
    Color? highlightColor,
    Color? containerColor,
    double? borderRadius,
  })  : baseColor = baseColor ?? Colors.grey[300]!,
        highlightColor = highlightColor ?? Colors.grey[100]!,
        containerColor = containerColor ?? Colors.white,
        shapeBorder = RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? AppSize.getSize(6)));

  BaseShimmer.circular({
    super.key,
    this.width = 64.0,
    this.height = 64.0,
    Color? baseColor,
    Color? highlightColor,
    Color? containerColor,
  })  : baseColor = baseColor ?? Colors.grey[300]!,
        highlightColor = highlightColor ?? Colors.grey[100]!,
        containerColor = containerColor ?? Colors.white,
        shapeBorder = const CircleBorder();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: containerColor,
          shape: shapeBorder,
        ),
      ),
    );
  }
}
