import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/shared/widgets/shimmer/shimmer_widget.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/helper_functions.dart';

class TRoundedImage extends StatelessWidget {
  final String? image;
  final bool applyImageRaduis;
  final BoxBorder? border;
  final double borderRadius;
  final BoxFit? fit;
  final File? file;
  final ImageType imageType;
  final Color? overlayColor;
  final Color? backgroundColor;
  final Uint8List? memoryImage;
  final double width, height, padding;
  final double? margin;

  const TRoundedImage({
    super.key,
    this.image,
    this.applyImageRaduis = true,
    this.border,
    this.borderRadius = AppSizes.md,
    this.fit = BoxFit.contain,
    this.file,
    required this.imageType,
    this.overlayColor,
    this.backgroundColor,
    this.memoryImage,
    this.width = 56,
    this.height = 56,
    this.padding = AppSizes.sm,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Container(
      width: width,
      height: height,
      margin: margin != null ? EdgeInsets.all(margin!) : null,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: border,
        color: backgroundColor ?? (isDark ? AppColors.dark : Colors.white),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: FittedBox(child: _buildImageWidget()),
    );
  }

  _buildImageWidget() {
    Widget imageWidget;

    switch (imageType) {
      case ImageType.network:
        imageWidget = _buildNetworkImage();
      case ImageType.memory:
        imageWidget = _buildMemoryImage();
      case ImageType.file:
        imageWidget = _buildFileImage();
      case ImageType.asset:
        imageWidget = _buildAssetImage();
        break;
    }

    return ClipRRect(
      borderRadius:
          applyImageRaduis
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
      child: imageWidget,
    );
  }

  Widget _buildNetworkImage() {
    if (image != null && image!.isNotEmpty) {
      // Use cached network image for efficient loading and cache image // Not working for web but just for loading
      return CachedNetworkImage(
        imageUrl: image!,
        fit: fit,
        color: overlayColor,
        progressIndicatorBuilder:
            (context, url, progress) => const ShimmerWidget(
              height: 75,
              width: 75,
              shapeBorder: CircleBorder(),
            ),
        errorWidget: (context, url, error) => const Icon(Iconsax.image),
      );
    } else {
      return Container();
    }
  }

  Widget _buildMemoryImage() {
    if (memoryImage != null) {
      // Display image from memory
      return Image(
        fit: fit,
        image: MemoryImage(memoryImage!),
        color: overlayColor,
      );
    } else {
      return Container();
    }
  }

  Widget _buildFileImage() {
    if (file != null) {
      // Display image from file
      return Image(fit: fit, image: FileImage(file!), color: overlayColor);
    } else {
      return Container();
    }
  }

  Widget _buildAssetImage() {
    if (image != null && image!.isNotEmpty) {
      // Display image from asset
      return Image(fit: fit, image: AssetImage(image!), color: overlayColor);
    } else {
      return Container();
    }
  }
}
