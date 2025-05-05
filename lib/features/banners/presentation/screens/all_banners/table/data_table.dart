import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/constants/images.dart';
import 'package:t_store_admin_panel/core/utils/loaders/animation_loader.dart';
import 'package:t_store_admin_panel/data/abstract/cubit/base_data_table_states.dart';
import 'package:t_store_admin_panel/data/models/banners/banner_model.dart';
import 'package:t_store_admin_panel/features/banners/cubits/banners/banner_cubit.dart';
import 'package:t_store_admin_panel/features/banners/presentation/screens/all_banners/table/table_scource.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/tables/custom_paginated_table.dart';

class BannerDataTable extends StatelessWidget {
  const BannerDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerCubit, BaseDataTableStates>(
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
          tableheight: DeviceUtilities.isDesktopScreen(context) ? 760 : 600,
          dataRowHeight: 110,
          columns: [
            const DataColumn2(label: Text('Banner'), fixedWidth: 230),
            DataColumn2(
              label: const Text('Redirect Screen'),
              fixedWidth: DeviceUtilities.isMobileScreen(context) ? 200 : null,
            ),
            const DataColumn2(label: Text('Active'), fixedWidth: 100),
            const DataColumn2(label: Text('Action'), fixedWidth: 100),
          ],
          source: BannerRows(
            context.read<BannerCubit>(),
            banners:
                state is DataTableLoadedState
                    ? (state.data as List<BannerModel>)
                    : context.read<BannerCubit>().allItems,
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
        animation: AppImages.packaging,
      ),
    );
  }

  Widget _failureWidget(String? message) {
    return Center(child: Text(message ?? 'Something went wrong!, Try again.'));
  }
}
