import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/data/models/image/image_model.dart';
import 'package:t_store_admin_panel/features/media/presentation/widget/media_content/content_image_preview.dart';
import 'package:t_store_admin_panel/features/media/presentation/widget/media_content/media_content_header.dart';

class MediaContentSection extends StatelessWidget {
  const MediaContentSection({
    super.key,
    this.allowSelection = false,
    this.allowMultiSelection = false,
    this.selectedImages = const [],
    this.onSelectedImages,
    this.selectedImagesUrls = const [],
  });

  final bool allowSelection;
  final bool allowMultiSelection;
  final List<String> selectedImagesUrls;
  final List<ImageModel> selectedImages;
  final Function(List<ImageModel>)? onSelectedImages;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Media Images Header
          MediaContentHeader(
            allowSelection: allowSelection,
            selectedImages: selectedImages,
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),

          /// Show Media
          ContentImagePreview(
            allowMultiSelection: allowMultiSelection,
            allowSelection: allowSelection,
          ),
        ],
      ),
    );
  }
}
