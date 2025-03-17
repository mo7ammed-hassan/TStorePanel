import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/t_rounded_image.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/media/cubits/media/media_cubit.dart';
import 'package:t_store_admin_panel/features/media/presentation/widget/media_uploader/selected_image_section/folder_selection_row.dart';
import 'package:t_store_admin_panel/features/media/presentation/widget/upload_button.dart';

class SelectedImagesSection extends StatelessWidget {
  const SelectedImagesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaCubit = context.read<MediaCubit>();
    return BlocBuilder<MediaCubit, MediaState>(
      buildWhen:
          (previous, current) =>
              current is SelectedImagesLoadedState ||
              current is SelectedImagesFailedState,
      builder: (context, state) {
        if (mediaCubit.selectedImagesToUpload.isEmpty) {
          return const SizedBox.shrink();
        }
        return RoundedContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FolderSelectionRow(),
              const SizedBox(height: AppSizes.spaceBtwSections),
              _buildImagePreview(mediaCubit),
              const SizedBox(height: AppSizes.spaceBtwSections),
              if (DeviceUtility.isMobileScreen(context))
                SizedBox(
                  width: double.infinity,
                  child: UploadButton(
                    onPressed: () => mediaCubit.uploadImagesConfirmation(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Wrap _buildImagePreview(MediaCubit mediaCubit) {
    return Wrap(
      spacing: AppSizes.spaceBtwItems / 2,
      runSpacing: AppSizes.spaceBtwItems / 2,
      children:
          mediaCubit.selectedImagesToUpload
              .where((image) => image.localImageToDisplay != null)
              .map(
                (image) => TRoundedImage(
                  width: 80,
                  height: 80,
                  imageType: ImageType.memory,
                  memoryImage: image.localImageToDisplay,
                  backgroundColor: AppColors.primaryBackground,
                ),
              )
              .toList(),
    );
  }
}
