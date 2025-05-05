import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';

/// A circular container widget with customizable properties
class CircularContainer extends StatelessWidget {
  /// Constructs a [CircularContainer]
  ///
  /// properties:
  /// * [width] - The width of the circular container
  /// * [height] - The height of the circular container
  /// * [raduis] - The radius of the circular container
  /// * [backgroundColor] - The background color of the circular container
  /// * [child] - The child widget to be displayed inside the circular container
  /// * [showBorder] - Whether to show a border around the circular container
  /// * [borderColor] - The color of the border
  /// * [margin] - The margin around the circular container
  /// * [padding] - The padding inside the circular container
  const CircularContainer({
    super.key,
    this.width = 400,
    this.height = 400,
    this.raduis = 400,
    this.backgroundColor = AppColors.white,
    this.child,
    this.showBorder = false,
    this.borderColor = AppColors.borderPrimary,
    this.margin,
    this.padding,
  });

  final double? width, height;
  final double raduis;
  final Color backgroundColor;
  final Widget? child;
  final bool showBorder;
  final Color borderColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(raduis),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),

      child: child,
    );
  }
}
