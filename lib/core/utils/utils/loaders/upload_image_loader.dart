import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/images_strings.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/helper_functions.dart';

class ImageLoader {
  ImageLoader._();

  static void uploadImagesLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => PopScope(
            canPop: false,
            child: AlertDialog(
              backgroundColor:
                  HelperFunctions.isDarkMode(context)
                      ? AppColors.dark
                      : AppColors.white,
              title: Text(
                'Uploading Images',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Lottie.asset(
                      TImages.cloudUploading,
                      width: 300,
                      height: 300,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),
                  Text(
                    'Sit Tight, Your Images are Uploading...',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
