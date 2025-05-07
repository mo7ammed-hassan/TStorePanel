import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/helpers/helper_functions.dart';
import 'package:t_store_admin_panel/data/models/order_model.dart';
import 'package:t_store_admin_panel/data/models/user/cart_item_model.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial()) {
    _calculateWeeklySales();
    _calculateOrdersStatsData();
  }

  /// Weekly Sales
  List<double> weeklySales = <double>[];
  Map<OrderStatus, int> ordersStatsData = <OrderStatus, int>{};
  Map<OrderStatus, double> totalAmount = <OrderStatus, double>{};

  /// Orders
  final List<OrderModel> orders = [
    OrderModel(
      id: 'MWT001',
      status: OrderStatus.processing,
      totalAmount: 260,
      orderDate: DateTime.now().subtract(const Duration(days: 6)),
      deliveryDate: DateTime.now().add(const Duration(days: 10)),
      paymentMethod: PaymentMethods.paypal.name.toString(),
      cartItems: [
        CartItemModel(productId: '1', price: 100, quantity: 2),
        CartItemModel(productId: '202', price: 50, quantity: 1),
        CartItemModel(productId: '31', price: 75, quantity: 3),
      ],
    ),
    OrderModel(
      id: 'MWT0051',
      status: OrderStatus.processing,
      totalAmount: 200,
      orderDate: DateTime.now().subtract(const Duration(days: 5)),
      deliveryDate: DateTime.now().add(const Duration(days: 15)),
      paymentMethod: PaymentMethods.paypal.name.toString(),
      cartItems: [
        CartItemModel(productId: '1', price: 100, quantity: 2),
        CartItemModel(productId: '202', price: 50, quantity: 1),
        CartItemModel(productId: '31', price: 75, quantity: 3),
      ],
    ),
    OrderModel(
      id: 'MWT0012',
      status: OrderStatus.delivered,
      totalAmount: 240,
      orderDate: DateTime.now().subtract(const Duration(days: 4)),
      deliveryDate: DateTime.now().add(const Duration(days: 20)),
      paymentMethod: PaymentMethods.paypal.name.toString(),
      cartItems: [
        CartItemModel(productId: '1', price: 100, quantity: 2),
        CartItemModel(productId: '202', price: 50, quantity: 1),
        CartItemModel(productId: '31', price: 75, quantity: 3),
      ],
    ),
    OrderModel(
      id: 'MWT0013',
      status: OrderStatus.delivered,
      totalAmount: 645,
      orderDate: DateTime.now().subtract(const Duration(days: 3)),
      deliveryDate: DateTime.now().add(const Duration(days: 25)),
      paymentMethod: PaymentMethods.paypal.name.toString(),
      cartItems: [
        CartItemModel(productId: '1', price: 100, quantity: 2),
        CartItemModel(productId: '202', price: 50, quantity: 1),
        CartItemModel(productId: '31', price: 75, quantity: 3),
      ],
    ),
    OrderModel(
      id: 'MWT05015',
      status: OrderStatus.delivered,
      totalAmount: 150,
      orderDate: DateTime.now().subtract(const Duration(days: 2)),
      deliveryDate: DateTime.now().add(const Duration(days: 5)),
      paymentMethod: PaymentMethods.paypal.name.toString(),
      cartItems: [
        CartItemModel(productId: '1', price: 100, quantity: 2),
        CartItemModel(productId: '202', price: 50, quantity: 1),
        CartItemModel(productId: '31', price: 75, quantity: 3),
      ],
    ),
    OrderModel(
      id: 'MWT00515',
      status: OrderStatus.shipped,
      totalAmount: 150,
      orderDate: DateTime.now().subtract(const Duration(days: 1)),
      deliveryDate: DateTime.now().add(const Duration(days: 7)),
      paymentMethod: PaymentMethods.paypal.name.toString(),
      cartItems: [
        CartItemModel(productId: '1', price: 100, quantity: 2),
        CartItemModel(productId: '202', price: 50, quantity: 1),
        CartItemModel(productId: '31', price: 75, quantity: 3),
      ],
    ),
  ];
  // Calculate weekly sales
  void _calculateWeeklySales() {
    //debugPrint("🔍 _calculateWeeklySales triggered!");
    // Reset weekly sales to zero
    weeklySales = List<double>.filled(7, 0.0);

    // Calculate weekly sales
    for (var order in orders) {
      // get start of the week
      final DateTime orderWeekStart = HelperFunctions.getStartOfWeek(
        order.orderDate!,
      );
      // check if order date is in the same week or not
      if (orderWeekStart.isBefore(DateTime.now()) &&
          orderWeekStart.add(const Duration(days: 7)).isAfter(DateTime.now())) {
        // get index of the week
        int index = (orderWeekStart.weekday - 1) % 7;
        // ensure index is in the range of 0 to 6
        index = index < 0 ? index + 7 : index;
        // add order amount to the weekly sales
        weeklySales[index] += order.totalAmount!;
      }
    }
  }

  void _calculateOrdersStatsData() {
    ordersStatsData.clear();

    // Store the total amount of each status in the map
    totalAmount = {for (var status in OrderStatus.values) status: 0.0};

    for (var order in orders) {
      final status = order.status!;
      ordersStatsData[status] = (ordersStatsData[status] ?? 0) + 1;
      totalAmount[status] = (totalAmount[status] ?? 0) + order.totalAmount!;
    }
  }
}
