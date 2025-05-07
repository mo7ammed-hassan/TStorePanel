import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/popups/image_popup.dart';
import 'package:t_store_admin_panel/core/utils/helpers/helper_functions.dart';
import 'package:t_store_admin_panel/data/models/image/image_model.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/t_rounded_image.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/media/cubits/media/media_cubit.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({super.key, required this.image, required this.mediaCubit});

  final ImageModel image;
  final MediaCubit mediaCubit;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap:
          () => showDialog(
            context: context,
            builder:
                (BuildContext context) =>
                    ImagePopup(image: image, mediaCubit: mediaCubit),
          ),
      child: SizedBox(
        width: 140,
        height: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TRoundedImage(
              width: 140,
              height: 140,
              imageType: ImageType.network,
              backgroundColor:
                  isDark ? AppColors.darkerGrey : AppColors.primaryBackground,
              margin: AppSizes.xs,
              image: image.url,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm),
                child: Text(
                  image.fileName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
