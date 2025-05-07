import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/media/cubits/media/media_cubit.dart';
import 'package:t_store_admin_panel/features/media/presentation/widget/media_folder_dropdown.dart';
import 'package:t_store_admin_panel/features/media/presentation/widget/upload_button.dart';

class FolderSelectionRow extends StatelessWidget {
  const FolderSelectionRow({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaCubit = context.read<MediaCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
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
        Row(
          children: [
            TextButton(
              onPressed: mediaCubit.removeAllSelectedImages,
              child: const FittedBox(child: Text('Remove All')),
            ),
            if (!DeviceUtilities.isMobileScreen(context))
              const SizedBox(width: AppSizes.spaceBtwItems),
            if (!DeviceUtilities.isMobileScreen(context))
              UploadButton(
                onPressed: () => mediaCubit.uploadImagesConfirmation(),
              ),
          ],
        ),
      ],
    );
  }
}
