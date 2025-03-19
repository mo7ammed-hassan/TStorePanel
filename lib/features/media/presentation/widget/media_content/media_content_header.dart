import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/navigation.dart';
import 'package:t_store_admin_panel/data/models/image/image_model.dart';
import 'package:t_store_admin_panel/features/media/cubits/actions/media_action_cubit.dart';
import 'package:t_store_admin_panel/features/media/presentation/widget/media_folder_dropdown.dart';

class MediaContentHeader extends StatelessWidget {
  const MediaContentHeader({
    super.key,
    required this.allowSelection,
    required this.selectedImages,
  });
  final bool allowSelection;
  final List<ImageModel> selectedImages;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Folder Selection
        Flexible(
          child: Row(
            mainAxisAlignment:
                DeviceUtility.isMobileScreen(context)
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.start,
            children: [
              // Folders Dropdown
              Flexible(
                child: FittedBox(
                  child: Text(
                    'Selected Folder',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.sm),
              const Flexible(child: FittedBox(child: MediaFolderDropdown())),
            ],
          ),
        ),

        const SizedBox(width: AppSizes.spaceBtwSections),

        // Add and Close btns
        if (allowSelection)
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: FittedBox(
                    child: SizedBox(
                      width: 120,
                      child: OutlinedButton.icon(
                        onPressed: () => context.popPage(context),
                        style: ButtonStyle(
                          maximumSize: WidgetStateProperty.all<Size>(
                            const Size.fromWidth(120),
                          ),
                        ),

                        icon: const Icon(Iconsax.close_circle),
                        label: const Text('Close'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.sm),
                Flexible(
                  child: FittedBox(
                    child: SizedBox(
                      width: 120,
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.pop(context, getIt<MediaActionCubit>().selectedImages),
                        icon: const Icon(Iconsax.image),
                        label: const Text('Add'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
