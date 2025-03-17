import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/helper_functions.dart';

class ShimmerWidget extends StatelessWidget {
  final double? width, height;
  final ShapeBorder shapeBorder;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double raduis;
  const ShimmerWidget({
    super.key,
    required this.width,
    required this.height,
    this.shapeBorder = const RoundedRectangleBorder(),
    this.padding,
    this.margin,
    this.raduis = 15,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[850]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      period: const Duration(milliseconds: 1550),
      child: Container(
        padding: padding,
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(raduis),
        ),
      ),
    );
  }
}

class ShimmerAvatar extends StatelessWidget {
  final double? width, height;
  final ShapeBorder shapeBorder;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double raduis;
  final ShapeBorder shape;
  const ShimmerAvatar({
    super.key,
    required this.width,
    required this.height,
    this.shapeBorder = const RoundedRectangleBorder(),
    this.padding,
    this.margin,
    this.raduis = 15,
    this.shape = const CircleBorder(),
  });
  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[850]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      period: const Duration(milliseconds: 1550),
      child: Container(
        padding: padding,
        width: width,
        height: height,
        margin: margin,
        decoration: ShapeDecoration(color: Colors.grey, shape: shape),
      ),
    );
  }
}
