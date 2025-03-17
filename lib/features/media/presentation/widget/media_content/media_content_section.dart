import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/media/presentation/widget/media_content/content_image_preview.dart';
import 'package:t_store_admin_panel/features/media/presentation/widget/media_content/media_content_header.dart';

class MediaContentSection extends StatelessWidget {
  const MediaContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const RoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Media Images Header
          MediaContentHeader(),
          SizedBox(height: AppSizes.spaceBtwSections),

          /// Show Media
          ContentImagePreview(),
        ],
      ),
    );
  }
}
