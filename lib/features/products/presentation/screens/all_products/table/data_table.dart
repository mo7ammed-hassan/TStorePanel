import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/constants/images.dart';
import 'package:t_store_admin_panel/core/utils/loaders/animation_loader.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/tables/custom_paginated_table.dart';
import 'package:t_store_admin_panel/features/products/cubits/cubit/product_cubit.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/all_products/table/table_source.dart';

class ProductDataTable extends StatelessWidget {
  const ProductDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductCubit>();
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductsLoadingState ||
            (state is ProductsLoadedState && state.products.isEmpty)) {
          return _buildLoaderOrEmptyWidget();
        }

        if (state is ProductErrorState) {
          return _failureWidget(state.message);
        }

        return CustomPaginatedTable(
          tableheight: DeviceUtility.isDesktopScreen(context) ? 760 : 600,
          columns: [
            DataColumn2(
              label: const Text('product'),
              fixedWidth: !DeviceUtility.isDesktopScreen(context) ? 300 : 400,
            ),
            const DataColumn2(label: Text('Stock')),
            const DataColumn2(label: Text('Brand')),
            const DataColumn2(label: Text('Price')),
            const DataColumn2(label: Text('Date')),
            const DataColumn2(label: Text('Action'), fixedWidth: 100),
          ],
          source: ProductRows(cubit.allProducts, cubit),
        );
      },
    );
  }

  Widget _buildLoaderOrEmptyWidget() {
    return const SizedBox(
      height: 700,
      child: TAnimationLoaderWidget(
        width: 300,
        height: 300,
        text: 'Try adding some categories.',
        animation: AppImages.packaging,
      ),
    );
  }

  Widget _failureWidget(String? error) {
    return Center(child: Text(error ?? 'Something went wrong!, Try again.'));
  }
}
