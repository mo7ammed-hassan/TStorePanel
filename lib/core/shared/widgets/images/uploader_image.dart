import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/circular_image.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/t_rounded_image.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';

class UploaderImage extends StatelessWidget {
  const UploaderImage({
    super.key,
    this.circular = false,
    this.image,
    required this.imageType,
    this.width = 100,
    this.height = 100,
    this.memoryImage,
    this.icon = Iconsax.edit_2,
    this.top,
    this.left = 0,
    this.right,
    this.bottom = 0,
    this.onIconButtonPressed,
    this.fit = BoxFit.cover,
  });

  final bool circular;

  final String? image;

  final ImageType imageType;

  final double width;

  final double height;

  final Uint8List? memoryImage;

  final IconData icon;

  final double? top;

  final double? left;

  final double? right;

  final double? bottom;
  final BoxFit fit;

  final void Function()? onIconButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        circular
            ? CircularImage(
              fit: fit,
              image: image!,
              width: width,
              height: height,
              isNetworkImage: imageType == ImageType.network,
              backgroundColor: AppColors.primaryBackground,
            )
            : TRoundedImage(
              fit: fit,
              width: width,
              height: height,
              imageType: imageType,
              memoryImage: memoryImage,
              image: image!,
              backgroundColor: AppColors.primaryBackground,
            ),

        Positioned(
          top: top,
          left: left,
          right: right,
          bottom: bottom,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.9),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: IconButton(
                icon: Icon(icon, color: Colors.white),
                onPressed: onIconButtonPressed,
                color: AppColors.white,
                iconSize: AppSizes.md,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
