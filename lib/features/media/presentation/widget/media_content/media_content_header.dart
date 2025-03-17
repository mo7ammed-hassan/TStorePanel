import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/media/presentation/widget/media_folder_dropdown.dart';

class MediaContentHeader extends StatelessWidget {
  const MediaContentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
        const SizedBox(width: AppSizes.spaceBtwItems),
        const Flexible(child: FittedBox(child: MediaFolderDropdown())),
      ],
    );
  }
}
