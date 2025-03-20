import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/features/banners/presentation/screens/all_banners/table/table_scource.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/tables/custom_paginated_table.dart';

class BannerDataTable extends StatelessWidget {
  const BannerDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaginatedTable(
      minWidth: 700,
      tableheight: DeviceUtility.isDesktopScreen(context) ? 760 : 600,
      dataRowHeight: 110,
      columns: const [
        DataColumn2(label: Text('Banner')),
        DataColumn2(label: Text('Redirect Screen')),
        DataColumn2(label: Text('Active'), fixedWidth: 50),
        DataColumn2(label: Text('Action'), fixedWidth: 100),
      ],
      source: BannerRows(),
    );
  }
}
