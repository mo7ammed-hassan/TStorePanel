import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/constants/images.dart';
import 'package:t_store_admin_panel/core/utils/loaders/animation_loader.dart';
import 'package:t_store_admin_panel/data/abstract/cubit/base_data_table_states.dart';
import 'package:t_store_admin_panel/data/models/brands/brand_model.dart';
import 'package:t_store_admin_panel/features/brands/presentation/cubits/brand_cubit.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/all_brands/table/table_scource.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/tables/custom_paginated_table.dart';

class BrandDataTable extends StatelessWidget {
  const BrandDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandCubit, BaseDataTableStates>(
      builder: (context, state) {
        if (state is DataTableLoadingState ||
            (state is DataTableLoadedState && state.data.isEmpty)) {
          return _buildLoaderOrEmptyWidget();
        }

        final lgTable = context.read<BrandCubit>().filteredItems.any(
          (element) =>
              element.brandCategories != null &&
              element.brandCategories!.length > 2,
        );

        return CustomPaginatedTable(
          minWidth: 700,
          dataRowHeight: lgTable ? 96 : 64,

          tableheight:
              // lgTable
              //     ? 96 * 11.5:
              DeviceUtilities.isDesktopScreen(context) ? 760 : 600,
          sortAscending: context.select(
            (BrandCubit brand) => brand.sortAscending,
          ),
          sortColumnIndex: context.select(
            (BrandCubit brand) => brand.sortColumnIndex,
          ),

          columns: [
            DataColumn2(
              label: const Text('Brand'),
              fixedWidth: DeviceUtilities.isMobileScreen(context) ? null : 200,
              onSort:
                  (columnIndex, ascending) => context
                      .read<BrandCubit>()
                      .sortByColumn(columnIndex, ascending),
            ),
            const DataColumn2(label: Text('Categories')),
            const DataColumn2(label: Text('Featured'), fixedWidth: 100),
            DataColumn2(
              label: const Text('Date'),
              fixedWidth: DeviceUtilities.isMobileScreen(context) ? null : 200,
            ),
            DataColumn2(
              label: const Text('Action'),
              fixedWidth: DeviceUtilities.isMobileScreen(context) ? 100 : 100,
            ),
          ],
          source: BrandRows(
            state is DataTableLoadedState
                ? (state.data as List<BrandModel>)
                : context.read<BrandCubit>().allItems,
            context.read<BrandCubit>(),
          ),
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
        text: 'Try adding some brands.',
        animation: AppImages.packaging,
      ),
    );
  }
}
