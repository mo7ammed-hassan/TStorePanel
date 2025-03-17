import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/features/media/cubits/actions/media_action_cubit.dart';
import 'package:t_store_admin_panel/features/media/presentation/widget/media_uploader/build_media_uploader.dart';

/// Media Uploader Section
/// This widget is used to toggle the media uploader section
/// Depends on [MediaActionCubit] if showMediaUploaderSection is true then show the media uploader
class MediaUploaderSection extends StatelessWidget {
  const MediaUploaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MediaActionCubit, MediaActionState, bool>(
      selector: (state) {
        return state is ToggleMediaUploaderSection
            ? state.showMediaUploaderSection
            : context.read<MediaActionCubit>().showMediaUploaderSection;
      },
      builder: (context, showUploader) {
        if (!showUploader) return const SizedBox.shrink();

        return const BuildMediaUploader();
      },
    );
  }
}
