import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/app_context.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/helper_functions.dart';
import 'package:t_store_admin_panel/core/utils/utils/loaders/upload_image_loader.dart';
import 'package:t_store_admin_panel/core/utils/utils/popups/loaders.dart';
import 'package:t_store_admin_panel/features/authentiacation/presentation/cubit/user/cubit/user_cubit.dart';
import 'package:t_store_admin_panel/features/media/cubits/media/media_cubit.dart';
import 'package:t_store_admin_panel/features/media/presentation/widget/drag_and_drop_area/build_drag_and_drop_area.dart';
import 'package:t_store_admin_panel/features/media/presentation/widget/media_uploader/selected_image_section/selected_images_section.dart';

class BuildMediaUploader extends StatelessWidget {
  const BuildMediaUploader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MediaCubit, MediaState>(
      listenWhen:
          (previous, current) =>
              current is UploadedImagesSuccessState ||
              current is UploadImagesFailureState ||
              current is UploadedImagesLoadingState,
      listener: (context, state) => _handleStateChange(context, state),
      child: const Column(
        children: [
          BuildDragAndDropArea(),
          SizedBox(height: AppSizes.spaceBtwItems),
          SelectedImagesSection(),
          SizedBox(height: AppSizes.spaceBtwSections),
        ],
      ),
    );
  }

  void _handleStateChange(BuildContext context, MediaState state) {
    if (state is UploadedImagesLoadingState) {
      ImageLoader.uploadImagesLoader(AppContext.context);
    } else if (state is UploadedImagesSuccessState) {
      Loaders.successSnackBar(title: state.title, message: state.message);
    } else if (state is UploadImagesFailureState) {
      Loaders.warningSnackBar(
        title: state.errorModel.title ?? '',
        message:
            state.errorModel.message ??
            'Something went wrong while uploading images.',
      );
      _showApologyDialog(context, context.read<MediaCubit>());
    }
  }

  Future<void> _showApologyDialog(
    BuildContext context,
    MediaCubit mediaCubit,
  ) async {
    await Future.delayed(const Duration(seconds: 3));
    if (!context.mounted) return;
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor:
                HelperFunctions.isDarkMode(context)
                    ? AppColors.dark
                    : AppColors.white,
            title: Text(
              '${getIt<UserCubit>().userData.fullName} !!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            // content: const Text(
            //   'This feature is under development because storage is not available yet.\nThanks for your patience. 😊',
            // ),
            content: Text(
              'This Images did not upload successfully ${mediaCubit.selectedImagesToUpload.map((x) => x.fileName)}.\nPlease try again. 🫤',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Ok'),
              ),
            ],
          ),
    );
  }
}
