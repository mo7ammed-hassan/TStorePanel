import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/helper_functions.dart';

/// A custom paginated table widget.
class CustomPaginatedTable extends StatelessWidget {
  const CustomPaginatedTable({
    super.key,
    required this.columns,
    required this.source,
    this.sortAscending = false,
    this.sortColumnIndex,
    this.rowsPerPage = 10,
    this.tableheight = 760,
    this.minWidth = 1000,
    this.dataRowHeight = AppSizes.xl * 2,
    this.onPageChanged,
  });

  final bool sortAscending;
  final int? sortColumnIndex;
  final List<DataColumn> columns;
  final DataTableSource source;
  final int rowsPerPage;
  final double tableheight;
  final double minWidth;
  final double dataRowHeight;
  final Function(int)? onPageChanged;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return SizedBox(
      // set the dynamic height of the table
      height: tableheight,
      child: Theme(
        /// Use to set background color
        data: Theme.of(context).copyWith(
          cardTheme: CardTheme(
            color: isDark ? AppColors.black : AppColors.white,
            elevation: 0,
          ),
        ),
        child: PaginatedDataTable2(
          source: source,

          /// Columns & Rows
          columns: columns,
          columnSpacing: 12,
          minWidth: minWidth,
          dividerThickness: 0,
          horizontalMargin: 12,
          rowsPerPage: rowsPerPage,
          dataRowHeight: dataRowHeight,

          /// Checkbox
          //showCheckboxColumn: true,

          /// Pagination
          showFirstLastButtons: true,
          onPageChanged: onPageChanged,
          renderEmptyRowsInTheEnd: false,
          onRowsPerPageChanged: (value) => {},

          // Sorting
          sortAscending: sortAscending,
          sortArrowAlwaysVisible: true,
          sortArrowIcon: Icons.line_axis,
          sortColumnIndex: sortColumnIndex,
          sortArrowBuilder: (ascending, sorted) {
            if (sorted) {
              return Icon(
                ascending ? Iconsax.arrow_up_3 : Iconsax.arrow_down,
                size: AppSizes.iconSm,
              );
            } else {
              return const Icon(Iconsax.arrow_3, size: AppSizes.iconSm);
            }
          },

          // Header
          headingTextStyle: Theme.of(context).textTheme.titleMedium,
          headingRowColor: WidgetStateColor.resolveWith(
            (states) =>
                isDark ? AppColors.textPrimary : AppColors.primaryBackground,
          ),
          headingRowDecoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSizes.borderRadiusMd),
              topRight: Radius.circular(AppSizes.borderRadiusMd),
            ),
          ),
        ),
      ),
    );
  }
}
