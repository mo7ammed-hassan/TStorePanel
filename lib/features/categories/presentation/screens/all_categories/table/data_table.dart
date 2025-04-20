import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/images_strings.dart';
import 'package:t_store_admin_panel/core/utils/utils/loaders/animation_loader.dart';
import 'package:t_store_admin_panel/data/abstract/cubit/base_data_table_states.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';
import 'package:t_store_admin_panel/features/categories/cubits/category/category_cubit.dart';
import 'package:t_store_admin_panel/features/categories/presentation/screens/all_categories/table/table_source.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/tables/custom_paginated_table.dart';

class CategoryDataTable extends StatelessWidget {
  const CategoryDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, BaseDataTableStates>(
      builder: (context, state) {
        if (state is DataTableLoadingState ||
            (state is DataTableLoadedState && state.data.isEmpty)) {
          return _buildLoaderOrEmptyWidget();
        }

        if (state is DataTableFailureState) {
          return _failureWidget(state.message);
        }

        return CustomPaginatedTable(
          minWidth: 700,
          tableheight: DeviceUtility.isDesktopScreen(context) ? 760 : 600,
          sortAscending: context.select(
            (CategoryCubit category) => category.sortAscending,
          ),
          sortColumnIndex: context.select(
            (CategoryCubit category) => category.sortColumnIndex,
          ),
          columns: [
            DataColumn2(
              label: const Text('Category'),
              onSort:
                  (columnIndex, ascending) => context
                      .read<CategoryCubit>()
                      .sortByColumn(columnIndex, ascending),
            ),
            DataColumn2(
              label: const Text('Parent Category'),
              onSort:
                  (columnIndex, ascending) => context
                      .read<CategoryCubit>()
                      .sortByColumn(columnIndex, ascending),
            ),
            const DataColumn2(label: Text('Featured'), fixedWidth: 100),
            const DataColumn2(label: Text('Date')),
            const DataColumn2(label: Text('Action'), fixedWidth: 100),
          ],
          source: CategoryRows(
            state is DataTableLoadedState
                ? (state.data as List<CategoryModel>)
                : [],
            context.read<CategoryCubit>(),
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
        text: 'Try adding some categories.',
        animation: TImages.packaging,
      ),
    );
  }

  Widget _failureWidget(String? error) {
    return  Center(child: Text( error ?? 'Something went wrong!, Try again.'));
  }
}
