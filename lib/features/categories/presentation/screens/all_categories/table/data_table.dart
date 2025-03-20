import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/features/categories/presentation/screens/all_categories/table/table_source.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/tables/custom_paginated_table.dart';

class CategoryDataTable extends StatelessWidget {
  const CategoryDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaginatedTable(
      minWidth: 700,
      tableheight: DeviceUtility.isDesktopScreen(context) ? 760 : 600,
      columns: const [
        DataColumn2(label: Text('Category')),
        DataColumn2(label: Text('Parent Category')),
        DataColumn2(label: Text('Featured')),
        DataColumn2(label: Text('Date')),
        DataColumn2(label: Text('Action'), fixedWidth: 100),
      ],
      source: CategoryRows(),
    );
  }
}
