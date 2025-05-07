import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/shared/widgets/breadcrumb/breadcrumb_with_heading.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/create_product/responsive_screens/widgets/product_attributes.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/create_product/responsive_screens/widgets/product_brands.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/create_product/responsive_screens/widgets/product_categories.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/create_product/responsive_screens/widgets/product_images.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/create_product/responsive_screens/widgets/product_stock_and_price.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/create_product/responsive_screens/widgets/product_thumbnail_image.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/create_product/responsive_screens/widgets/product_title_and_description.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/create_product/responsive_screens/widgets/product_type_widget.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/create_product/responsive_screens/widgets/product_variations.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/create_product/responsive_screens/widgets/product_visibility_widget.dart';
import 'package:t_store_admin_panel/features/products/presentation/widgets/product_bottom_navigation_buttons.dart';

class CreateProductDesktopScreen extends StatelessWidget {
  const CreateProductDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const ProductBottomNavigationButtons(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumb
              const BreadcrumbWithHeading(
                returnToPreviousScreen: true,
                heading: 'Create Product',
                breadcrumbs: [Routes.products, 'Create Product'],
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: DeviceUtilities.isTabletScreen(context) ? 2 : 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ProductTitleAndDescription(),
                        const SizedBox(height: AppSizes.spaceBtwSections),

                        // stock and price
                        RoundedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Stock & Price',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: AppSizes.spaceBtwItems),

                              // product type
                              const ProductTypeWidget(),
                              const SizedBox(
                                height: AppSizes.spaceBtwInputFields,
                              ),

                              // Stock
                              const ProductStockAndPricing(),
                              const SizedBox(height: AppSizes.spaceBtwSections),

                              // Attributes
                              const ProductAttributes(),
                              const SizedBox(height: AppSizes.spaceBtwSections),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSizes.spaceBtwSections),

                        const RoundedContainer(child: ProductVariations()),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSizes.defaultSpace),
                  const Expanded(
                    child: Column(
                      // Product Thumbnail
                      children: [
                        ProductThumbnailImage(),
                        SizedBox(height: AppSizes.spaceBtwSections),

                        // Product Images
                        ProductImages(),
                        SizedBox(height: AppSizes.spaceBtwSections),

                        // Product Brands
                        ProductBrands(),
                        SizedBox(height: AppSizes.spaceBtwSections),

                        // Product Categories
                        ProductCategories(),
                        SizedBox(height: AppSizes.spaceBtwSections),

                        // Product Visibility
                        ProductVisibilityWidget(),
                        SizedBox(height: AppSizes.spaceBtwSections),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
