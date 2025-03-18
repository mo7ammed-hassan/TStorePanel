import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/images_strings.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/media/cubits/media/media_cubit.dart';
import 'package:t_store_admin_panel/features/media/presentation/widget/drag_and_drop_area/drag_and_drop_area.dart';

class BuildDragAndDropArea extends StatelessWidget {
  const BuildDragAndDropArea({super.key});

  @override
  Widget build(BuildContext context) {
    return const RoundedContainer(
      height: 250,
      width: double.infinity,
      showBorder: true,
      backgroundColor: AppColors.primaryBackground,
      padding: EdgeInsets.all(AppSizes.defaultSpace),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                if (kIsWeb) WebDropzone(),
                // if (_isDesktop && !kIsWeb) const DesktopDropTarget(),
                if (!kIsWeb) MobileDropTarget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // bool get _isDesktop =>
  //     (defaultTargetPlatform == TargetPlatform.windows ||
  //         defaultTargetPlatform == TargetPlatform.linux ||
  //         defaultTargetPlatform == TargetPlatform.macOS);
}

class WebDropzone extends StatelessWidget {
  const WebDropzone({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaCubit = context.read<MediaCubit>();
    return Stack(
      alignment: Alignment.center,
      children: [
        DropzoneView(
          mime: const ['image/jpeg', 'image/png'],
          cursor: CursorType.Default,
          operation: DragOperation.copy,
          onLoaded: () => debugPrint('Zone loaded'),
          onError: (ev) => debugPrint('Zone error'),
          onHover: () => debugPrint('Zone hovered'),
          onLeave: () => debugPrint('Zone left'),
          onCreated: (ctrl) => mediaCubit.dropzoneController = ctrl,
          onDropInvalid: (ev) => debugPrint('Invalid file'),
          onDropFiles: (ev) => debugPrint('$ev files dropped'),
          onDropFile: (file) => mediaCubit.dragDropImages(file: file),
        ),
        const DragDropArea(),
      ],
    );
  }
}

// class DesktopDropTarget extends StatelessWidget {
//   const DesktopDropTarget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final mediaCubit =
//         context.read<MediaCubit>(); // to prevent creation when rebuilding
//     return DropTarget(
//       enable: _isDesktop,
//       onDragDone:
//           (details) => mediaCubit.dragDropImagesDisktop(files: details.files),
//       child: const SizedBox(
//         width: double.infinity,
//         height: double.infinity,
//         child: Center(child: DragDropArea()),
//       ),
//     );
//   }

//   bool get _isDesktop =>
//       (defaultTargetPlatform == TargetPlatform.windows ||
//           defaultTargetPlatform == TargetPlatform.linux ||
//           defaultTargetPlatform == TargetPlatform.macOS);
// }

class MobileDropTarget extends StatelessWidget {
  const MobileDropTarget({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaCubit = context.read<MediaCubit>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(TImages.appleLogo, width: 50, height: 50),
        const SizedBox(height: AppSizes.spaceBtwItems),
        const Text('Drop Images here'),
        const SizedBox(height: AppSizes.spaceBtwItems),
        OutlinedButton(
          onPressed: () async => await mediaCubit.selectLocalImages(),
          child: const Text('Select Images'),
        ),
      ],
    );
  }
}
