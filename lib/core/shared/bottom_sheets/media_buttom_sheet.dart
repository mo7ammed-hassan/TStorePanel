import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/helper_functions.dart';
import 'package:t_store_admin_panel/data/models/image/image_model.dart';
import 'package:t_store_admin_panel/features/media/cubits/media/media_cubit.dart';
import 'package:t_store_admin_panel/features/media/presentation/widget/media_content/media_content_section.dart';
import 'package:t_store_admin_panel/features/media/presentation/widget/media_uploader/media_uploader_section.dart';

Future<List<ImageModel>?> showMediaButtomSheet(
  BuildContext context, {
  List<String>? selectedImagesUrls,
  bool allowMultiSelection = true,
  bool allowSelection = true,
}) async {
  final isDark = HelperFunctions.isDarkMode(context);
  List<ImageModel>? selectedImages = await showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: isDark ? Colors.black : AppColors.primaryBackground,
    context: context,
    builder: (context) {
      return BlocProvider.value(
        value: getIt<MediaCubit>(),
        child: FractionallySizedBox(
          heightFactor: 1, // that mean take all screen height
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.spaceBtwItems),
              child: Column(
                children: [
                  // Media Uploader Section
                  const MediaUploaderSection(showUploderSection: true),

                  // Media Content Section
                  MediaContentSection(
                    allowMultiSelection: allowMultiSelection,
                    selectedImagesUrls: selectedImagesUrls ?? [],
                    allowSelection: allowSelection,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
  debugPrint('Bottom Sheet Result: ${selectedImages?.length}');
  return selectedImages;
}
