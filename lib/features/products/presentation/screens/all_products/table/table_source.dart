import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/shared/widgets/data_table/table_action.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/t_rounded_image.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/constants/images.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/helpers/app_context.dart';
import 'package:t_store_admin_panel/core/utils/helpers/navigation.dart';
import 'package:t_store_admin_panel/data/models/product/product_model.dart';
import 'package:t_store_admin_panel/features/products/cubits/cubit/product_cubit.dart';

class ProductRows extends DataTableSource {
  final List<ProductModel> products;
  final ProductCubit cubit;

  ProductRows(this.products, this.cubit);

  @override
  DataRow2? getRow(int index) {
    final product = products[index];
    return DataRow2(
      cells: [
        DataCell(
          Row(
            children: [
              TRoundedImage(
                image: product.thumbnail ?? AppImages.productImage1,
                width: 50,
                height: 50,
                imageType:
                    product.thumbnail != null
                        ? ImageType.network
                        : ImageType.asset,
                borderRadius: AppSizes.borderRadiusMd,
                backgroundColor: AppColors.primaryBackground,
              ),
              const SizedBox(width: AppSizes.spaceBtwItems),
              Flexible(
                child: Text(
                  product.title,
                  style: Theme.of(
                    AppContext.context,
                  ).textTheme.bodyLarge!.apply(color: AppColors.primary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DataCell(Text(product.stock.toString())),
        DataCell(
          Row(
            children: [
              TRoundedImage(
                image: product.brand?.image ?? AppImages.adidasLogo,
                width: 35,
                height: 35,
                imageType:
                    product.brand?.image != null
                        ? ImageType.network
                        : ImageType.asset,
                borderRadius: AppSizes.borderRadiusMd,
                backgroundColor: AppColors.primaryBackground,
              ),
              const SizedBox(width: AppSizes.spaceBtwItems),
              Flexible(
                child: Text(
                  product.brand?.name ?? '',
                  style: Theme.of(
                    AppContext.context,
                  ).textTheme.bodyLarge!.apply(color: AppColors.primary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DataCell(Text(product.calculateProductPrice(product))),
        DataCell(Text(product.formattedCreatedAt ?? '')),
        DataCell(
          TTableActionButtons(
            onEditPressed:
                () => AppContext.context.pushNamedPage(
                  Routes.editProduct,
                  arguments: product,
                ),
            onDeletePressed: () => cubit.confirmDeleteDialog(product),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => cubit.allProducts.length;

  @override
  int get selectedRowCount => cubit.selectedRows.length;
}
