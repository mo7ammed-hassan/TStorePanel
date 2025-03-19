import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/circular_image.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/t_rounded_image.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/enums.dart';

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

  final void Function()? onIconButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        circular
            ? TCircularImage(
              image: image!,
              width: width,
              height: height,
              isNetworkImage: imageType == ImageType.network,
            )
            : TRoundedImage(
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
            decoration: const BoxDecoration(
              color: AppColors.buttonPrimary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(icon),
              onPressed: onIconButtonPressed,
              color: AppColors.white,
              iconSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
