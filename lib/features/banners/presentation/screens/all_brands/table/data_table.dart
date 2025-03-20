import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/features/banners/presentation/screens/all_brands/table/table_scource.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/tables/custom_paginated_table.dart';

class BrandDataTable extends StatelessWidget {
  const BrandDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaginatedTable(
      minWidth: 700,
      tableheight: DeviceUtility.isDesktopScreen(context) ? 760 : 600,
      columns: [
        DataColumn2(
          label: const Text('Brand'),
          fixedWidth: DeviceUtility.isMobileScreen(context) ? null : 200,
        ),
        DataColumn2(
          label: const Text('Categories'),
          fixedWidth: DeviceUtility.isMobileScreen(context) ? 160 : null,
        ),
        const DataColumn2(label: Text('Featured')),
        DataColumn2(
          label: const Text('Date'),
          fixedWidth: DeviceUtility.isMobileScreen(context) ? null : 200,
        ),
        DataColumn2(
          label: const Text('Action'),
          fixedWidth: DeviceUtility.isMobileScreen(context) ? 100 : 100,
        ),
      ],
      source: BrandRows(),
    );
  }
}
