import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/media/cubits/media/media_cubit.dart';
import 'package:t_store_admin_panel/features/media/presentation/widget/media_content/media_content_section.dart';
import 'package:t_store_admin_panel/features/media/presentation/widget/media_uploader/media_uploader_section.dart';

void showMediaButtomSheet(BuildContext context) {
  showBottomSheet(
    backgroundColor: AppColors.primaryBackground,
    context: context,
    builder: (context) {
      return BlocProvider.value(
        value: getIt<MediaCubit>(),
        child: const FractionallySizedBox(
          heightFactor: 1, // that mean take all screen height
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(AppSizes.defaultSpace),
              child: Column(
                children: [
                  // Media Uploader Section
                  MediaUploaderSection(showUploderSection: true),

                  // Media Content Section
                  MediaContentSection(
                    allowMultiSelection: true,
                    //selectedImagesUrls: [],
                    allowSelection: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
