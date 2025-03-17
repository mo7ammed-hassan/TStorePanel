// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:t_store_admin_panel/core/shared/widgets/images/t_rounded_image.dart';
// import 'package:t_store_admin_panel/core/utils/utils/constants/colors.dart';
// import 'package:t_store_admin_panel/core/utils/utils/constants/enums.dart';
// import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
// import 'package:t_store_admin_panel/features/media/cubits/media/media_cubit.dart';

// class ImagePreview extends StatelessWidget {
//   const ImagePreview({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final mediaCubit = context.read<MediaCubit>();
//     return BlocBuilder<MediaCubit, MediaState>(
//       buildWhen:
//           (previous, current) =>
//               current is SelectedImagesLoadedState ||
//               current is SelectedImagesFailedState,
//       builder: (context, state) {
//         return Wrap(
//           spacing: AppSizes.spaceBtwItems / 2,
//           runSpacing: AppSizes.spaceBtwItems / 2,
//           children:
//               mediaCubit.selectedImagesToUpload
//                   .where((image) => image.localImageToDisplay != null)
//                   .map(
//                     (image) => TRoundedImage(
//                       width: 80,
//                       height: 80,
//                       imageType: ImageType.memory,
//                       memoryImage: image.localImageToDisplay,
//                       backgroundColor: AppColors.primaryBackground,
//                     ),
//                   )
//                   .toList(),
//         );
//       },
//     );
//   }
// }
