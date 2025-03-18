import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/shared/bottom_sheets/media_buttom_sheet.dart';
import 'package:t_store_admin_panel/core/shared/widgets/breadcrumb/breadcrumb_with_heading.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/media/cubits/actions/media_action_cubit.dart';

class MediaScreenHeader extends StatelessWidget {
  const MediaScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Breadcrumbs
        const BreadcrumbWithHeading(
          heading: 'Media',
          breadcrumbs: ['Media Screen'],
          // returnToPreviousScreen: true,
        ),
        // Actions
        Flexible(
          child: SizedBox(
            width: AppSizes.buttonWidth * 1.5,
            child: ElevatedButton.icon(
              onPressed:
                  () =>
                      context
                          .read<MediaActionCubit>()
                          .toggleMediaUploaderSection(),
              icon: const FittedBox(
                // OR Flexible
                child: Icon(Iconsax.cloud_add, color: AppColors.white),
              ),
              label: const FittedBox(child: Text('Upload Images')),
            ),
          ),
        ),

        SizedBox(
          width: AppSizes.buttonWidth * 1.5,
          child: ElevatedButton(
            onPressed: () => showMediaButtomSheet(context),
            child: const Text('Show Media Sheet'),
          ),
        ),
      ],
    );
  }
}
