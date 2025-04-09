// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/helper_functions.dart';

/// A Container with rounded corners and custmizable properties
class RoundedContainer extends StatelessWidget {
  /// Creates a RoundedContainer widget with customizable properties.
  ///
  /// Parameters:
  /// - child: The widget to be displayed inside the container.
  /// - width: The width of the container.
  /// - height: The height of the container.
  /// - margin: The margin around the container.
  /// - padding: The padding inside the container.
  /// - raduis: The radius of the corners.
  /// - borderColor: The color of the border.
  /// - showShadow: Whether to show a shadow around the container.
  /// - showBorder: Whether to show a border around the container.
  /// - backgroundColor: The background color of the container.
  /// - onTap: The callback function to be called when the container is tapped.
  const RoundedContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.margin,
    this.showShadow = true,
    this.showBorder = false,
    this.padding = const EdgeInsets.all(AppSizes.md),
    this.borderColor = AppColors.borderPrimary,
    this.raduis = AppSizes.cardRadiusLg,
    this.backgroundColor,
    this.onTap,
  });

  final Widget? child;
  final double? width, height;
  final EdgeInsets? margin, padding;
  final double raduis;
  final Color borderColor;
  final bool showShadow;
  final bool showBorder;
  final Color? backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color:
              backgroundColor ?? (isDark ? AppColors.black : AppColors.white),
          borderRadius: BorderRadius.circular(raduis),
          border:
              showBorder
                  ? Border.all(
                    color: isDark ? AppColors.darkerGrey : borderColor,
                  )
                  : null,
          boxShadow: [
            if (showShadow)
              BoxShadow(
                color:
                    isDark
                        ? AppColors.darkerGrey.withValues(alpha: 0.1)
                        : AppColors.grey.withValues(alpha: 0.1),
                spreadRadius: isDark ? 1 : 5,
                blurRadius: isDark ? 3 : 8,
                offset: isDark ? const Offset(0, 0) : const Offset(0, 3),
              ),
          ],
        ),
        child: child,
      ),
    );
  }
}
