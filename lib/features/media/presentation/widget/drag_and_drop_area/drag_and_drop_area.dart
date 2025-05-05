import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/utils/constants/images.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/media/cubits/media/media_cubit.dart';

class DragDropArea extends StatelessWidget {
  const DragDropArea({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaCubit = context.read<MediaCubit>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(AppImages.defaultProductImage, width: 50, height: 50),
        const SizedBox(height: AppSizes.spaceBtwItems),
        const Text('Drag and Drop Images here'),
        const SizedBox(height: AppSizes.spaceBtwItems),
        OutlinedButton(
          onPressed: () async => await mediaCubit.selectLocalImages(),
          child: const Text('Select Images'),
        ),
      ],
    );
  }
}
