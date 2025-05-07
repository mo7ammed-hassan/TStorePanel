import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/features/media/cubits/media/media_cubit.dart';

class MediaFolderDropdown extends StatelessWidget {
  const MediaFolderDropdown({super.key, this.onChanged});

  final void Function(MediaCategory?)? onChanged;
  @override
  Widget build(BuildContext context) {
    final mediaCubit = context.read<MediaCubit>();
    return BlocBuilder<MediaCubit, MediaState>(
      buildWhen: (previous, current) {
        return current is SelectedCategoryState;
      },
      builder: (context, state) {
        return SizedBox(
          width: 140,
          child: DropdownButtonFormField(
            value: mediaCubit.selectedPath,
            items:
                MediaCategory.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name.capitalize.toString()),
                      ),
                    )
                    .toList(),
            onChanged:
                onChanged ??
                (MediaCategory? newValue) async {
                  if (newValue != null) {
                    mediaCubit.changeCategory(newValue);
                    mediaCubit.selectedPath == MediaCategory.folders
                        ? null
                        : await mediaCubit.fetchImagesFromDatabase(10);
                  }
                },
          ),
        );
      },
    );
  }
}
