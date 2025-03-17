import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/helper_functions.dart';
import '../../../utils/utils/constants/sizes.dart';

class RoundedImage extends StatelessWidget {
  final String imageUrl;
  final double? width, height;
  final double borderRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit fit;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final bool aplayImageRaduis, isNetworkImage;
  final bool showShadow;

  const RoundedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.borderRadius = AppSizes.md,
    this.border,
    this.backgroundColor,
    this.fit = BoxFit.contain,
    this.padding,
    this.onTap,
    this.aplayImageRaduis = true,
    this.isNetworkImage = false,
    this.showShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: isDark ? const Color.fromARGB(59, 0, 0, 0) : backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            if (showShadow)
              BoxShadow(
                color: AppColors.grey.withValues(alpha: 0.1),
                spreadRadius: 5,
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius:
              aplayImageRaduis
                  ? BorderRadius.circular(borderRadius)
                  : BorderRadius.zero,
          child: Image(
            image:
                isNetworkImage ? NetworkImage(imageUrl) : AssetImage(imageUrl),
            fit: fit,
          ),
        ),
      ),
    );
  }
}
