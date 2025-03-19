import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/shared/bottom_sheets/media_buttom_sheet.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/products/cubits/cubit/product_cubit.dart';

class ProductDesktopScreen extends StatelessWidget {
  const ProductDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.spaceBtwItems),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: AppSizes.buttonWidth * 1.5,
                      child: ElevatedButton(
                        onPressed: () => showMediaButtomSheet(context),
                        child: FittedBox(child: const Text('Show Media Sheet')),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSizes.spaceBtwItems),
                  Expanded(
                    child: SizedBox(
                      width: AppSizes.buttonWidth * 1.5,
                      child: ElevatedButton(
                        onPressed:
                            () =>
                                context
                                    .read<ProductCubit>()
                                    .selectThumbnailImage(),
                        child: FittedBox(child: const Text('Slect Thumbnail')),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSizes.spaceBtwItems),
                  Expanded(
                    child: SizedBox(
                      width: AppSizes.buttonWidth * 1.5,
                      child: ElevatedButton(
                        onPressed:
                            () =>
                                context
                                    .read<ProductCubit>()
                                    .selectAdditionalImage(),
                        child: FittedBox(
                          child: const Text('Select Product Images'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              Text(
                'Thumbnail',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSizes.md),
              BlocBuilder<ProductCubit, ProductState>(
                buildWhen:
                    (previous, current) => current is SelectedThumbnailImage,
                builder: (context, state) {
                  return Flexible(
                    child: SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: Image.network(
                        context
                                .read<ProductCubit>()
                                .selectedThumbnailImageUrl ??
                            '',
                        errorBuilder:
                            (context, error, stackTrace) =>
                                const Icon(Iconsax.image),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              Text(
                'Additional Images',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSizes.md),
              BlocBuilder<ProductCubit, ProductState>(
                buildWhen:
                    (previous, current) => current is SelectedAdditionalImage,
                builder: (context, state) {
                  if (state is SelectedAdditionalImage) {
                    return context
                            .read<ProductCubit>()
                            .additionalProductImagesUrls
                            .isEmpty
                        ? const Center(child: Text('No Images Selected'))
                        : Wrap(
                          spacing: AppSizes.spaceBtwItems,
                          runSpacing: AppSizes.spaceBtwItems,
                          children:
                              state.additionalProductImagesUrls
                                  .map(
                                    (e) => SizedBox(
                                      width: 150,
                                      height: 150,
                                      child: Image.network(e),
                                    ),
                                  )
                                  .toList(),
                        );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
