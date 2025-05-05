import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/dashboard_card.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/pie_chart/order_status_pie_chart.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/tables/data_table.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/weekly_sales_graph.dart';

class DashboardTabletScreen extends StatelessWidget {
  const DashboardTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.spaceBtwItems),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dashboard',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // Cards
              const Row(
                children: [
                  Expanded(
                    child: DashboardCard(
                      title: 'Sales total',
                      subtitle: '\$1200.6',
                      stats: 25,
                    ),
                  ),
                  SizedBox(width: AppSizes.spaceBtwItems),
                  Expanded(
                    child: DashboardCard(
                      title: 'Average Order Value',
                      subtitle: '\$25',
                      stats: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              const Row(
                children: [
                  Expanded(
                    child: DashboardCard(
                      title: 'Total Orders',
                      subtitle: '36',
                      stats: 44,
                    ),
                  ),
                  SizedBox(width: AppSizes.spaceBtwItems),
                  Expanded(
                    child: DashboardCard(
                      title: 'Visitors',
                      subtitle: '25,035',
                      stats: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // GRAPHS
              const WeeklySalesGraph(),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // Resent Orders
              RoundedContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recent Orders',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: AppSizes.spaceBtwSections),
                    const DashboardOrdersTable(),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // Pie Chart
              const OrderStatusPieChart(),
            ],
          ),
        ),
      ),
    );
  }
}
