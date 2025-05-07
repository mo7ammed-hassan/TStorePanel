import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/t_rounded_image.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/popups/loader_dialog.dart';
import 'package:t_store_admin_panel/core/utils/popups/loaders.dart';
import 'package:t_store_admin_panel/data/models/image/image_model.dart';
import 'package:t_store_admin_panel/features/media/cubits/media/media_cubit.dart';

class ImagePopup extends StatelessWidget {
  const ImagePopup({super.key, required this.image, required this.mediaCubit});
  final ImageModel image;
  final MediaCubit mediaCubit;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocProvider.value(
        value: mediaCubit,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
          ),
          child: RoundedContainer(
            width:
                DeviceUtilities.isDesktopScreen(context)
                    ? MediaQuery.of(context).size.width * 0.5
                    : double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Stack(
                    children: [
                      TRoundedImage(
                        imageType: ImageType.network,
                        image: image.url,
                        height: MediaQuery.of(context).size.height * 0.4,
                        width:
                            DeviceUtilities.isDesktopScreen(context)
                                ? MediaQuery.of(context).size.width * 0.5
                                : double.infinity,
                      ),
                      Positioned(
                        right: 0,
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Iconsax.close_circle),
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(),
                const SizedBox(height: AppSizes.spaceBtwItems),

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Image\nName',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        image.fileName,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Text(
                        'Image\nURL',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        image.url,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: OutlinedButton(
                        onPressed: () {
                          FlutterClipboard.copy(image.url).then(
                            (value) =>
                                Loaders.customToast(message: 'URL Copied!'),
                          );
                        },
                        child: const FittedBox(child: Text('Copy URL')),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwSections),

                BlocListener<MediaCubit, MediaState>(
                  listener: _buildDeleteListener,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 300),
                        child: FittedBox(
                          child: TextButton(
                            onPressed: () {
                              mediaCubit.deleteImageDialogConfiramtion(image);
                            },
                            child: Text(
                              'Delete Image',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.apply(color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _buildDeleteListener(context, state) {
    if (state is DeleteImageLoadingState) {
      // close image dialog
      if (context.mounted) Navigator.pop(context);

      //show loading dialog
      LoaderDialog.showLoaderDialog();
    }
    if (state is DeleteImageSuccessState) {
      // close image dialog
      if (context.mounted) Navigator.pop(context);
    }
    if (state is DeleteImageFailureState) {
      // close image dialog
      if (context.mounted) Navigator.pop(context);
    }
  }
}
